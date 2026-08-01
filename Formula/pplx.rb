class Pplx < Formula
  desc "A fast Perplexity API CLI built in Rust"
  homepage "https://github.com/osodevops/perplexity-cli"
  version "0.3.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/perplexity-cli/releases/download/v0.3.3/pplx-aarch64-apple-darwin.tar.gz"
      sha256 "78800663bca744d32991eda3b87456894d1cb5477c0f9866b53065cb24e97afd"
    else
      url "https://github.com/osodevops/perplexity-cli/releases/download/v0.3.3/pplx-x86_64-apple-darwin.tar.gz"
      sha256 "e777edb088d0126a7ec23650b6aa084afdea958f105b7c985c7e1f8ddecea2ad"
    end
  end

  on_linux do
    url "https://github.com/osodevops/perplexity-cli/releases/download/v0.3.3/pplx-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "0abd52b0a3fdcc469441ef9dd60139900b8efc0957d695c84473d94883e3439b"
  end

  def install
    bin.install "pplx"
  end

  test do
    assert_match "pplx #{version}", shell_output("#{bin}/pplx --version")
  end
end
