class K2i < Formula
  desc "CLI tool for Kafka to Iceberg streaming ingestion"
  homepage "https://github.com/osodevops/k2i"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/k2i/releases/download/v0.2.2/k2i-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b781b0e0a561090b1055abb74d6c6123bd0a112a90bb7c7a19d71182ea6275d2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/k2i/releases/download/v0.2.2/k2i-cli-x86_64-apple-darwin.tar.xz"
      sha256 "bb6fed93dedf43de7abeba56bc8adc45de67da123717bee158ecfe17716ff696"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/osodevops/k2i/releases/download/v0.2.2/k2i-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "8a093735c3c97b4d88d9da417255972c6f0880dc71b337578131f8bb2823b5c5"
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
