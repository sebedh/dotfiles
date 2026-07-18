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
    fish/vendor
    fish/config.fish
    fish/fish_plugins
    fontconfig/fonts.conf
    ghostty/config
    gtk-3.0/settings.ini
    gtk-4.0/settings.ini
    jj/config.toml
    mako/core.ini
    sway/config
    kanshi/config
    tmux/tmux.conf
    waybar/config.jsonc
    waybar/config-hyprland.jsonc
    waybar/style.css
    waybar/mocha.css
    yamlfmt/yamlfmt.yaml
)

if [[ "$(hostname)" == *-gpu-hypr ]]; then
    [[ -e ~/.config/hypr && ! -L ~/.config/hypr ]] && rm -rf ~/.config/hypr
    symlink "$PWD/hypr-vm" ~/.config/hypr
else
    configs+=(
        hypr/autostart.conf
        hypr/bindings.conf
        hypr/hyprland.conf
        hypr/input.conf
        hypr/looknfeel.conf
        hypr/monitors.conf
    )
fi

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
