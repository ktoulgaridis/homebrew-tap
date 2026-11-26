# Template for Formula/toppingctl.rb in ktoulgaridis/homebrew-tap (#22). Rendered by
# `scripts/package.sh render brew <tag> <sums> <out-dir>`, which fills in the
# placeholders from the release's SHA256SUMS.
class Toppingctl < Formula
  desc "Control the TOPPING E2x2 USB audio interface over HID"
  homepage "https://github.com/ktoulgaridis/toppingctl"
  version "0.2.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.2.1/toppingctl-v0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "524a66062e9bd09c27adc4906e3e363458ef870c4856c8f6db830d869e4da039"
    end
    on_intel do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.2.1/toppingctl-v0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "402e134de11d9605f732e811ad43fdfe9ce860f0acd741746791615c4a3dea0a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.2.1/toppingctl-v0.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "64d1a58e9a92e7126b0214af16b1d430ead029f10b13530b1f4b08d6bc86af3b"
    end
    on_intel do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.2.1/toppingctl-v0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "084e813481777e3b4c3716d088132925df9e77f9a0c4d786d014cdf852846bb3"
    end
  end

  def install
    bin.install "toppingctl"
    # Homebrew can't write /usr/lib/udev; ship the rule for the user to install.
    pkgshare.install "packaging/linux/70-toppingctl.rules" if OS.linux?
  end

  def caveats
    return unless OS.linux?

    <<~EOS
      To use the E2x2 without sudo, install the udev rule and replug the device:
        sudo install -m 0644 #{opt_pkgshare}/70-toppingctl.rules /etc/udev/rules.d/
        sudo udevadm control --reload && sudo udevadm trigger
    EOS
  end

  test do
    assert_match "toppingctl #{version}", shell_output("#{bin}/toppingctl --version")
  end
end
