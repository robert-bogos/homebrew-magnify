cask "magnify" do
  version "1.0.0"
  sha256 "c7553ed7c8fa7a0b100debbc43ee7dafb17f7bce5b24102a2902154b17848038"

  url "https://github.com/robert-bogos/magnify/releases/download/v#{version}/magnify-v#{version}-arm64.tar.gz"
  name "Magnify"
  desc "System-wide magnifying glass for macOS"
  homepage "https://github.com/robert-bogos/magnify"

  depends_on macos: ">= :ventura"
  depends_on arch: :arm64

  app "Magnify.app"
  binary "magnify"

  postflight do
    # Ad-hoc signed, not notarized: the tarball download is quarantined by
    # Gatekeeper, which would otherwise block first launch with "cannot
    # verify developer". Clearing it here is the standard workaround for
    # unsigned indie casks.
    system_command "/usr/bin/xattr",
                    args: ["-dr", "com.apple.quarantine", "#{appdir}/Magnify.app"],
                    sudo: false
  end

  caveats <<~EOS
    Magnify is ad-hoc signed, not notarized by Apple.

    First launch requires Screen Recording permission:
      System Settings ▸ Privacy & Security ▸ Screen Recording ▸ enable Magnify

    Run it with:
      magnify --zoom 2 --size 320

    Quit via the 🔍 menu-bar icon, or: killall magnify
  EOS
end
