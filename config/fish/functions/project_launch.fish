#!/usr/bin/env fish

# -----------------------------------------------------------------------------
# Name        : Caio Quinilato Teixeira
# Email       : caio.quinilato@gmail.com
# Repository  : https://github.com/github/dotfiles
# Description : Function to spawn projects
# -----------------------------------------------------------------------------

function project_launch
    set session_name $argv[1]
    set window_name $argv[2]
    set project_dir $argv[3]

    # Creates new window, creates new pane and opens nvim
    tmux new-window -t "$session_name" -n "$window_name" -c "$project_dir"
    tmux split-window -t "$session_name:$window_name" -v -c "$project_dir"
    tmux resize-pane -t "$session_name:$window_name" -y 20%
    tmux select-pane -t "$session_name:$window_name" -U
    tmux send-keys -t "$session_name:$window_name" nvim C-m
end
