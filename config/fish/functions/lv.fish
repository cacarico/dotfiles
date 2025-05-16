#!/usr/bin/env fish

# Alias lv for setting Lua and Luarocks version
function lv
  if not set -q argv[1]
    lua -v | awk '{print $1 $2}'
    luarocks --version | awk '/rocks/{print "LuaRocks "  $2 }'
      return 0
  end

  set lua_version $argv[1]
  eval "$(luarocks --lua-version=5.$lua_version path --bin)"
  alias lua "lua5.$lua_version"
  alias luarocks "luarocks --lua-version=5.$lua_version"
end
