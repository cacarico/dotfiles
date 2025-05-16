from libqtile.config import Key, KeyChord
from libqtile.command import lazy
from libqtile.utils import guess_terminal
from libqtile import layout

mod = "mod4"
alt = "mod1"

terminal = guess_terminal()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "u", lazy.screen.next_group(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "control"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "control"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "control"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "control"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "shift"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "shift"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "shift"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "shift"], "k", lazy.layout.grow_up(), desc="Grow window up"),

    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod], "c", lazy.layout.next(), desc="Move window focus to other window"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "f", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
    Key([mod, alt], "b", lazy.hide_show_bar("top")),
    # Key([mod, "shift"], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key( [mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window",),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Launchers
    Key([mod, alt], "o", lazy.spawn("bash -c 'setxkbmap -query | grep -q us && setxkbmap br ||  setxkbmap us'"), desc="Launch terminal"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "Return", lazy.spawn('alacritty'), desc="Launch terminal"),
    Key([mod], "space", lazy.spawn("rofi -show run"), desc="Launch rofi"),
    Key([mod, "shift"], "q", lazy.spawn("xsecurelock"), desc="Launch rofi"),
    Key([mod], "p", lazy.spawn("flameshot gui"), desc="Screenshot"),
    Key([mod], "1", lazy.spawn("brillo -A 8")),
    KeyChord([mod], "o", [
        Key([mod], "p", lazy.spawn("pavucontrol")),
        Key([mod], "a", lazy.spawn("arandr")),
        Key([mod], "b", lazy.spawn("blueman-manager")),
        Key([mod], "o", lazy.spawn("obsidian")),
        Key([mod], "s", lazy.spawn("spotify-launcher")),
        Key([mod], "n", lazy.spawn("alacritty -e nmtui"), desc="Launch nmtui"),
    ]),
    KeyChord([mod], "b", [
        Key([mod], "b", lazy.spawn("brave-nightly")),
        Key([mod], "f", lazy.spawn("firefox")),
    ]),
    # Volume
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -3000")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +3000")),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key([], "XF86AudioMicMute", lazy.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brillo -U 8")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brillo -A 8")),
    # Layouts
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "Tab", lazy.prev_layout(), desc="Toggle between layouts"),
    # Key([mod, alt], "6", lazy.layout.MonadTall(), desc="Toggle between layouts"),
]
