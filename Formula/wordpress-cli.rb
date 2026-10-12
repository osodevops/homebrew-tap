class WordpressCli < Formula
  desc "Rust-native WordPress CLI for AI agents & humans"
  homepage "https://github.com/osodevops/wordpress-cli"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/wordpress-cli/releases/download/v0.3.0/wpx-aarch64-apple-darwin.tar.gz"
      sha256 "c7a43a6b9c3daddb755840eae3a9c65a3aa41016cc5fab8b971f25fc285e8ea5"
    else
      url "https://github.com/osodevops/wordpress-cli/releases/download/v0.3.0/wpx-x86_64-apple-darwin.tar.gz"
      sha256 "a7c780f6624da94121385e273b3a3b31057239effb74b998f2e73d3f52c0350f"
    end
  end

  on_linux do
    url "https://github.com/osodevops/wordpress-cli/releases/download/v0.3.0/wpx-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "d040dc9c70f47d8a1fb1f65f9d012b606b77b6976362d2fc6de96583869067e2"
  end

  def install
    bin.install "wpx"
  end

  test do
    assert_match "wpx", shell_output("#{bin}/wpx --version")
  end
end
