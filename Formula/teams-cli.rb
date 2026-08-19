class TeamsCli < Formula
  desc "Microsoft Teams CLI for AI agents and automation"
  homepage "http://msteamscli.com/"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.4.0/teams-v0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "6e1059c9297dc1858364dc4af7a965230b7b32d3c1de30d561c7ce7d69af3001"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.4.0/teams-v0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "4266532bce640904f11620d51c64e191e60dff9ca5301fbbeb4c60fd85e3968f"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.4.0/teams-v0.4.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1f0ef6d6bfb3d627124f0323f2df56ecafb018d9a27acef3d33f714906b3bc4a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.4.0/teams-v0.4.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c45388e59c12302a415c1a5fcdd1e89fd67e973e5e5f7afe7436e17075b35ba4"
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
