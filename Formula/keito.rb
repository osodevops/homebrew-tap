class Keito < Formula
  desc "CLI for AI agents and humans to track billable time against Keito"
  homepage "https://github.com/osodevops/keito-cli"
  version "0.1.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/keito-cli/releases/download/v0.1.9/keito-aarch64-apple-darwin.tar.gz"
      sha256 "9db7ed9b26e4b8307b3cd64d3818b725995b08311e1d93cc6046f88f041a6222"
    else
      url "https://github.com/osodevops/keito-cli/releases/download/v0.1.9/keito-x86_64-apple-darwin.tar.gz"
      sha256 "c74c4d89bd4d0bb6075303a85830210698f439db02ae862c84f9ffa5cc03e9c6"
    end
  end

  on_linux do
    url "https://github.com/osodevops/keito-cli/releases/download/v0.1.9/keito-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "4a0b15a1eda961df7349e67edd83cc8f3b9a6f5614c3a50a85332c464e3028e1"
  end

  def install
    bin.install "keito"
  end

  test do
    assert_match "keito #{version}", shell_output("#{bin}/keito --version")
  end
end
