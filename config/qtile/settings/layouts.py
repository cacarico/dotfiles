from libqtile import layout


layout_opts = {
        "border_width": 1,
        "margin":  4,
        "rounded":  True,
        "border_normal": "#000000",
        "border_focus": "#d75f5f",
        }

layouts = [
        layout.Columns(**layout_opts),
        layout.Max(**layout_opts),
        # Try more layouts by unleashing below layouts.
        # layout.Bsp(),
        # layout.Stack(num_stacks=2),
        # layout.Matrix(),
        # layout.MonadTall(**layout_opts),
        # layout.MonadWide(**layout_opts),
        # layout.RatioTile(),
        # layout.Tile(),
        # layout.TreeTab(),
        # layout.VerticalTile(),
        # layout.Zoomy(),
]
