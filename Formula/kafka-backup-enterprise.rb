class KafkaBackupEnterprise < Formula
  desc "Enterprise Kafka backup — Schema Registry, RBAC, encryption. 14-day free trial."
  homepage "https://kafkabackup.com/enterprise"
  version "0.5.1"
  license "LicenseRef-Proprietary"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.5.1/kafka-backup-aarch64-macos.tar.gz"
      sha256 "1287fe02d14e12c51652170e1deb90538b1227c2ce8c9ac9bdafd7dca4d6fb52"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.5.1/kafka-backup-x86_64-macos.tar.gz"
      sha256 "d836aec4dd72dbd4406be4e04892e2db7b0aff83520085bd55ea5d9f83191581"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.5.1/kafka-backup-x86_64-linux.tar.gz"
    sha256 "94f29878eb2914f2199c9619c91309f7c3ee20e943ba08a105ad2fa2af53bf94"
  end

  def install
    bin.install "kafka-backup" => "kafka-backup-enterprise"
  end

  test do
    assert_match "kafka-backup 0.5.1", shell_output("#{bin}/kafka-backup-enterprise --version")
  end
end
