class TeamsCli < Formula
  desc "Microsoft Teams CLI for AI agents and automation"
  homepage "http://msteamscli.com/"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.7.0/teams-v0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "e981fdaafe6dc57ec640add617aa494e358d923121bba811e7a6f27547aeaafb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.7.0/teams-v0.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "221a3d4075093dab63b74c83f281eb82a5f46cfda98b976c690b4c1a5cfe4a88"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.7.0/teams-v0.7.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "29c6e1b2daee2b9ca95f93bcd26b6a6443523c63b487e7dc79e1434bf4830863"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.7.0/teams-v0.7.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7d98c55ee3d85846edf4d4c4f84e0450f1b21e46ceb0870f13a33aefd01ab61d"
    end
  end

  def install
    bin.install "bin/teams"
    man1.install "share/man/man1/teams.1"
    man5.install "share/man/man5/teams-config.5"
    man7.install Dir["share/man/man7/*.7"]
    doc.install Dir["share/doc/teams/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/teams --version")
    assert_match "Microsoft Teams CLI", shell_output("#{bin}/teams --help")
  end
end
