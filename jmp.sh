#!/bin/bash

# エイリアス確認
function check_alias() {
    local alias_required='alias jmp="source jmp"'
    local shell_config_files=("$HOME/.zshrc" "$HOME/.bashrc")

    for config_file in "${shell_config_files[@]}"; do
        if [ -f "$config_file" ] && grep -Fxq "$alias_required" "$config_file"; then
            # 必要なエイリアスが見つかった場合は終了
            return 0
        fi
    done

    # 必要なエイリアスが見つからなかった場合に注意書きを出力
    echo -e "\033[33mWarning: The required alias is not set in your shell configuration.\033[0m"
    echo "Please add the following line to your ~/.zshrc or ~/.bashrc:"
    echo ""
    echo '  alias jmp="source jmp"'
    echo ""
    echo "Then reload your shell:"
    echo "  source ~/.zshrc   # or source ~/.bashrc"
    echo ""
    return 1
}

# エイリアス確認
check_alias || exit 1

JP_CACHE_FILE="$HOME/.jmp_cache"

# キャッシュ更新
function update_cache() {
    # fd が使える場合
    if command -v fd > /dev/null; then
        echo 'Updating cache with "fd" command...'
        fd --type d . ~ > "$JP_CACHE_FILE"
    # fd が使えない場合
    else
        echo 'Updating cache with "find" command...'
        find ~ -type d 2> /dev/null > "$JP_CACHE_FILE"
    fi
    echo "Cache updated: $JP_CACHE_FILE"
}

function search() {
    # キャッシュが無い場合
    if ! test -f "$JP_CACHE_FILE"; then
        echo -e "\033[33mCache does not exist. Do you want to create it now? (y/n)\033[0m"

        # y/n 入力
        echo -n "Enter your choice : "
        read -r choice # zsh では p オプションが使えないっぽい
        case "$choice" in
            [Yy])
                update_cache
                ;;
            [Nn])
                echo "Skipping cache creation. Exiting..."
                return 0
                ;;
            *)
                echo -e "\033[31mInvalid input. Exiting...\033[0m"
                return 1
                ;;
        esac
    fi

    if command -v tmux >/dev/null && tmux info &>/dev/null; then
        target=$(cat "$JP_CACHE_FILE" | fzf-tmux -p 2>/dev/null)
    fi

    if [ -z "$target" ]; then
        target=$(cat "$JP_CACHE_FILE" | fzf)
    fi
    
    if test -n "$target"; then
        cd "$target" || { echo "Failed to change directory to $target"; exit 1; }
        echo "Jump to $target"
    else
        echo "No directory selected."
    fi
}

function show_help() {
    echo "Usage: jp [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -u, --update   Update the cache file."
    echo "  -h, --help     Show this help message."
    echo ""
    echo "Description:"
    echo "  jp is a utility to quickly navigate to frequently used directories."
    echo "  Use 'fzf' to interactively select a directory from a cached list."
    echo ""
    echo "For detailed instructions and additional notes, see the README:"
    echo "https://github.com/totosuki/homebrew-jmp"
}


case "$1" in
    -u|--update)
        update_cache
        ;;
    -h|--help)
        show_help
        ;;
    "")
        search
        ;;
    *)
        echo -e "\033[31mInvalid option: $1\033[0m\n"
        show_help
        return 1
        ;;
esac
