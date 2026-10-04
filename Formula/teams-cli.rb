class TeamsCli < Formula
  desc "Microsoft Teams CLI for AI agents and automation"
  homepage "http://msteamscli.com/"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.9.0/teams-v0.9.0-aarch64-apple-darwin.tar.gz"
      sha256 "889cd62898088775595188e8168523b3e25ebb0fb877389c4a51f92e3a29e9d2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.9.0/teams-v0.9.0-x86_64-apple-darwin.tar.gz"
      sha256 "1f1c841e400f4488542a388988cf1a51199be6734bdb8b089da56f02824f30dc"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.9.0/teams-v0.9.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8f980f3eb90946bc4eca4bbbdec05ffed1fe7410914f231c438e1fe47ebdec56"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.9.0/teams-v0.9.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b9b20c577497f25afe1329697a56ed17d6ba0e547ee38e2c1c8bf53050831612"
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
