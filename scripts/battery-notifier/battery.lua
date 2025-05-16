#!/usr/bin/env lua
--- Battery Monitor Script
-- This script monitors the system battery level and sends desktop notifications
-- when the battery reaches certain thresholds. It uses LuaSocket (if available)
-- for more accurate sleeping and luaposix (if available) to handle SIGINT gracefully.
--
-- @author sunmenko
-- @module battery_monitor

-- ============================================================================
-- Configuration Constants
-- ============================================================================

--- Battery level thresholds (percentage).
local MEDIUM_THRESHOLD = 50
local WARNING_THRESHOLD = 25
local CRITICAL_THRESHOLD = 10
local CHECK_INTERVAL = 6
local DISCHARING_STATE = "Discharging"

--- Filesystem path to the battery capacity file.
-- Adjust this path as needed for your system.
local BATTERY_LEVEL_PATH = "/sys/class/power_supply/BAT0/capacity"
local BATTERY_STATUS_PATH = "/sys/class/power_supply/BAT0/status"

-- ============================================================================
-- External Modules
-- ============================================================================

-- Try to load LuaSocket for enhanced timing functions.
local hasSocket, socket = pcall(require, "socket")

-- Global flag to control the monitoring loop.
local running = true

-- ============================================================================
-- Helper Functions
-- ============================================================================

--- Waits for a specified timeout using `socket.select`, handling interruptions.
-- This function is used to sleep in small increments so that the running flag
-- is checked frequently.
--
-- @param timeout number The timeout (in seconds) to wait.
-- @return any The return value from `socket.select` if successful.
local function safeSelect(timeout)
	while running do
		local ok, result = pcall(function()
			return socket.select(nil, nil, timeout)
		end)
		if ok then
			return result
		else
			-- If the error message indicates an interruption, check the running flag.
			if tostring(result):match("interrupted") then
				if not running then
					return
				end
			-- Otherwise, continue waiting.
			else
				error(result)
			end
		end
	end
end

--- Sleeps for the specified number of seconds.
-- If LuaSocket is available, it uses `socket.gettime` and `safeSelect` for better
-- accuracy and responsiveness; otherwise, it falls back to `os.execute`.
--
-- @param seconds number The number of seconds to sleep.
local function sleep(seconds)
	if hasSocket then
		local start = socket.gettime()
		while running and ((socket.gettime() - start) < seconds) do
			safeSelect(0.1)
		end
	else
		local remaining = seconds
		while remaining > 0 and running do
			local interval = math.min(1, remaining)
			os.execute("sleep " .. interval)
			remaining = remaining - interval
		end
	end
end

--- Reads the current battery level and status from the system.
-- Expects that the battery capacity file contains a numeric value (percentage)
-- and the battery status file contains a string.
--
-- @return number|nil The battery level as a percentage, or nil on error.
-- @return string|nil The battery status or an error message if reading or parsing fails.
local function getBatteryStatus()
	-- Open and read the battery level file.
	local level_file, level_err = io.open(BATTERY_LEVEL_PATH, "r")
	if not level_file then
		return nil, "Failed to open battery level file: " .. tostring(level_err)
	end
	local level_content = level_file:read("*all")
	level_file:close()

	local level = tonumber(level_content)
	if not level then
		return nil, "Failed to parse battery level (content: " .. tostring(level_content) .. ")"
	end

	-- Open and read the battery status file.
	local status_file, status_err = io.open(BATTERY_STATUS_PATH, "r")
	if not status_file then
		return nil, "Failed to open battery status file: " .. tostring(status_err)
	end
	local status = status_file:read("*all")
	status_file:close()

	-- Trim any leading/trailing whitespace (including newlines).
	status = status:match("^%s*(.-)%s*$")

	return level, status
end

--- Sends a desktop notification using the `notify-send` command.
--
-- @param alertLevel string The alert level description (e.g., "Medium", "Warning", "Critical").
-- @param battery number The current battery level percentage.
-- @param urgency string|nil The notification urgency (default is "normal"; use "critical" for critical alerts).
local function sendNotification(alertLevel, battery, urgency)
	urgency = urgency or "normal"
	local message = string.format("Battery %s: %d%%", alertLevel, battery)
	os.execute(string.format('notify-send -u %s "%s"', urgency, message))
end

-- Flags to prevent repeated notifications for the same alert level.
local alertedMedium = false
local alertedWarning = false

-- ============================================================================
-- Signal Handling
-- ============================================================================

-- Attempt to load luaposix for handling SIGINT (Ctrl+C) gracefully.
local hasPosix, posix = pcall(require, "posix.signal")
if hasPosix then
	posix.signal(posix.SIGINT, function()
		posix.write(2, "\nSIGINT received. Exiting battery monitor.\n")
		running = false
	end)
end

-- ============================================================================
-- Main Monitoring Loop
-- ============================================================================

--- Monitors the battery level and sends notifications based on thresholds.
-- When the battery is healthy, notification flags are reset. As the battery level
-- decreases, notifications are sent at defined thresholds. In the critical case,
-- notifications are sent every second for a brief period.
local function monitorBattery()
	while running do
		local battery_level, battery_status = getBatteryStatus()
		-- By default, we sleep after each cycle.
		local shouldSleep = true

		if battery_status == DISCHARING_STATE then
			if battery_level > MEDIUM_THRESHOLD then
				-- Battery is healthy; reset alert states.
				alertedMedium = false
				alertedWarning = false
			elseif battery_level <= MEDIUM_THRESHOLD and battery_level > WARNING_THRESHOLD then
				if not alertedMedium then
					sendNotification("Medium", battery_level)
					alertedMedium = true
					-- Reset lower alert state in case the battery was previously lower.
					alertedWarning = false
				end
			elseif battery_level <= WARNING_THRESHOLD and battery_level > CRITICAL_THRESHOLD then
				if not alertedWarning then
					sendNotification("Warning", battery_level)
					alertedWarning = true
				end
			elseif battery_level <= CRITICAL_THRESHOLD then
				-- Critical level: send critical notifications every second for 6 seconds.
				sendNotification("Critical", battery_level, "critical")
			end
		end

		if shouldSleep and running then
			sleep(CHECK_INTERVAL)
		end
	end
end

--- Main entry point for the battery monitor.
local function main()
	monitorBattery()
end

-- Start the battery monitor.
main()
