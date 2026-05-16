cask "unblock-pro" do
  arch arm: "arm64", intel: "x64"

  version "2.0.16"
  sha256 arm:   "25a12ab89bfdfd6fce4bf2d8ced75441fce9abc1f4719b07a32063c9ce76a2ea",
         intel: "27637e7c10d996e35538d2c2192a58de7ce8c8fbefd6b54e78e4e47667da50f8"

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
