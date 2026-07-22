class RabbitmqBackup < Formula
  desc "CLI tool for RabbitMQ backup and restore operations"
  homepage "https://rabbitmqbackup.com/"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/rabbitmq-backup/releases/download/v0.2.0/rabbitmq-backup-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c3bb8ae01bc036d5f66a7ba2105d525128890a444518fca22e4afe5645dd7f5a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/rabbitmq-backup/releases/download/v0.2.0/rabbitmq-backup-cli-x86_64-apple-darwin.tar.xz"
      sha256 "fa9a24b7e6940bb554d69aec239199978ab3768e9f108ba60cfcad41bcb3a9c2"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/osodevops/rabbitmq-backup/releases/download/v0.2.0/rabbitmq-backup-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "ddefd14a347efeb7029a177cbbb1e9a872fdc298c2a8242ca55f5c6806aa24f0"
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
    bin.install "rabbitmq-backup" if OS.mac? && Hardware::CPU.arm?
    bin.install "rabbitmq-backup" if OS.mac? && Hardware::CPU.intel?
    bin.install "rabbitmq-backup" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
