if status is-interactive
    # Commands to run in interactive sessions can go here
end

# exports nvim as default editor
set -x EDITOR nvim
set -x KUBE_EDITOR nvim

# Set java
set -x JAVA_HOME /usr/lib/jvm/java-20-openjdk/

# -----------------------------
# PATHS -----------------------
# -----------------------------
set fish_user_paths $HOME/.cargo/bin $HOME/go/bin $HOME/.local/bin $HOME/.config/emacs/bin/ $JAVA_HOME/bin/ $HOME/.asdf/bin $HOME/.asdf/shims $HOME/.krew/bin $HOME/.local/share/gem/ruby/3.0.0/bin/ $HOME/bin

# This is neede so signing commits with git works
set -x GPG_TTY $(tty)
set -x STARSHIP_CONFIG $HOME/.config/starship.toml


# -----------------------------
# Abbreviations ---------------
# -----------------------------

# Shorts
abbr -a vim nvim
abbr -a k 'kubectl'
abbr -a x 'xclip -selection clipboard'

# Edit files
abbr -a arc 'nvim ~/.config/alacritty/alacritty.toml'
abbr -a vrc 'nvim ~/.config/nvim/init.vim'
abbr -a frc 'nvim ~/.config/fish/config.fish'
abbr -a trc 'nvim ~/.tmux.conf'
abbr -a gitd 'git diff --ignore-space-at-eol -b -w --ignore-blank-lines'
abbr -a lg 'lazygit'

# Sources
abbr -a ff 'source ~/.config/fish/config.fish'

# Install Plugins Vim
abbr -a ninstall nvim +PlugInstall +qal

# -----------------------------
# Aliases ---------------------
# -----------------------------
alias awsp '_awsp'
alias av "aws-vault exec"
alias avl "aws-vault login"

if type -q exa
  alias ls 'exa'
  alias l ll
  alias ll 'ls -l -g --icons'
  alias la 'll -a'
  alias lt 'la -T -L2'
end

if type -q git
    alias g 'git'
    alias gs 'git status'
    alias ga 'git add'
    alias gc 'git commit -m'
    alias gb 'git branch'
    alias gco 'git switch'
    alias gcu 'git branch -u origin'
    alias gcm 'git switch main 2>/dev/null || git switch master'
    alias gd 'git diff'
    alias gl 'git log'
    alias gp 'git push'
    alias gpl 'git pull'
    alias gpsup 'echo git push --set-upstream origin (git rev-parse --abbrev-ref HEAD) '
end

if type -q jaq
    alias jq 'jaq'
end

if type -q autojump
    alias j 'autojump'
    alias jump 'autojump'
end

# Kubernetes
alias kc 'kubectl ctx'
alias kn 'kubectl ns'

# Vi mode
# fish_vi_key_bindings


# Helpers
alias xc 'xclip -selection clipboard'

set -g fish_u

direnv hook fish | source
jump shell fish | source
starship init fish | source

source ~/.config/fish/conf.d/*
source ~/.config/fish/functions/*
