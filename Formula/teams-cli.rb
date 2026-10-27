class TeamsCli < Formula
  desc "Microsoft Teams CLI for AI agents and automation"
  homepage "http://msteamscli.com/"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.11.0/teams-v0.11.0-aarch64-apple-darwin.tar.gz"
      sha256 "a32a51ce4cc283fdeff2c6d1d3e733625f9333986b040da4ecfa031c94836ae7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.11.0/teams-v0.11.0-x86_64-apple-darwin.tar.gz"
      sha256 "bbfaca7bce54e297d6430cd983cf427783a30b51bab2f67a065582fa7cc98d6e"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.11.0/teams-v0.11.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "575a8e4ee7abe8a1fa42a59a439697defb5496706c997c79819e0a226bc3f3e2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.11.0/teams-v0.11.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ba6f9cef943b5517a8f95cf72f6babcb94cab938058bdcc4c0a268a522509870"
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
