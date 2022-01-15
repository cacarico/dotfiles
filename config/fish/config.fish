if status is-interactive
    # Commands to run in interactive sessions can go here
end

# exports nvim as default editor
export EDITOR=nvim

# -----------------------------
# PATHS -----------------------
# -----------------------------
set PATH $PATH:$HOME/.cargo/bin

set -x STARSHIP_CONFIG $HOME/.config/starship.toml

set -x K9SCONFIG $HOME/.config/k9s

set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin
set -x GOBIN $GOPATH/bin

# -----------------------------
# Abbreviations ---------------
# -----------------------------

# Shorts
abbr -a vim nvim
abbr -a k 'kubectl'

# Edit files
abbr -a arc 'nvim ~/.config/alacritty/alacritty.yml'
abbr -a vrc 'nvim ~/.config/nvim/init.vim'
abbr -a frc 'nvim ~/.config/fish/config.fish'
abbr -a trc 'nvim ~/.tmux.conf'
abbr -a gitd 'git diff --ignore-space-at-eol -b -w --ignore-blank-lines'


# Sources
abbr -a ff 'source ~/.config/fish/config.fish'

# Install Plugins Vim
abbr -a ninstall nvim +PlugInstall +qal

# Opens AWS with lastpass
abbr -a creds_aws 'open -a "Google Chrome" https://identity.lastpass.com/redirect\?id\=4cceaabd-c1f2-4854-8135-dd5660fb76f4'

# Copies aws creds to ~/.aws/credentials
abbr -a cp-aws 'cp /Users/caio.teixeira/Downloads/credentials /Users/caio.teixeira/.aws/credentials'

# -----------------------------
# Aliases ---------------------
# -----------------------------

if type -q exa
  alias ls 'exa'
  alias ll 'ls -l -g --icons'
  alias la 'll -a'
  alias lt 'la -T -L2'
end

# Vi mode
function fish_user_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
end

source ~/.config/fish/conf.d/*
source ~/.config/fish/functions/*

fish_add_path /usr/local/opt/llvm/bin

set -gx LDFLAGS "-L/usr/local/opt/llvm/lib"
set -gx CPPFLAGS "-I/usr/local/opt/llvm/include"

# Load .env files, https://github.com/direnv/direnv
direnv hook fish | source

# https://github.com/gsamokovarov/jump
jump shell fish | source
# https://github.com/starship/starship
starship init fish | source
