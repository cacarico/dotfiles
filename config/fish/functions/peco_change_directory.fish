#!/usr/bin/env fish

function peco_change_directory
    set -l query (commandline)

    if test -n $query
        set peco_flags --query "$query"
    end

    jump top | peco $peco_flags | read recent
    if [ $recent ]
        cd $recent
        commandline -r ''
        commandline -f repaint
    end
end
