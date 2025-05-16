-- progress.lua
-- Demonstrates printing a table of statuses and updating them in place.

-- Define all modules and their initial statuses
local modules = {
	{ name = "Default Folders", status = "..." },
	{ name = "SymLinks", status = "..." },
	{ name = "Pacman", status = "..." },
	{ name = "Yay", status = "..." },
	{ name = "asdf", status = "..." },
	{ name = "FingerPrint", status = "..." },
}

-- Helper function: Print the table header
local function printHeader()
	print("Module" .. string.rep(" ", 20) .. "Status")
end

-- Helper function: Print a single line for a module
local function printLine(mod)
	local line = mod.name
	-- Pad so statuses line up nicely
	if #mod.name < 20 then
		line = line .. string.rep(" ", 20 - #mod.name)
	end
	line = line .. mod.status
	print(line)
end

-- Print the entire table
local function printModules(mods)
	printHeader()
	for _, mod in ipairs(mods) do
		printLine(mod)
	end
end

-- Update the status of a specific module (by index), in-place
local function updateModule(mods, index, newStatus)
	-- The cursor is initially below all modules, so we move up to the line
	-- we need to overwrite. #mods - index + 1 lines above us is the correct row.
	local linesUp = #mods - index + 1

	-- Move the cursor up 'linesUp' lines
	io.write("\27[" .. linesUp .. "A")

	-- Clear the current line
	io.write("\27[K")

	-- Update the status in our table and re-print that line
	mods[index].status = newStatus
	printLine(mods[index])

	-- Move the cursor back down to where it was
	io.write("\27[" .. linesUp .. "B")
end

-- Main logic:
printModules(modules)

-- Simulate updates over time
os.execute("sleep 1")
updateModule(modules, 1, "Done") -- "Default Folders"
os.execute("sleep 1")
updateModule(modules, 2, "Done") -- "SymLinks"
os.execute("sleep 1")
updateModule(modules, 3, "updating...") -- "Pacman"
os.execute("sleep 2")
updateModule(modules, 3, "Done") -- "Pacman"
os.execute("sleep 1")
updateModule(modules, 4, "queued...") -- "Yay"
os.execute("sleep 1")
updateModule(modules, 5, "queued...") -- "asdf"
os.execute("sleep 1")
updateModule(modules, 6, "Done") -- "FingerPrint"
