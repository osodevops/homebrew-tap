class KafkaBackup < Formula
  desc "CLI tool for Kafka backup and restore operations"
  homepage "https://github.com/osodevops/kafka-backup"
  version "0.17.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/kafka-backup/releases/download/v0.17.3/kafka-backup-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b15268017e6f249eed2673ca767d9ee23337503fcf36c2a05a5806456e1fae54"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/kafka-backup/releases/download/v0.17.3/kafka-backup-cli-x86_64-apple-darwin.tar.xz"
      sha256 "cd05cd013625b501d6a76d0b07480c69d35882eaa13b301ea6e330c58cf3d3d9"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/osodevops/kafka-backup/releases/download/v0.17.3/kafka-backup-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "7ffdc14a2d7419e522f5c0c38093f42cf27aea5df6d3b5c1759c2962bec3be7c"
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
