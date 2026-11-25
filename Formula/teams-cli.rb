class TeamsCli < Formula
  desc "Microsoft Teams CLI for AI agents and automation"
  homepage "http://msteamscli.com/"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.13.0/teams-v0.13.0-aarch64-apple-darwin.tar.gz"
      sha256 "d54e204a8db4cf0bafda3450c7530fd7900cf71581a383421d5ca7dd642562f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.13.0/teams-v0.13.0-x86_64-apple-darwin.tar.gz"
      sha256 "45c9e500095f19a1ed44bdc9b627186042eef4c9548399715b28b242f6e10984"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.13.0/teams-v0.13.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5484113f9343ed8b33e48c0d30aca3d63bc6e136956e42718bf97ac6ce6c7793"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.13.0/teams-v0.13.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a3a5ef902903b0b3a95f76a5a152df6522e9ebafb24f4fb00a69b73e1548d3d7"
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
