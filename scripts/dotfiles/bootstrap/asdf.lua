--- Asdf Module
--- This module manages asdf intsallation and updates
---
--- @module 'asdf'

local asdf = {}
local system = require("utils.system")

--- Install asdf packages
--- This function installs asdf packages
function asdf.install_packages()
	yaml = system.read_yaml("asdf")
end

return asdf
