--- Arch Module
--- This module handles Archlinux related functions
---
--- @module "arch"

local arch = {}
local system = require("utils.system")

--- Helper for non interactive install
--- @param noconfirm any
--- @return string
local function get_confirm_option(noconfirm)
	return noconfirm and " --noconfirm" or ""
end

---  Archlinux package manager
--- This function updates or install packages depending on the action
--- and package manager provided
--- @param action string The type of action to perform (install or update)
--- @param package_manager string The package manager to install packages
--- @param noconfirm? boolean True to enable --noconfirm
local function arch_manager(action, package_manager, noconfirm)
	local opt = get_confirm_option(noconfirm)
	local packages = table.concat(system.read_yaml(package_manager).global, " ")

	local enable_sudo = ""
	if package_manager == "pacman" then
		enable_sudo = "sudo "
	end
	local cmd = ""
	if action == "install" then
		cmd = string.format(enable_sudo .. package_manager .. " -S --needed" .. opt .. " " .. packages)
	end

	if action == "update" then
		cmd = string.format(enable_sudo .. package_manager .. " -Syu" .. opt)
	end
	print("Running: " .. action .. " " .. package_manager .. " packages...")
	system.execute(cmd)
end

--- Install Pacman packages
--- This function updates all yay packages
--- @param noconfirm? boolean True to enable --noconfirm
function arch.install_pacman(noconfirm)
	arch_manager("install", "pacman", noconfirm)
end

--- Install Yay packages
--- This function updates all yay packages
--- @param noconfirm? boolean True to enable --noconfirm
function arch.install_yay(noconfirm)
	arch_manager("install", "yay", noconfirm)
end

--- Update Pacman packages
--- This function updates all yay packages
--- @param noconfirm? boolean True to enable --noconfirm
function arch.update_pacman(noconfirm)
	arch_manager("update", "pacman", noconfirm)
end

--- Update Yay packages
--- This function updates all yay packages
--- @param noconfirm? boolean True to enable --noconfirm
function arch.update_yay(noconfirm)
	arch_manager("update", "yay", noconfirm)
end

--- Update Archlinux
--- This function runs pacman and yay
--- @param noconfirm? boolean True to enable --noconfirm
function arch.run_all(noconfirm)
	noconfirm = noconfirm or false

	arch.update_pacman(noconfirm)
	arch.install_pacman(noconfirm)
	arch.update_yay(noconfirm)
	arch.install_yay(noconfirm)
end

--- Setup Arch
--- This function updates all yay packages
function arch.setup()
	arch.run_all(true)
end

return arch
