class Jmp < Formula
  desc "A command-line tool to jump(jmp) between directories"
  homepage "https://github.com/totosuki/homebrew-jmp"
  url "https://github.com/totosuki/homebrew-jmp/archive/refs/tags/v1.2.tar.gz"
  sha256 "df84529c9141375b1f171eb4527ab1b82f26edcb32d10c8f3805be8abc117862"
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