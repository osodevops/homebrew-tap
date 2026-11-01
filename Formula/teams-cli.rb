class TeamsCli < Formula
  desc "Microsoft Teams CLI for AI agents and automation"
  homepage "http://msteamscli.com/"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.12.0/teams-v0.12.0-aarch64-apple-darwin.tar.gz"
      sha256 "031296c8998b52adda69ac2a0762b4f918bf2efb9d829ff7b4e47d402a8c40c1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.12.0/teams-v0.12.0-x86_64-apple-darwin.tar.gz"
      sha256 "cf645e76a73f355065acf0273f3f6be840acabae84e58a5861847f73d0a884d9"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.12.0/teams-v0.12.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "79fedc8564bd0c6adbd671dce7458670f24035496cd89a42f850b56d68e1a2d2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.12.0/teams-v0.12.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f1220a7e21b23960520d749bd2a5e8b33f5a1e36548cbd0e8f84d9cfab95268c"
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
