# Template for Formula/toppingctl.rb in ktoulgaridis/homebrew-tap (#22). Rendered by
# `scripts/package.sh render brew <tag> <sums> <out-dir>`, which fills in the
# placeholders from the release's SHA256SUMS.
class Toppingctl < Formula
  desc "Control the TOPPING E2x2 USB audio interface over HID"
  homepage "https://github.com/ktoulgaridis/toppingctl"
  version "0.1.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.1.1/toppingctl-v0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "36b649dec81d6e7b8d724b4105b2b557cd5c02563e0cc7247e73b82cc31c2af3"
    end
    on_intel do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.1.1/toppingctl-v0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "7b8c176fabcd2374a329d4a141ef84b73310972f9d57623182e3fd5ee4b6ec8d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.1.1/toppingctl-v0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "16ed51522ae5c6e7da59612322e8e41887571e030ca615fab638b735d707c314"
    end
    on_intel do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.1.1/toppingctl-v0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b223b064caa693b22e025000ad7d7bec3b1de8322cc714bd4f27313cfaf2aecc"
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
