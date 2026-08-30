class TeamsCli < Formula
  desc "Microsoft Teams CLI for AI agents and automation"
  homepage "http://msteamscli.com/"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.5.0/teams-v0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "de466d8604d5ee0355b90336658fd4cb7fa96605580258a4c329b50ba092b365"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.5.0/teams-v0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "4d78cd23b428bd465894741692a5a117d8932d353231f8fa40063a5ac7620ad9"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.5.0/teams-v0.5.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f6924f2a418a506af3b8b5c6d6c19bde483cdd6f339f47eb5f166cb84341be1e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.5.0/teams-v0.5.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ade996011cc3dfb1958ffece2f59daa0a5a9cfe74c7fda857918419ee08869fb"
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
