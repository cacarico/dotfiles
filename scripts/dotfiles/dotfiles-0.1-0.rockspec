package = "dotfiles"
version = "0.1-0"

rockspec_format = "3.0"

source = {
	url = "git://github.com/cacarico/dotfiles.git",
	tag = "v0.1.0",
}

description = {
	summary = "Library to manage my dotfiles",
	detailed = "TODO",
	homepage = "https://github.com/cacarico/dotfiles",
	license = "MIT",
}

dependencies = {
	"lua >= 5.0",
	"argparse",
  "lyaml"
}

build = {
	type = "builtin",
	modules = {
		["dotfiles"] = "scripts/dotfiles/dotfiles.lua",
	},
	binaries = {
		["dotfiles"] = "scripts/dotfiles/bin/dotfiles",
	},
}

test = {
	type = "shell",
	commands = {
		"lua -e \"package.path = './scripts/dotfiles/?.lua;' .. package.path\" tests/run_all_tests.lua",
	},
	dependencies = {
		"luaunit >= 2.0.0",
	},
}
