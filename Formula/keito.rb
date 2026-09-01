class Keito < Formula
  desc "CLI for AI agents and humans to track billable time against Keito"
  homepage "https://github.com/osodevops/keito-cli"
  version "0.1.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/osodevops/keito-cli/releases/download/v0.1.8/keito-aarch64-apple-darwin.tar.gz"
      sha256 "3e218568c78daf011edf958f7bb1d77207326d9b9916008fda750cbb66e4b383"
    else
      url "https://github.com/osodevops/keito-cli/releases/download/v0.1.8/keito-x86_64-apple-darwin.tar.gz"
      sha256 "41c7892a71ee265ec9e738d300be63e1f061fee6cd94a255a199ef8e47bc7a15"
    end
  end

  on_linux do
    url "https://github.com/osodevops/keito-cli/releases/download/v0.1.8/keito-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "f7c1a294f8cda5a9ac312e252aa3eae781d4c604bef33502f80460cb7fe556da"
  end

  def install
    bin.install "keito"
  end

  test do
    assert_match "keito #{version}", shell_output("#{bin}/keito --version")
  end
end
