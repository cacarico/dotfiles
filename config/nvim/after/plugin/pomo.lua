require("pomo").setup({
	-- How often the notifiers are updated.
	update_interval = 1000,

	notifiers = {
		{
			name = "Default",
			opts = {
				-- Sticky the notification to window
				sticky = false,
				title_icon = "⏳",
				text_icon = "⏱️",
			},
		},
		-- The "System" notifier sends a system notification when the timer is finished.
		-- Available on MacOS and Windows natively and on Linux via the `libnotify-bin` package.
		{ name = "System" },
	},

	-- Override the notifiers for specific timer names.
	timers = {
		Break = {
			{ name = "System" },
		},
	},
	-- You can optionally define custom timer sessions.
	sessions = {
		focus_3 = {
			{ name = "Focus", duration = "25m" },
			{ name = "Short Break", duration = "5m" },
			{ name = "Focus", duration = "25m" },
			{ name = "Short Break", duration = "5m" },
			{ name = "Focus", duration = "25m" },
			{ name = "Long Break", duration = "15m" },
		},
		focus = {
			{ name = "Focus", duration = "1m" },
			{ name = "Break", duration = "1m" },
		},
	},
})
