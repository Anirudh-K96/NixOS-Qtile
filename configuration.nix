{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot = {
   enable = true;
   consoleMode  = "1";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.plymouth = {
    enable = true;
    theme = "cuts"; 
    themePackages = [ 
      (pkgs.adi1090x-plymouth-themes.override { 
        selected_themes = [ "cuts" ]; 
      }) 
    ];
  };

  # Keep these to make sure the theme actually shows up!
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.kernelParams = [ "quiet" "splash" "boot.shell_on_fail" "loglevel=3" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" ];

  networking.hostName = "voidinator";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";

  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager.sddm.enable = false;
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      clear_password = true;
      save = true;
      load = true;
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  programs.fish.enable = true;

  programs.git = {
  enable = true;
  config = {
    user = {
      name = "Anirudh Kosgi";
      email = "anirudh.kosgi@gmail.com";
    };
    init = {
      defaultBranch = "main"; 
    };
    };
  };
  
  users.users.anirudh = {
    isNormalUser = true;
    description = "anirudh";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";

  # This symlinks your user's helix config to root's config
  system.activationScripts.rootHelixConfig = {
    text = ''
      mkdir -p /root/.config/helix
      ln -sfn /home/anirudh/.config/helix/config.toml /root/.config/helix/config.toml
      ln -sfn /home/anirudh/.config/helix/themes /root/.config/helix/themes
    '';
  };
}
