# Template for Formula/toppingctl.rb in ktoulgaridis/homebrew-tap (#22). Rendered by
# `scripts/package.sh render brew <tag> <sums> <out-dir>`, which fills in the
# placeholders from the release's SHA256SUMS.
class Toppingctl < Formula
  desc "Control the TOPPING E2x2 USB audio interface over HID"
  homepage "https://github.com/ktoulgaridis/toppingctl"
  version "0.2.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.2.2/toppingctl-v0.2.2-aarch64-apple-darwin.tar.gz"
      sha256 "2ec94a4b67fd409e8710fc82ac8ac8a7936b2c473639f489537d68814952511c"
    end
    on_intel do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.2.2/toppingctl-v0.2.2-x86_64-apple-darwin.tar.gz"
      sha256 "99b1ab5492da53f6ef5f2690ae217da0eb05e39d3970c7c08f6705e986692a4c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.2.2/toppingctl-v0.2.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "12f53ba4966ebee0f9dddb36ea3b3da765a19c0d271af0a0c2a5a61013e63897"
    end
    on_intel do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.2.2/toppingctl-v0.2.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "096224f5cd04cd2e6b741be20ea99ca4122d9e8daf8f2fb5d6115d2338a51cf3"
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
