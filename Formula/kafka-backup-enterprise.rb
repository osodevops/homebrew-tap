class KafkaBackupEnterprise < Formula
  desc "Enterprise Kafka backup — Schema Registry, RBAC, encryption. 14-day free trial."
  homepage "https://kafkabackup.com/enterprise"
  version "0.7.0"
  license "LicenseRef-Proprietary"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.7.0/kafka-backup-aarch64-macos.tar.gz"
      sha256 "42d24415d96d51c01995d21c4db0a0202e023fae0845df2176a612e9094bc45a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.7.0/kafka-backup-x86_64-macos.tar.gz"
      sha256 "c6415517d461f5de966e28e9e3cd53328b38c9dff3bcc7435c357c668c41025f"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.7.0/kafka-backup-x86_64-linux.tar.gz"
    sha256 "676707c6484fbaccc3d8d2284401e4114c0a6cd0bb446e68dc35376e4d1e80b8"
  end

  def install
    bin.install "kafka-backup" => "kafka-backup-enterprise"
  end

  test do
    assert_match "kafka-backup 0.7.0", shell_output("#{bin}/kafka-backup-enterprise --version")
  end
end
