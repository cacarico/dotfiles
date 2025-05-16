from libqtile import bar, widget
from libqtile.widget import Sep
from libqtile.config import Screen

WALLPAPER_PATH = "/home/cacarico/Pictures/Wallpapers/current"
BACKGROUND_COLOR = "#6B20786B"

def create_bar():
    return bar.Bar(
        [
            widget.GroupBox(),
            Sep(linewidth=0, padding=6),
            widget.Spacer(),
            widget.Clock(format="%b %d %Y %a %I:%M %p"),
            widget.Spacer(),
            Sep(linewidth=0, padding=6),
            widget.Backlight(
                format="🔦 {percent:2.0%}",
                brightness_file='/sys/class/backlight/amdgpu_bl1/brightness',
                max_brightness_file='/sys/class/backlight/amdgpu_bl1/max_brightness',
                scroll=True
            ),
            widget.Battery(format="⚡{percent:2.0%}"),
        ],
        24,
        background=BACKGROUND_COLOR,
    )

screens = [
    Screen(top=create_bar(), wallpaper=WALLPAPER_PATH, wallpaper_mode='fill', x11_drag_polling_rate=60),
    Screen(top=create_bar(), wallpaper=WALLPAPER_PATH, wallpaper_mode='fill', x11_drag_polling_rate=60),
    Screen(top=create_bar(), wallpaper=WALLPAPER_PATH, wallpaper_mode='fill', x11_drag_polling_rate=60),
]
