cask "unblock-pro" do
  arch arm: "arm64", intel: "x64"

  version "2.0.22"
  sha256 arm:   "10f361ae073999f2b63be6ebf61cf5a2df9f82406d75d7d1bcf3b1c13cac8710",
         intel: "e1f47b672acfc2e104298c720e695086a8572fcfa2d8fdf2d0d0e6956eef6dac"

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
