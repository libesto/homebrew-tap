cask "unblock-pro" do
  arch arm: "arm64", intel: "x64"

  version "2.0.26"
  sha256 arm:   "5c6314177581b662ef14c58dd8e2ebe2ee03ca2471041a0519bfa0db94267117",
         intel: "26097a754f25490201f1b61ce5039e3a853d84de88f42c933971de9e6ad71af2"

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
