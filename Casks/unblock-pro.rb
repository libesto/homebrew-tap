cask "unblock-pro" do
  arch arm: "arm64", intel: "x64"

  version "2.0.20"
  sha256 arm:   "089f3c48b6a9eab1cefb8e06914a02b4a8b7b0e6b68e0bf989e4cf25f002f993",
         intel: "81215c90fcba1b46cd6b92d272489757216d786ba6d51369584fc2155f61a1ac"

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
