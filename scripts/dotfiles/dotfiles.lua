#!/usr/bin/env lua

--- Dotfiles Library
--- This library has functions to maintain the Dotfiles
--- @module "dotfiles"

local source = debug.getinfo(1, "S").source:sub(2)
local script_path = source:match("(.*/)")
if not script_path then
	script_path = "./"
end

package.path = package.path .. ";" .. script_path .. "?.lua"

local arch = require("bootstrap.arch")

-- arch.run_all()
arch.load_packages()
