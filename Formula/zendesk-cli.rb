class ZendeskCli < Formula
  desc "OAuth-first CLI for Zendesk support operations, scripts and AI agents"
  homepage "https://github.com/osodevops/zendesk-cli"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/zendesk-cli/releases/download/v0.1.2/zdk-v0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "5502af4e01d458c49471089f31271a96045d9993d3e8e8ed29d454ad55d8b60c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/zendesk-cli/releases/download/v0.1.2/zdk-v0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "ce1aa71bd6bef027553a3ea80faa852c28cb14ad5b353e5a06b5ccb107358614"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/zendesk-cli/releases/download/v0.1.2/zdk-v0.1.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "76c10bab8b32629ed6775c53eb7af2e38846f0a52c08dea17d5d09b08b4535b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/osodevops/zendesk-cli/releases/download/v0.1.2/zdk-v0.1.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "dafe68ed8c34d9b5f271c5a5941b74af3de42108a6edcb51fc3bbd22426f3964"
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
