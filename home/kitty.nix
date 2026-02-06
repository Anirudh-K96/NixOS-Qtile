{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };

    settings = {
      background_opacity = "0.9";
      confirm_os_window_close = 0;
      window_padding_width = 10;
      
      # Manual Tokyo Night Storm Colors
      foreground = "#c0caf5";
      background = "#1a1b26";
      selection_foreground = "#c0caf5";
      selection_background = "#33467c";
      cursor = "#c0caf5";
      cursor_text_color = "#1a1b26";
      url_color = "#73daca";
      
      # Tabs
      active_tab_foreground = "#16161e";
      active_tab_background = "#7aa2f7";
      inactive_tab_foreground = "#787c99";
      inactive_tab_background = "#16161e";
      
      # Windows
      active_border_color = "#7aa2f7";
      inactive_border_color = "#292e42";
    };
  };
}
