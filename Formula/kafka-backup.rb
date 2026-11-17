class KafkaBackup < Formula
  desc "CLI tool for Kafka backup and restore operations"
  homepage "https://github.com/osodevops/kafka-backup"
  version "0.28.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/kafka-backup/releases/download/v0.28.1/kafka-backup-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d756ff902b7f82a1b79fe6a8c8dd8a1e1285a2dd97e12b06e2c7b1c71d30cb81"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/kafka-backup/releases/download/v0.28.1/kafka-backup-cli-x86_64-apple-darwin.tar.xz"
      sha256 "dffad360f923bc40291bf9adff1f3ea057ab64a0acf928b60a8ad73013668352"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/osodevops/kafka-backup/releases/download/v0.28.1/kafka-backup-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "b1f85dc5f50096ecc24ae1420eac0df461387cde034d321124c1c39c41a0c663"
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
