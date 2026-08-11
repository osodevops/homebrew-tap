class KafkaBackup < Formula
  desc "CLI tool for Kafka backup and restore operations"
  homepage "https://github.com/osodevops/kafka-backup"
  version "0.16.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/kafka-backup/releases/download/v0.16.0/kafka-backup-cli-aarch64-apple-darwin.tar.xz"
      sha256 "6ca97abd8fa12b4224a3503427fd10af6cc4d494f285f13e80852363006782ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/kafka-backup/releases/download/v0.16.0/kafka-backup-cli-x86_64-apple-darwin.tar.xz"
      sha256 "715dffcfb425f346350814d37aa1b2f22953786c65233dbd38ee58f918b19178"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/osodevops/kafka-backup/releases/download/v0.16.0/kafka-backup-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "944bb18be39df843288781a9124e53b987e4915db954085f821a5aa1c5ed8bf1"
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
