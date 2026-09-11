class ZendeskCli < Formula
  desc "OAuth-first CLI for Zendesk support operations, scripts and AI agents"
  homepage "https://github.com/osodevops/zendesk-cli"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/zendesk-cli/releases/download/v0.0.0/zdk-v0.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/zendesk-cli/releases/download/v0.0.0/zdk-v0.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/zendesk-cli/releases/download/v0.0.0/zdk-v0.0.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/zendesk-cli/releases/download/v0.0.0/zdk-v0.0.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "bin/zdk"
    man1.install Dir["share/man/man1/*.1"]
    bash_completion.install "share/completions/zdk.bash" => "zdk"
    zsh_completion.install "share/completions/_zdk"
    fish_completion.install "share/completions/zdk.fish"
    doc.install Dir["share/doc/zendesk-cli/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zdk --version")
    assert_match "Zendesk", shell_output("#{bin}/zdk --help")
  end
end
