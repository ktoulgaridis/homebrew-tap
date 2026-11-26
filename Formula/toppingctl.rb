# Template for Formula/toppingctl.rb in ktoulgaridis/homebrew-tap (#22). Rendered by
# `scripts/package.sh render brew <tag> <sums> <out-dir>`, which fills in the
# placeholders from the release's SHA256SUMS.
class Toppingctl < Formula
  desc "Control the TOPPING E2x2 USB audio interface over HID"
  homepage "https://github.com/ktoulgaridis/toppingctl"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.2.0/toppingctl-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "47534dca3f6931dab9cd0b20644b52f1d41dffc4354489ddb30e7e64515c68ba"
    end
    on_intel do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.2.0/toppingctl-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "52c6072a4e44dd4400700e22547dc17858244448753e1af1e7045d24d899db22"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.2.0/toppingctl-v0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "23a8f6bd2bb9118a35c915f98bf404fffdf93bebcdd556785b1e9d7166f4c89b"
    end
    on_intel do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.2.0/toppingctl-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "18bc05f8939e22465daf9908571a798f9eaebc47adbaf8f53da14a2d0143e6df"
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
