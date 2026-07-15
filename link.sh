#!/usr/bin/env bash
#
# Inspired from: Dave Eddy <dave@daveeddy.com>
#
# Author: Sebastian Edholm <sebbe@sebb.io>
# License: MIT


defaults() {
	echo defaults "$@"
	command defaults "$@"
}

# verbose ln, because 'ln -v' is not portable
symlink() {
	printf '%55s -> %s\n' "${1/#$HOME/\~}" "${2/#$HOME/\~}"
	ln -nsfT "$@"
}

symlink "$PWD/git/.gitconfig" ~/.gitconfig
symlink "$PWD/xdg-terminals.list" ~/.config/xdg-terminals.list

configs=(
    fish/conf.d
    fish/functions
    fish/config.fish
    fontconfig/fonts.conf
    ghostty/config
    hypr/autostart.conf
    hypr/bindings.conf
    hypr/hyprland.conf
    hypr/input.conf
    hypr/looknfeel.conf
    hypr/monitors.conf
    jj/config.toml
    mako/core.ini
    sway/config
    tmux/tmux.conf
    waybar/config.jsonc
    waybar/style.css
    yamlfmt/yamlfmt.yaml
)

scripts=(
    tmux-session-fzf.sh
    tmux-sessionizer.sh
    launch-browser.sh
    launch-walker.sh
    cmd-terminal-cwd.sh
)

for c in "${configs[@]}"; do
    [[ -e ~/.config/$c && ! -L ~/.config/$c ]] && rm -rf ~/.config/"$c"
    mkdir -p ~/.config/${c%/*}
    symlink "$PWD/$c" ~/.config/"$c"
done

for s in "${scripts[@]}"; do
    mkdir -p ~/.local/bin
    symlink "$PWD/scripts/$s" ~/.local/bin/"$s"
done
