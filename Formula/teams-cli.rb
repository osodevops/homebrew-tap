class TeamsCli < Formula
  desc "Microsoft Teams CLI for AI agents and automation"
  homepage "http://msteamscli.com/"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.3.0/teams-v0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "2f95fddda425340b246948ae77af27eb0ba498a921bed52707e35a6e08ebca4b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.3.0/teams-v0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "d672cf0f80fe18c8020b8fa0937f87ff4d8dc4ccf93ce876abef69694bd6eccf"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.3.0/teams-v0.3.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9a7c3cbbf5ae6797f2b52ebb22af25c46b299f0937b60c950656cf6f26f64ae6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.3.0/teams-v0.3.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c236fe80382b3d679d8f81e573f045c6ce4eb5ee4f51e54bc97412c4cac2cd17"
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
