class KafkaBackup < Formula
  desc "CLI tool for Kafka backup and restore operations"
  homepage "https://github.com/osodevops/kafka-backup"
  version "0.27.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/kafka-backup/releases/download/v0.27.3/kafka-backup-cli-aarch64-apple-darwin.tar.xz"
      sha256 "fb7839b79f6268e11e0bd816e2cea059735bc59cdf666aeeeac8a9f46bb871de"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/kafka-backup/releases/download/v0.27.3/kafka-backup-cli-x86_64-apple-darwin.tar.xz"
      sha256 "4d5c0840c66fab89af1073e010a33174de45f1f766c7c218d6618a4ba905ad4d"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/osodevops/kafka-backup/releases/download/v0.27.3/kafka-backup-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "58a0e791ae2f32960f9d97cff66b96ad9b2412122a1ab413e905ad4dff0b6bf7"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "kafka-backup"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "kafka-backup"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "kafka-backup"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
