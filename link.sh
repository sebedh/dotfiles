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
    waybar/config-hyprland.jsonc
    waybar/config-sway.jsonc
    waybar/style.css
    waybar/mocha.css
    yamlfmt/yamlfmt.yaml
    environment.d/fcitx.conf
    zed/keymap.json
    zed/settings.json
    zed/tasks.json
)

dirs=(
    hypr:.config/hypr
    elephant:.config/elephant
    walker:.config/walker
    uwsm:.config/uwsm
    omarchy:.local/share/omarchy
)

for d in "${dirs[@]}"; do
    src="${d%%:*}"
    dest="${d#*:}"
    [[ -e ~/$dest && ! -L ~/$dest ]] && rm -rf ~/"$dest"
    mkdir -p "$(dirname ~/"$dest")"
    symlink "$PWD/$src" ~/"$dest"
done

scripts=(
    tmux-session-fzf.sh
    tmux-sessionizer.sh
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

if command -v Hyprland >/dev/null; then
    symlink "$PWD/waybar/themes/omega/config.jsonc" ~/.config/waybar/config.jsonc
    symlink "$PWD/waybar/themes/omega/style.css" ~/.config/waybar/style.css
    for f in cava.sh metastats.sh secbar.sh sysbar.sh theme.sh window.sh; do
        symlink "$PWD/waybar/themes/omega/$f" ~/.config/waybar/"$f"
    done
    mkdir -p ~/.config/waybar/bottom
    symlink "$PWD/waybar/themes/omega/bottom/config" ~/.config/waybar/bottom/config
    symlink "$PWD/waybar/themes/omega/bottom/style.css" ~/.config/waybar/bottom/style.css
else
    symlink "$PWD/waybar/config-sway.jsonc" ~/.config/waybar/config.jsonc
fi
