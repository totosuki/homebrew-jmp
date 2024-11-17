class Jmp < Formula
  desc "A command-line tool to jump(jmp) between directories"
  homepage "https://github.com/totosuki/homebrew-jmp"
  url "https://github.com/totosuki/homebrew-jmp/archive/refs/tags/v1.0.tar.gz"
  sha256 "17a41d7c5e5e5c9e04daf0132ef255fc1e1d0821b05f4c8e69de17571fa38a28"
  license "MIT"

  depends_on "fzf"

  def install
    bin.install "jmp.sh" => "jmp"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/jmp --help", 1)
  end
end