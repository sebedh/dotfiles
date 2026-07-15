set --universal --erase fish_greeting
set fish_greeting

set -gx EDITOR nvim
set -gx GPG_TTY (tty)

alias vim="nvim"
alias rm="rm -iv"
alias cp="cp -v"
alias mv="mv -iv"
alias lg="lazygit"

bind alt-backspace backward-kill-word
bind ctrl-backspace backward-kill-token

abbr -a v nvim
if type -q
    abbr -a k kubectl
end
abbr -a tbf toolbox enter
abbr -a k kubectl

if type -q direnv
    direnv hook fish | source
end
