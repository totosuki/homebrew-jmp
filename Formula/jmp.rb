class Jmp < Formula
  desc "A command-line tool to jump(jmp) between directories"
  homepage "https://github.com/totosuki/homebrew-jmp"
  url "https://github.com/totosuki/homebrew-jmp/archive/refs/tags/v1.1.tar.gz"
  sha256 "5ce2f05304f78ad576c666bbdefa3e8fdc82c34bb6e1aadfb79fecf0c62d324c"
  license "MIT"

  depends_on "fzf"

  def install
    bin.install "jmp.sh" => "jmp"
  end

  def caveats
    <<~EOS
      To use the `jmp` command, you need to add the following alias to your shell configuration:

        alias jmp="source jmp"

      Then reload your shell:

        source ~/.zshrc   # or source ~/.bashrc

      Note: `fzf` is required for `jmp` to function. It has been installed as a dependency.
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/jmp --help", 1)
  end
end