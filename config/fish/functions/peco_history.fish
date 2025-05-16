#!/usr/bin/env fish

function peco_history
    if test (count $$argv) = 0
        set peco_flags --layout=bottom-up
    else
        set peco_flags --layout=bottom-up --query "$argv"
    end

    history | peco $peco_flags | read command

    if [ $command ]
        commandline $command
    else
        commandline ''
    end
end
