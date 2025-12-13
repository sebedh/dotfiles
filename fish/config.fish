set --universal --erase fish_greeting
function fish_greeting; end
funcsave fish_greeting

set -gx EDITOR nvim
set -gx BROWSER zen-browser
set -gx RAD_HOME $HOME/.config/radicle
set -gx PNPM_HOME "/home/sebbe/.local/share/pnpm"

alias vim="nvim"
alias rm="rm -iv"
alias cp="cp -v"
alias mv="mv -iv"
alias lg="lazygit"

bind alt-backspace backward-kill-word
bind ctrl-backspace backward-kill-token

abbr -a v nvim
abbr -a k kubectl
abbr -a incus sudo incus

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# opencode
fish_add_path /home/sebbe/.opencode/bin
# pnpmp
fish_add_path /home/sebbe/.local/share/pnpm
fish_add_path /opt/zen-browser-bin/
fish_add_path /usr/local/go/bin
