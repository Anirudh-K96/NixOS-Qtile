{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    # We use extraConfig to pass the raw RASI theme string directly
    extraConfig = {
      modi = "run,drun,window";
      icon-theme = "Papirus";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 󰕰  Window ";
      sidebar-mode = true;
    };

    theme = let
      # This helper ensures Nix handles the RASI types correctly
      inherit (config.lib.formats.rasi) mkLiteral;
    in 
    # Using a raw string here is much easier for complex themes like this
    builtins.toFile "tokyonight.rasi" ''
      * {
          bg: #24283b;
          hv: #9274ca; 
          primary: #C5C8C6; 
          ug: #0B2447;
          font: "JetBrainsMono Nerd Font 11";
          background-color: @bg;
          border: 0px;
          kl: #7aa2f7;
          black: #000000;
          transparent: rgba(46,52,64,0);
      }

      window {
          width: 700;
          orientation: horizontal;
          location: center;
          anchor: center;
          transparency: "screenshot";
          border-color: @transparent;   
          border: 0px;
          border-radius: 6px;
          spacing: 0;
          children: [ mainbox ];
      }

      mainbox {
          spacing: 0;
          children: [ inputbar, message, listview ];
      }

      inputbar {
          color: @kl;
          padding: 11px;
          border: 3px 3px 2px 3px;
          border-color: @primary;
          border-radius: 6px 6px 0px 0px;
      }

      message {
          padding: 0;
          border-color: @primary;
          border: 0px 1px 1px 1px;
      }

      entry, prompt, case-indicator {
          text-font: inherit;
          text-color: inherit;
      }

      prompt {
          margin: 0px 5px 0px 0px;
      }

      listview {
          layout: vertical;
          padding: 8px;
          lines: 7;
          columns: 1;
          border: 0px 3px 3px 3px; 
          border-radius: 0px 0px 6px 6px;
          border-color: @primary;
          dynamic: false;
      }

      element {
          padding: 2px;
          vertical-align: 1;
          color: @kl;
          font: inherit;
      }

      element-text {
          background-color: inherit;
          text-color: inherit;
          vertical-align: 0.5;
      }

      element selected.normal {
          color: @black;
          background-color: @hv;
      }

      element normal active {
          background-color: @hv;
          color: @black;
      }

      element-icon {
          background-color: inherit;
          text-color: inherit;
          size: 2.5em;
      }

      element normal urgent {
          background-color: @primary;
      }

      element selected active {
          background: @hv;
          foreground: @bg;
      }

      button {
          padding: 6px;
          color: @primary;
          horizontal-align: 0.5;
          border: 2px 0px 2px 2px;
          border-radius: 4px 0px 0px 4px;
          border-color: @primary;
      }

      button selected normal {
          border: 2px 0px 2px 2px;
          border-color: @primary;
      }
    '';
  };
}
