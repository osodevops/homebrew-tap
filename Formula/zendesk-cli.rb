class ZendeskCli < Formula
  desc "OAuth-first CLI for Zendesk support operations, scripts and AI agents"
  homepage "https://github.com/osodevops/zendesk-cli"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/zendesk-cli/releases/download/v0.1.0/zdk-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "83d6c2027088c8c3d9bcf7151cbe4aace4619bdb6e26314a3a8081c2415e74de"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/zendesk-cli/releases/download/v0.1.0/zdk-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "3a82fc5727608224e2ae055cbe21b6d2eac8965374dd2ff4e6df801c03c43561"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/zendesk-cli/releases/download/v0.1.0/zdk-v0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8890d1ff5de56ab3f8302bca48063926fafbd95fa9fae5b71d1059d7b86afba2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/zendesk-cli/releases/download/v0.1.0/zdk-v0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f13d5d43608805ab0cbf528cc18614c4642f1856c6ad92e56c845c6cfb7c63a0"
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
