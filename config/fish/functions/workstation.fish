#!/usr/bin/env fish

# -----------------------------------------------------------------------------
# Name        : Caio Quinilato Teixeira
# Email       : caio.quinilato@gmail.com
# Repository  : https://github.com/github/dotfiles
# Description : Function that starts the workstation
# -----------------------------------------------------------------------------

# BUG: When workstation starts the windows are not split 30%
# the function works when called externally or in other scripts
# although when called here it does not work
function workstation
    set session_name workstation
    set main_window main

    if test $(tmux list-sessions  2>/dev/null | grep workspace | wc -l) -lt 1

        # Create main window
        tmux new-session -d -s $session_name -n $main_window
        tmux split-window -t $session_name:$main_window -v -l 30%

        # Launch Projects
        project_launch $session_name dotfiles "$HOME/ghq/github.com/cacarico/dotfiles-pvt"
        project_launch $session_name blog-cacarico "$HOME/ghq/github.com/cacarico/blog-cacarico"
        project_launch $session_name hyprlua"$HOME/ghq/github.com/cacarico/hyprlua"

        # Attach to the tmux session
    end
    tmux attach-session -t $session_name
end
