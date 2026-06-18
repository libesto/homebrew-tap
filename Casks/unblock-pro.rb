cask "unblock-pro" do
  arch arm: "arm64", intel: "x64"

  version "2.0.18"
  sha256 arm:   "a3bae1b538b3b5b3bfc106fe84f2e1d7c28b869dedeced0b6ac932b949a1b7ed",
         intel: "434b776d5f2e6af567c2c1800fc8c9c792d330dd6ae44b18b9b50d016bbde1f8"

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
