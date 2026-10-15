class TeamsCli < Formula
  desc "Microsoft Teams CLI for AI agents and automation"
  homepage "http://msteamscli.com/"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.10.0/teams-v0.10.0-aarch64-apple-darwin.tar.gz"
      sha256 "74eacff504d522be3787263d0bdfb1e1f7c86e2216853280dd58354dd080a304"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.10.0/teams-v0.10.0-x86_64-apple-darwin.tar.gz"
      sha256 "c7779454c69fba9431453c54dff236536d03ea78c24952ecb3a99430379d3bab"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.10.0/teams-v0.10.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a89f2cba2533fbc73117500c88bd10930f2c72614f8f84f9c9f22473c9712414"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/ms-teams-cli/releases/download/v0.10.0/teams-v0.10.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8e57730a5ade12bef67ec406b3c9b1fb80081dc1a1fedcf050eda009aabc0325"
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
