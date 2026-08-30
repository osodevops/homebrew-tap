class TeamsCli < Formula
  desc "Microsoft Teams CLI for AI agents and automation"
  homepage "http://msteamscli.com/"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.6.0/teams-v0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "250404ef72ff23a913ba0bb3b345260767e160e082cab8f974294dd3c639753c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.6.0/teams-v0.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "8bd7cd7b38665d680b400969210b4db2ad1a57458f233d6a325a4769baf60a4d"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.6.0/teams-v0.6.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "40d67a42740e5375f87a3d40094fb8732d808de7b6b6aef71199810b72cd23d8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.6.0/teams-v0.6.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "51cc35f83f22fb3b489e6cb8ade8b33b4e5c37f6ffadc9f79e20d670e097d244"
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
