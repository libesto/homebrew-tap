cask "unblock-pro" do
  arch arm: "arm64", intel: "x64"

  version "2.0.23"
  sha256 arm:   "18cba791d39bf5fe3e232b4ceb019f2fd35bf8b56047ef022749b7e41fd2b1c8",
         intel: "93bd556d5a959f2d25c914c0e5f8dfe464e727cbfe5fff1c8c97b7d570b50a09"

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
