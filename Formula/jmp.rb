class Jmp < Formula
  desc "A command-line tool to jump(jmp) between directories"
  homepage "https://github.com/totosuki/jmp"
  url "https://github.com/totosuki/jmp/archive/refs/tags/v1.0.tar.gz"
  sha256 "e65e49bfd71efb8b3c609fbca1f46c2f2c8b177e08b4e4590d260c7e252edfc9"
  license "MIT"

  def install
    bin.install "jmp.sh" => "jmp"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/jmp --help", 1)
  end
end