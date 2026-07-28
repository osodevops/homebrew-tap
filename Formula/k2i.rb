class K2i < Formula
  desc "CLI tool for Kafka to Iceberg streaming ingestion"
  homepage "https://github.com/osodevops/k2i"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/k2i/releases/download/v0.3.0/k2i-cli-aarch64-apple-darwin.tar.xz"
      sha256 "049eed449d5a65781f925db2b8d790bc76d2ab54d194e9d653dfff137b4d7a46"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/k2i/releases/download/v0.3.0/k2i-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f09f5264dc287b63f5a98022ae76fc31448288d62d1b0e11e669c6952986b6ae"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/osodevops/k2i/releases/download/v0.3.0/k2i-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "1e7496ba8f44cf8b38a054d8c43aebb574300848a074c6d4cb6f0236f2e42358"
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-unknown-linux-gnu": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "k2i" if OS.mac? && Hardware::CPU.arm?
    bin.install "k2i" if OS.mac? && Hardware::CPU.intel?
    bin.install "k2i" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end

  test do
    assert_match "k2i", shell_output("#{bin}/k2i --help")
  end
end
