--- Setup Module
--- This module setups the machine based on the system
---
--- @module "Setup"

local setup = {}
local system = require("utils.system")

--- Mapping for installing distro specific software
local supported_distros = {
	arch = require("bootstrap.arch").setup,
	fedora = function()
		print("Running installation for Fedora...")
		-- Fedora-specific installation commands
	end,
	kali = function()
		print("Running installation for Kali Linux...")
		-- Kali-specific installation commands
	end,
}

--- Installs Distribution specific software
--- This function checks which distribution the system is running and install the distro
--- specific softwares
local function distro_specific_install()
	-- Get current distro and check if it's supported by looking up in the supported_distros table
	local distro = system.get_distro()
	if distro and supported_distros[distro] then
		supported_distros[distro]()
	else
		print("Current distro (" .. distro .. ") is not supported.")
	end
end

--- Sets up the system
function setup.install_system()
	print("Installing distro specific softwares...")
	distro_specific_install()
end

return setup
