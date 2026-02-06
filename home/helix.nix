{ config, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "tokyonight";
      editor = {
        line-number = "relative";
        color-modes = true; 
        
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        statusline = {
          left = ["mode" "spinner" "file-name" "read-only-indicator"];
          center = ["version-control" "diagnostics"];
          right = ["file-type" "file-encoding" "position" "total-line-numbers"];
          
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };

        idle-timeout = 200; 
        true-color = true;
      };
    };
  };
}
