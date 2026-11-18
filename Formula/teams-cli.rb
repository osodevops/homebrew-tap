class TeamsCli < Formula
  desc "Microsoft Teams CLI for AI agents and automation"
  homepage "http://msteamscli.com/"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.12.1/teams-v0.12.1-aarch64-apple-darwin.tar.gz"
      sha256 "6e1a2a23bf530d429007377a123902cf82d132aab4aa8264b2dda9356416841c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.12.1/teams-v0.12.1-x86_64-apple-darwin.tar.gz"
      sha256 "3c3006e104c1d5d81a3010153057eaa6cb2df9f36108be7413f46e89bfbebf50"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.12.1/teams-v0.12.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "cc10d265848a05c3da0a19d76fdd6cc3d509d015827cb51e76dd714776d92558"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.12.1/teams-v0.12.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6bfa14f389039ed16ab17f9e81c40a78147597a9a5856dd96775c824a25ab861"
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
