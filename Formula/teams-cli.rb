class TeamsCli < Formula
  desc "Microsoft Teams CLI for AI agents and automation"
  homepage "http://msteamscli.com/"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.8.0/teams-v0.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "2c972282fd564332e4b5a2207eea3a20d72bda951fba5b06707c0686978f4fa8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.8.0/teams-v0.8.0-x86_64-apple-darwin.tar.gz"
      sha256 "34291e49a663e4e730c656e2063f0e70edab5c2ebfdcb1eef71e3cfce3ee1a4c"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.8.0/teams-v0.8.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "68b354e2b2554f4ce0dff4fddbacfb3e6d94f8046804044d636280925b060347"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.8.0/teams-v0.8.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "36f9d9d2b7b6daaadf6e81f4d142da42808841aaeaf30863ec0b53558965bfdc"
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
