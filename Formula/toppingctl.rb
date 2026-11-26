# Template for Formula/toppingctl.rb in ktoulgaridis/homebrew-tap (#22). Rendered by
# `scripts/package.sh render brew <tag> <sums> <out-dir>`, which fills in the
# placeholders from the release's SHA256SUMS.
class Toppingctl < Formula
  desc "Control the TOPPING E2x2 USB audio interface over HID"
  homepage "https://github.com/ktoulgaridis/toppingctl"
  version "0.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.3.0/toppingctl-v0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "12c515638f8095273e21b246e0297b845351226d1f01c2279395c8968be901cf"
    end
    on_intel do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.3.0/toppingctl-v0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "ce53a895a613feda533aa6bba1b97302e346d4c6cc1884ad74af7f2d5c770164"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.3.0/toppingctl-v0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ac1dd6a6e13933789f6fce9dff0fd4ded934d6a68aebc5fc6fb880a913658488"
    end
    on_intel do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.3.0/toppingctl-v0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "27248282a8724dcc6e528469429e18bd32d909e1281fc9dddefdeeb343419721"
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
