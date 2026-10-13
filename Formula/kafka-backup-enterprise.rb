class KafkaBackupEnterprise < Formula
  desc "Enterprise Kafka backup — Schema Registry, RBAC, encryption. 14-day free trial."
  homepage "https://kafkabackup.com/enterprise"
  version "0.6.1"
  license "LicenseRef-Proprietary"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.6.1/kafka-backup-aarch64-macos.tar.gz"
      sha256 "784c5e157efd0176037e8cf63055d4d4a9c1130658fb4a8abd5f665218b57a34"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.6.1/kafka-backup-x86_64-macos.tar.gz"
      sha256 "637277aef0c95cd96bc63ddbed2c9c427217b0ea9c51d42e3a8af083196f7883"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.6.1/kafka-backup-x86_64-linux.tar.gz"
    sha256 "7145554ae1b8688951957250645850b3982b954be4751cc607a68dc11af0fd8c"
  end

  def install
    bin.install "kafka-backup" => "kafka-backup-enterprise"
  end

  test do
    assert_match "kafka-backup 0.6.1", shell_output("#{bin}/kafka-backup-enterprise --version")
  end
end
