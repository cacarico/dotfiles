# NeoVim

Here you find the configuration files for NeoVim.

##

### Directory Structure


```
.
├── after
│   └── plugin
│       ├── colors.lua
│       ├── heirline.lua
│       ├── lsp.lua
│       ├── neotree.lua
│       ├── telescope.lua
│       └── treesitter.lua
├── init.lua
├── lazy-lock.json
├── lua
│   └── cacarico
│       ├── init.lua
│       ├── lazy.lua
│       ├── mappings.lua
│       └── options.lua
└── README.md
```

#### ./lua

The lua directory contain files to configure the bases of the NeoVim config.

**init.lua**\
Requires the other configurations files

**lazy.lua**\
Configuration files for Lazy.nvim plugin.plugin

**mappings.lua**\
General mappings for NeoVim.

:ex: Plugins mappings are added at `after/plugin/<plugin_name>.lua` files.

#### ./after

Inside `after/plugin/` we have individual configuration files for each plugin. Here you can see all the changes made to the plugins, also the plugin mappings.

## Plugins

### Code`

#### Neodev

#### lsp-zero

For simplifying the lsp configuration we use `lsp-zero`.

#### Treesitter

#### Fugitive

#### Commentary

### Navigation

#### NeoTree

#### Telescope

#### Harpoon

#### Undotreee

#### Which-key
