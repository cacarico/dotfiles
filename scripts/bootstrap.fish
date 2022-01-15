#!/usr/bin/env fish

set CONFIG_DIR $PWD/config
set FISH_CONFIG_DIR $CONFIG_DIR/fish
set HOME_CONFIG_DIR $HOME/.config
set FISH_HOME_CONFIG_DIR $HOME_CONFIG_DIR/fish/conf.d
set FISH_HOME_FUNCTIONS_DIR $HOME_CONFIG_DIR/fish/functions

function create_links

  # FISH
  ln -sF $FISH_CONFIG_DIR/config.fish $HOME_CONFIG_DIR/fish/config.fish

  # Link fish confs
  for fish_file in $FISH_CONFIG_DIR/conf.d/*
   ln -sF $fish_file $FISH_HOME_CONFIG_DIR/
  end

  # Link fish functions
  for fish_file in $FISH_CONFIG_DIR/functions/*
    ln -sF $fish_file $FISH_HOME_FUNCTIONS_DIR/
  end

  # Link gitui functions
  for gitui_file in $CONFIG_DIR/gitui/*
    ln -sF $gitui_file $HOME_CONFIG_DIR/gitui/
  end

  ln -sF $CONFIG_DIR/tmux.conf $HOME/.tmux.conf
  ln -sF $CONFIG_DIR/k9s.yaml $HOME_CONFIG_DIR/k9s/config.yaml
  ln -sF $CONFIG_DIR/starship.toml $HOME_CONFIG_DIR/starship.toml
  ln -sF $CONFIG_DIR/alacritty.yml $HOME_CONFIG_DIR/alacritty/alacritty.yml
  ln -sF $CONFIG_DIR/nvim/init.vim $HOME_CONFIG_DIR/nvim/init.vim
  ln -sF $CONFIG_DIR/nvim/coc-settings.json $HOME_CONFIG_DIR/nvim/coc-settings.json
end

function remove_links

  # Fish
  unlink $HOME/.config/fish/config.fish

  # Unlink fish conf
  for fish_file in (ls $FISH_CONFIG_DIR/conf.d)
    unlink $FISH_HOME_CONFIG_DIR/$fish_file
  end

  # Unlink fish functions
  for fish_file in (ls $FISH_CONFIG_DIR/functions)
    unlink $FISH_HOME_FUNCTIONS_DIR/$fish_file
  end

  # Unlink fish functions
  for gitui_file in (ls $CONFIG_DIR/gitui)
    unlink $HOME_CONFIG_DIR/gitui/$gitui_file
  end

  unlink $HOME/.tmux.conf
  unlink $HOME_CONFIG_DIR/starship.toml
  unlink $HOME_CONFIG_DIR/alacritty/alacritty.yml
  unlink $HOME_CONFIG_DIR/nvim/init.vim
  unlink $HOME_CONFIG_DIR/nvim/coc-settings.json
end

switch $argv
  case create_links
    create_links
  case remove_links
    remove_links
  case '*'
    echo Option $argv not found
end
