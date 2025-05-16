#!/usr/bin/env fish

# -----------------------------------------------------------------------------
# Name        : Caio Quinilato Teixeira
# Email       : caio.quinilato@gmail.com
# Repository  : https://github.com/github/dotfiles
# Description : Function to list projects then launching them
# -----------------------------------------------------------------------------

function project
    set selected (find ~/ghq/ -mindepth 3 -maxdepth 3 -type d | fzf)
    set clean (echo $selected | awk -F/ '{print $NF}')

    if [ $selected ]
        set session_name $(tmux list-sessions | awk '/attached/ {print $1}' | tr -d ":")
        set window_name $(echo $selected | awk -F/ '{print $NF}' )
        project_launch $session_name $window_name $selected
    end
end
