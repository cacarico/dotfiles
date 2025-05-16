--- System Library
--- This module handles Process functions
---
--- @module "system"

local system = {}

function system.execute(cmd)
	cmd = cmd .. " 2>&1"
	local handle, error = io.popen(cmd, "r")
	if not handle then
		return nil, "Failed to run command: " .. tostring(error)
	end
	local output, readError = handle:read("*a") -- Read all output
	if not output then
		handle:close()
		return nil, "Failed to read command output: " .. tostring(readError)
	end
	print(output)
	handle:close()
end

--- Returns the Linux Distribution Name
---@return string
function system.get_distro()
	local distro = "unkown"

	local file = io.open("/etc/os-release", "r")
	if file then
		for line in file:lines() do
			if line:match("^ID=") then
				distro = line:match('^ID="?([^"]+)"?')
				file:close()
				return distro
			end
		end
	end
	file:close()
	return distro
end

--- Returns the
--- @return string Returns the directory of the script
function system.script_dir()
	local script_dir = debug.getinfo(1, "S").source:sub(2):match("(.*/)")
	if not script_dir then
		script_dir = "./"
	end

	return script_dir
end

--- Read yaml
---@param package_file string The yaml to be read
---@return table
function system.read_yaml(package_file)
	local lyaml = require("lyaml")
	package_file = package_file or ""
	local yaml_path = system.script_dir() .. "../packages/" .. package_file .. ".yaml"

	local file = assert(io.open(yaml_path, "r"))
	if not file then
		print("Error finding package file " .. yaml_path)
	end
	local content = file:read("*a")
	file:close()

	local data = lyaml.load(content)

	return data
end

return system
