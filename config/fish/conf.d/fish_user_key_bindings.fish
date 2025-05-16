#!/usr/bin/env fish

function fish_user_key_bindings
    bind \cP project
    bind --mode insert \cP project
    bind --mode insert \cg floating_git
    bind \cg floating_git
    bind --mode insert \cf accept-autosuggestion
    bind --mode insert \cx forward-bigword
end
