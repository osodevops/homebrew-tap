class KafkaBackupEnterprise < Formula
  desc "Enterprise Kafka backup — Schema Registry, RBAC, encryption. 14-day free trial."
  homepage "https://kafkabackup.com/enterprise"
  version "0.6.0"
  license "LicenseRef-Proprietary"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.6.0/kafka-backup-aarch64-macos.tar.gz"
      sha256 "a2a1080e1f4329e08f9b73f467eed9c67289fe2229420f9d964bf73e2cc339f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.6.0/kafka-backup-x86_64-macos.tar.gz"
      sha256 "a46373d051c4b49243899e1488740ecd30287b2f15f655db9da3cecd70d0f86c"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.6.0/kafka-backup-x86_64-linux.tar.gz"
    sha256 "127278b68458a304a9e182ae8fdf3b9fc2bc61b245c7e8de6e21ef429530eea9"
  end

  def install
    bin.install "kafka-backup" => "kafka-backup-enterprise"
  end

  test do
    assert_match "kafka-backup 0.6.0", shell_output("#{bin}/kafka-backup-enterprise --version")
  end
end
