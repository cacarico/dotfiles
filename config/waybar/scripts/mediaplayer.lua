#!/usr/bin/env lua

local lgi = require("lgi")
local GLib = lgi.GLib
local Playerctl = lgi.require("Playerctl", "2.0")

-- Create a new Playerctl.Player instance. Passing nil tells it to use the default player.
local player = Playerctl.Player.new(nil)

-- Set up a callback for when metadata changes.
player.on_metadata = function(self, metadata)
	local title = metadata["xesam:title"] or "Unknown Title"
	-- xesam:artist is usually an array, so we take the first element if available.
	local artist = metadata["xesam:artist"] and metadata["xesam:artist"][1] or "Unknown Artist"
	print("Now playing: " .. title .. " by " .. artist)
end

-- Optionally, you can also listen to playback status changes:
player.on_playback_status = function(self, status)
	print("Playback status changed: " .. status)
end

-- Run the GLib main loop to keep the script active and listening for events.
local loop = GLib.MainLoop()
loop:run()
