class KafkaBackupEnterprise < Formula
  desc "Enterprise Kafka backup — Schema Registry, RBAC, encryption. 14-day free trial."
  homepage "https://kafkabackup.com/enterprise"
  version "0.8.0"
  license "LicenseRef-Proprietary"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.8.0/kafka-backup-aarch64-macos.tar.gz"
      sha256 "a3b2df94ac392bced35327fb11d42253f6f6025dc5af253595ec085d027af5e1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.8.0/kafka-backup-x86_64-macos.tar.gz"
      sha256 "907dcbf60e02d669b18631691305c6f55f882f1abd8156abb22ba24da5f029bf"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.8.0/kafka-backup-x86_64-linux.tar.gz"
    sha256 "9fb197acdf7fc34cb46ca1203adc2c9bbf0761b21be113042ab7bc621a7004d9"
  end

  def install
    bin.install "kafka-backup" => "kafka-backup-enterprise"
  end

  test do
    assert_match "kafka-backup 0.8.0", shell_output("#{bin}/kafka-backup-enterprise --version")
  end
end
