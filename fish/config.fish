set --universal --erase fish_greeting
set fish_greeting

set -gx EDITOR nvim

alias vim="nvim"
alias rm="rm -iv"
alias cp="cp -v"
alias mv="mv -iv"
alias lg="lazygit"

bind alt-backspace backward-kill-word
bind ctrl-backspace backward-kill-token

abbr -a v nvim
abbr -a k kubectl
abbr -a tbf toolbox enter fedora-toolbox
