# Template for Formula/toppingctl.rb in ktoulgaridis/homebrew-tap (#22). Rendered by
# `scripts/package.sh render brew <tag> <sums> <out-dir>`, which fills in the
# placeholders from the release's SHA256SUMS.
class Toppingctl < Formula
  desc "Control the TOPPING E2x2 USB audio interface over HID"
  homepage "https://github.com/ktoulgaridis/toppingctl"
  version "0.1.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.1.2/toppingctl-v0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "3178aa2b7e4585fa50c586e4e3a4ca6e00ed5177a225ca73d6bc62b59836a271"
    end
    on_intel do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.1.2/toppingctl-v0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "cdb3aecdeaca5fc1725cd1f85486f48136217e45ada273417ecbddd5919af178"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.1.2/toppingctl-v0.1.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f0921db795c41b51ae8197ae7370ef5a20940fcc5f532664c2ca81836e345bb3"
    end
    on_intel do
      url "https://github.com/ktoulgaridis/toppingctl/releases/download/v0.1.2/toppingctl-v0.1.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6aa9d0d98def91ce7d03241787d34002901b41a5225e8326ac4298b4e8640648"
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
