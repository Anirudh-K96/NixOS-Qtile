{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ 
    pamixer 
    rofi-power-menu 
  ];

  # 🌌 PICOM: The "Hyprland-ifier"
  services.picom = {
    enable = true;
    settings = {
      corner-radius = 12;
      blur = {
        method = "dual_kawase";
        strength = 5;
        background = true;
        background-frame = false;
        background-fixed = false;
      };

      shadow = true;
      shadow-radius = 15;
      shadow-offset-x = -15;
      shadow-offset-y = -15;
      shadow-opacity = 0.8;
      shadow-color = "#000000";

      rounded-corners-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
      ];

      blur-background-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "_GTK_FRAME_EXTENTS@:c"
      ];

      backend = "glx";
      vsync = true;
      use-damage = true;
    };
  };

  # 🐍 QTILE: The Brains
  xdg.configFile."qtile/config.py".text = ''
    from libqtile import bar, layout, widget, qtile
    from libqtile.config import Click, Drag, Group, Key, Screen
    from libqtile.lazy import lazy
    import subprocess

    mod = "mod4"
    colors = {
        "bg": "#1a1b26",    
        "fg": "#c0caf5",    
        "curr": "#292e42",  
        "blue": "#7aa2f7",
        "purple": "#bb9af7",
        "cyan": "#7dcfff",
        "red": "#f7768e",
    }

    # Custom Volume function for the Poll widget
    def get_volume():
        try:
            is_muted = subprocess.getoutput("pamixer --get-mute")
            if is_muted == "true": return "Muted"
            return subprocess.getoutput("pamixer --get-volume") + "%"
        except: return "N/A"

    keys = [
        Key([mod], "h", lazy.layout.left()),
        Key([mod], "l", lazy.layout.right()),
        Key([mod], "j", lazy.layout.down()),
        Key([mod], "k", lazy.layout.up()),
        Key([mod], "Return", lazy.spawn("kitty")),
        Key([mod], "Space", lazy.spawn("rofi -show drun")),
        Key([mod], "q", lazy.window.kill()),
        Key([mod, "control"], "r", lazy.reload_config()),
    ]

    # Only 5 Workspaces
    groups = [Group(i) for i in "12345"]
    for i in groups:
        keys.extend([
            Key([mod], i.name, lazy.group[i.name].toscreen()),
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
        ])

    layouts = [
        layout.MonadTall(
            border_width=0, # No borders so Picom rounding looks clean
            margin=12
        ),
        layout.Max(),
    ]

    widget_defaults = dict(
        font="JetBrainsMono Nerd Font Bold",
        fontsize=13,
        padding=2,
        foreground=colors["fg"],
    )

    screens = [
        Screen(
            top=bar.Bar(
                [
                    widget.Spacer(length=15),
                    widget.TextBox(text="", foreground=colors["blue"], fontsize=20, padding=10),
                    widget.GroupBox(
                        highlight_method='block',
                        this_current_screen_border=colors["curr"],
                        active=colors["fg"],
                        inactive="#444b6a",
                        rounded=True,
                        disable_drag=True,
                        padding=5,
                    ),

                    # Dead-Center Window Name
                    widget.Spacer(length=bar.STRETCH),
                    widget.WindowName(
                        foreground=colors["fg"],
                        empty_group_string="Voidinator",
                        width=250,
                        scroll=True,
                        padding=10,
                    ),
                    widget.Spacer(length=bar.STRETCH),

                    widget.Systray(padding=10),
                    
                    widget.Spacer(length=15),
                    widget.TextBox(text="󰍛", foreground=colors["cyan"], fontsize=14),
                    widget.Memory(format="{MemUsed:.0f}MB", padding=5),
                    
                    widget.Spacer(length=10),
                    widget.TextBox(text="󰕾", foreground=colors["purple"], fontsize=14),
                    widget.GenPollText(
                        func=get_volume,
                        update_interval=1,
                        padding=5,
                        mouse_callbacks={
                            'Button1': lambda: qtile.cmd_spawn("pamixer -t"),
                            'Button4': lambda: qtile.cmd_spawn("pamixer -i 5"),
                            'Button5': lambda: qtile.cmd_spawn("pamixer -d 5"),
                        },
                    ),
                    
                    widget.Spacer(length=10),
                    widget.TextBox(text="", foreground=colors["blue"], fontsize=14, padding=5),
                    widget.Clock(format="%I:%M %p", padding=5),
                    
                    widget.Spacer(length=10),
                    widget.TextBox(
                        text="", 
                        foreground=colors["red"],
                        padding=10,
                        mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("rofi -show power-menu -modi power-menu:rofi-power-menu")},
                    ),
                    widget.Spacer(length=15),
                ],
                30,
                background=colors["bg"],
                margin=[10, 20, 0, 20], # Floating effect
            ),
        ),
    ]

    mouse = [
        Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
        Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    ]

    from libqtile import hook
    import os

    @hook.subscribe.startup_once
    def autostart():
        subprocess.Popen(["nitrogen", "--restore"])
    
    wmname = "LG3D"
  '';
}
