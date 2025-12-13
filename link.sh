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
	#ln -nsf "$@"
}

symlink "$PWD/git/.gitconfig ~/.gitconfig"

configs=(
    fish/config.fish
    fish/conf.d/dracula.fish
    fish/conf.d/ssh-agent.fish
    ghostty/config
    tmux/tmux.conf
    yamlfmt/yamlfmt.yaml
)

for c in "${configs[@]}"; do
    [[ -d ~/.config/$c && -L ~/.config/$c ]] && rm -r ~/.config/"$c"
    mkdir -p ${c%/*}
    symlink "$PWD/$c" ~/.config/"$c"
done
