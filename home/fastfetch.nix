{ config, pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "/home/anirudh/Pictures/nixos-logo.png";
        type = "kitty";
        height = 10;
        padding = {
          top = 0;
        };
      };
      display = {
        separator = " ";
      };
      modules = [
        "break"
        {
          type = "title";
          keyWidth = 10;
        }
        {
          type = "custom";
          format = "~~~~~~~~~~~~~~~~~~~~~~~~~~";
        }
        {
          type = "os";
          key = "~ ";
          keyColor = "34";
        }
        {
          type = "kernel";
          key = "~ ";
          keyColor = "34";
        }
        {
          type = "packages";
          # Changed to nix to match your current system!
          format = "{} (nix)";
          key = "~ ";
          keyColor = "34";
        }
        {
          type = "shell";
          key = "~ ";
          keyColor = "34";
        }
        {
          type = "terminal";
          key = "~ ";
          keyColor = "34";
        }
        {
          type = "wm";
          key = "~ ";
          keyColor = "34";
        }
        {
          type = "uptime";
          key = "~ ";
          keyColor = "34";
        }
        {
          type = "media";
          key = "~ ";
          keyColor = "34";
        }
        {
          type = "player";
          key = "~ ";
          keyColor = "34";
        }
        "break"
      ];
    };
  };
}
