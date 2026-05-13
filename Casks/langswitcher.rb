cask "langswitcher" do
  version "1.1.0"
  sha256 "1f6297467d7048b55172bb9d5649f590fee802bf02d8fcf54caef9ee8312ae69"

  url "https://github.com/reg2005/langSwitcher/releases/download/v#{version}/LangSwitcher-#{version}-universal.dmg",
      verified: "github.com/reg2005/langSwitcher/"
  name "LangSwitcher"
  desc "Keyboard layout text converter for macOS"
  homepage "https://github.com/reg2005/langSwitcher"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "LangSwitcher.app"

  uninstall quit: "com.langswitcher.app"

  zap trash: [
    "~/Library/Application Support/LangSwitcher",
    "~/Library/Preferences/com.langswitcher.app.plist",
  ]
end
