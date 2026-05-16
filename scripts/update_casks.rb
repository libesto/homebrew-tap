#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "net/http"
require "uri"

ROOT = File.expand_path("..", __dir__)

CASKS = [
  {
    path: "Casks/langswitcher.rb",
    repo: "reg2005/langSwitcher",
    version_regex: /version "([^"]+)"/,
    sha_regex: /sha256 "([a-f0-9]{64})"/,
    assets: {
      universal: /^LangSwitcher-(?<version>.+)-universal\.dmg$/,
    },
  },
  {
    path: "Casks/unblock-pro.rb",
    repo: "by-sonic/unblock-pro",
    version_regex: /version "([^"]+)"/,
    sha_regex: /sha256 arm:\s+"([a-f0-9]{64})",\n\s+intel: "([a-f0-9]{64})"/,
    assets: {
      arm: /^UnblockPro-(?<version>.+)-mac-arm64\.zip$/,
      intel: /^UnblockPro-(?<version>.+)-mac-x64\.zip$/,
    },
  },
].freeze

def latest_release(repo)
  uri = URI("https://api.github.com/repos/#{repo}/releases/latest")
  request = Net::HTTP::Get.new(uri)
  request["Accept"] = "application/vnd.github+json"
  request["User-Agent"] = "libesto-homebrew-tap-cask-updater"
  request["Authorization"] = "Bearer #{ENV.fetch("GITHUB_TOKEN")}" if ENV["GITHUB_TOKEN"]

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(request)
  end

  unless response.is_a?(Net::HTTPSuccess)
    raise "GitHub API request failed for #{repo}: #{response.code} #{response.body}"
  end

  JSON.parse(response.body)
end

def sha256(asset)
  digest = asset.fetch("digest")
  raise "Unsupported digest format for #{asset.fetch("name")}: #{digest}" unless digest.start_with?("sha256:")

  digest.delete_prefix("sha256:")
end

def find_asset(release, name_regex)
  release.fetch("assets").find { |asset| asset.fetch("name").match?(name_regex) } ||
    raise("Asset matching #{name_regex.inspect} not found in #{release.fetch("html_url")}")
end

def asset_version(asset, name_regex)
  match = asset.fetch("name").match(name_regex)
  raise "Asset #{asset.fetch("name")} did not match #{name_regex.inspect}" unless match

  match[:version]
end

def update_cask(cask)
  release = latest_release(cask.fetch(:repo))
  assets = cask.fetch(:assets).transform_values { |regex| find_asset(release, regex) }
  versions = assets.map { |key, asset| [key, asset_version(asset, cask.fetch(:assets).fetch(key))] }.to_h
  version = versions.values.uniq.tap do |values|
    raise "Mismatched asset versions for #{cask.fetch(:repo)}: #{versions.inspect}" unless values.one?
  end.first

  path = File.join(ROOT, cask.fetch(:path))
  content = File.read(path)
  updated = content.sub(cask.fetch(:version_regex), %(version "#{version}"))

  updated =
    if assets.key?(:universal)
      updated.sub(cask.fetch(:sha_regex), %(sha256 "#{sha256(assets.fetch(:universal))}"))
    else
      updated.sub(
        cask.fetch(:sha_regex),
        %(sha256 arm:   "#{sha256(assets.fetch(:arm))}",\n         intel: "#{sha256(assets.fetch(:intel))}")
      )
    end

  if updated == content
    puts "#{cask.fetch(:path)} already up to date (#{version})"
    return
  end

  File.write(path, updated)
  puts "Updated #{cask.fetch(:path)} to #{version}"
end

CASKS.each { |cask| update_cask(cask) }
