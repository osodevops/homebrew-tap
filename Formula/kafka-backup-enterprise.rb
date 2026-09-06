class KafkaBackupEnterprise < Formula
  desc "Enterprise Kafka backup — Schema Registry, RBAC, encryption. 14-day free trial."
  homepage "https://kafkabackup.com/enterprise"
  version "0.4.0"
  license "LicenseRef-Proprietary"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.4.0/kafka-backup-aarch64-macos.tar.gz"
      sha256 "8e5a00eaa583546fd4a6723f26b06f3a8295d0184525cdb909fd6675123e80d6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.4.0/kafka-backup-x86_64-macos.tar.gz"
      sha256 "3f0ce03c3f8158910e3bcd78c3cc5b667be7f525cf427a418772f34484de825e"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/osodevops/kafka-backup-enterprise-releases/releases/download/v0.4.0/kafka-backup-x86_64-linux.tar.gz"
    sha256 "b9bce0268a5eaa1d8d039ca2e7ec2a0781ac5bbc8333452658c8c6cfb72853f6"
  end

  def install
    bin.install "kafka-backup" => "kafka-backup-enterprise"
  end

  test do
    assert_match "kafka-backup 0.4.0", shell_output("#{bin}/kafka-backup-enterprise --version")
  end
end
