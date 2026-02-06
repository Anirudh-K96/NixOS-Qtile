{ config, pkgs, ... }:

{
  home.packages = [ pkgs.nitrogen ];

  # This adds the restore command to the very start of your X session
  xsession.initExtra = ''
    ${pkgs.nitrogen}/bin/nitrogen --restore &
  '';
}
