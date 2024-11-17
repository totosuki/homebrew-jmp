# jmp - Directory Jumper

`jmp` is a Homebrew-installed command-line utility to quickly navigate to frequently used directories using a cached list and `fzf`.

## Installation

### Prerequisites

To use `jmp`, ensure you have the following software installed:

- **`fzf`**: A command-line fuzzy finder for interactive directory selection.
- **`fd`** (optional): A faster alternative to `find` for directory traversal.
- **`tmux`** (optional): Required for `fzf-tmux` if you want to use `jmp` inside a tmux session.

### Using Homebrew

Install `jmp` with Homebrew:

```bash
brew tap totosuki/jmp
brew install jmp
```

After installation, add the following alias to your shell configuration (`.zshrc` or `.bashrc`)

```bash
alias jmp='source jmp'
```

Reload your shell

```bash
source ~/.zshrc # or source ~/.bashrc
```

## Usage

```bash
jmp [OPTIONS]
```

### Options
- `-u, --update`
	Update the directory cache file.
- `-h, --help`
	Show the help message.

### How It Works

1. **Cache Creation**:  
   The `jmp` command generates a cache of directories in your home directory. This can be updated using the `--update` option.

2. **Directory Selection**:  
   Use `fzf` to interactively select a directory from the cached list.

3. **Directory Jumping**:  
   After selection, `jp` changes the current working directory to the chosen one.

## Recommended Software

For the best experience, we recommend installing:

- **`fd`**: A faster alternative to `find` for building the directory cache.
- **`fzf`**: A command-line fuzzy finder for directory selection.
- **`tmux`**: Required for `fzf-tmux`, enabling directory selection inside a tmux session.

## Performance Comparison

- **`fd`**: Optimized for speed. Example: Updating the cache with `fd` might take ~1 second.
- **`find`**: Slower but universally available. Example: Updating the cache with `find` might take 5-10 seconds.

## Additional Notes

- If `fzf-tmux` is available, `jmp` will automatically use it when inside a tmux session. Otherwise, `fzf` will be used as a fallback.
- To use `fzf-tmux`, ensure that `tmux` is installed and you are in an active tmux session.

## Uninstallation

To remove `jmp`, run:

```bash
brew uninstall jmp
```
You may also want to remove the alias from your `.zshrc` or `.bashrc`.