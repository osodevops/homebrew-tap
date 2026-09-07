class KafkaBackupEnterprise < Formula
  desc "Enterprise Kafka backup — Schema Registry, RBAC, encryption. 14-day free trial."
  homepage "https://kafkabackup.com/enterprise"
  version "0.5.0"
  license "LicenseRef-Proprietary"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.5.0/kafka-backup-aarch64-macos.tar.gz"
      sha256 "49f7f1dc390d40038648bd8f6b10204868064fa6d5375c28c51b31e949bbcd04"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.5.0/kafka-backup-x86_64-macos.tar.gz"
      sha256 "05277186d097e9382bb5bb1c7a93f975a52d49256b53525380a43d4e077c8a6b"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.5.0/kafka-backup-x86_64-linux.tar.gz"
    sha256 "1f2d2af55295c00f3914bf72f953453df009830dca2f12f7ed9623b6c333c9cc"
  end

  def install
    bin.install "kafka-backup" => "kafka-backup-enterprise"
  end

  test do
    assert_match "kafka-backup 0.5.0", shell_output("#{bin}/kafka-backup-enterprise --version")
  end
end
