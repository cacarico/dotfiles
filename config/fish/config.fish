if status is-interactive
    # Commands to run in interactive sessions can go here
end

# exports nvim as default editor
set -x BROWSER brave
set -x EDITOR nvim
set -x KUBE_EDITOR nvim
set -g fish_term_bell
set -x GOPATH ~/go # Replace ~/go with your desired path
set -x GOBIN $GOPATH/bin # This sets GOBIN to $GOPATH/bin, you can change it if you want it elsewhere
set -x CARGO_INSTALL_ROOT ~/.local/cargo
set -x CARGOBIN ~/.local/cargo/bin
set -x DOCKER_HOST unix:///run/user/1000/podman/podman.sock
set -x DOTFILES_DIR $HOME/ghq/github.com/cacarico/dotfiles-pvt
set -x RADV_PERFTEST 'video_decode,video_encode'

# Set terminal colors
set -g fish_color_command blue
set -g fish_color_param brpurple

# -----------------------------
# PATHS -----------------------
# -----------------------------
set fish_user_paths \
    $HOME/.cargo/bin \
    $HOME/.config/emacs/bin \
    $HOME/.krew/bin \
    $HOME/.local/share/gem/ruby/3.0.0/bin \
    $HOME/bin \
    $HOME/go/bin $HOME/.local/bin \
    $JAVA_HOME/bin \
    $GOBIN \
    $CARGOBIN \
    $DOTFILES_DIR/scripts/dotfiles/bin \
    /opt/mssql-tools18/bin/

# This is neede so signing commits with git works
set -x GPG_TTY $(tty)]
set -x STARSHIP_CONFIG $HOME/.config/starship.toml

# Enables fish vim mode
set -g fish_key_bindings fish_vi_key_bindings

# ASDF

# ASDF configuration code
if test -z "$ASDF_DATA_DIR"
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

# -----------------------------
# Abbreviations ---------------
# -----------------------------

# Shorts
abbr -a vim nvim
abbr -a k kubectl
abbr -a x 'xclip -selection clipboard'

# Edit files
abbr -a arc 'nvim ~/.config/alacritty/alacritty.toml'
abbr -a vrc 'nvim ~/.config/nvim/init.vim'
abbr -a frc 'nvim ~/.config/fish/config.fish'
abbr -a trc 'nvim ~/.tmux.conf'
abbr -a zg lazygit
abbr -a zd lazydocker

# Sources
abbr -a ff 'source ~/.config/fish/config.fish'

# Install Plugins Vim
abbr -a ninstall nvim +PlugInstall +qal

# -----------------------------
# Aliases ---------------------
# -----------------------------

if type -q aws
    alias awsp "set -gx AWS_PROFILE "
end

if type -q aws-vault
    abbr -a av "aws-vault exec"
    abbr -a avl "aws-vault login"
end

# if type -q _awsp
#     alias awsp "source /home/config/fish/config.fishcacarico/.asdf/shims/_awsp"
# end

if type -q bat
    abbr -a cat bat
end

if type -q podman
    alias docker podman
end

if type -q exa
    alias l exa
    alias ls 'exa --icons'
    alias ll 'ls -l'
    alias la 'l -a'
    alias lt 'ls -T -L2'
    alias lt5 'la -T -L5'
end

if type -q git
    abbr -a g git
    abbr -a ga 'git add'
    abbr -a gb 'git branch'
    abbr -a gc 'git commit -m'
    abbr -a gcm 'git switch main 2>/dev/null || git switch master'
    abbr -a gco 'git switch'
    abbr -a gcu 'git branch -u origin'
    abbr -a gd 'git diff'
    abbr -a gl 'git log'
    abbr -a gp 'git push'
    abbr -a gpl 'git pull'
    abbr -a gpsup 'echo git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)'
    abbr -a gs 'git status'
    abbr -a gitd 'git diff --ignore-space-at-eol -b -w --ignore-blank-lines'
end

function gcd
    cd $(git rev-parse --show-toplevel)
end

if type -q gh
    abbr -a ghw 'gh run watch'
end

if type -q ghq
    abbr -a gg 'ghq get'
end

if type -q jaq
    abbr -a jq jaq
end

# Kubernetes
if type -q kubectl
    abbr -a kc 'kubectl ctx'
    abbr -a kn 'kubectl ns'
end

if type -q nvim
    abbr -a n nvim
    abbr -a vim nvim
end

if type -q spotify-launcher
    abbr -a spotify spotify-launcher
end

# Sources for fish commands
eval "$(luarocks path --bin)"
direnv hook fish | source
starship init fish | source
zoxide init fish | source
