{ config, pkgs, ... }:

{
  home.username = "anirudh";
  home.homeDirectory = "/home/anirudh";
  home.stateVersion = "25.11";

  # Import your modules here
  imports = [
    ./home/qtile.nix
    ./home/kitty.nix
    ./home/fish.nix
    ./home/helix.nix
    ./home/starship.nix
    ./home/wallpaper.nix
    ./home/rofi.nix
    ./home/firefox.nix
    ./home/fastfetch.nix
    ./home/idle.nix
  ];

  # Extra packages that don't need a full config file yet
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    fastfetch
    cmatrix
    dysk
    yazi
  ];

  programs.home-manager.enable = true;
}
