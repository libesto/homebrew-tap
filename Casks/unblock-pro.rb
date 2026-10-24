cask "unblock-pro" do
  arch arm: "arm64", intel: "x64"

  version "2.0.27"
  sha256 arm:   "5d80a7541a9d8af1fe1ea1281973d4ed84bcc97930b96d8182cb4d4205301bcf",
         intel: "3da622caed553ef9e2506e09ed2dde3a5c5a59087c4e8778563b12ade2c2d397"

  url "https://github.com/by-sonic/unblock-pro/releases/download/v#{version}/UnblockPro-#{version}-mac-#{arch}.zip",
      verified: "github.com/by-sonic/unblock-pro/"
  name "UnblockPro"
  desc "DPI bypass for Discord and YouTube"
  homepage "https://github.com/by-sonic/unblock-pro"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true

  app "UnblockPro.app"

  uninstall quit: "com.sonic.unblockpro"

  zap trash: [
    "~/Library/Application Support/UnblockPro",
    "~/Library/Caches/com.sonic.unblockpro",
    "~/Library/Logs/UnblockPro",
    "~/Library/Preferences/com.sonic.unblockpro.plist",
    "~/Library/Saved Application State/com.sonic.unblockpro.savedState",
  ]
end
