{ pkgs, ... }:

{
  home.packages = with pkgs; [ 
    xorg.xset 
    xautolock 
  ];

  xsession.initExtra = ''
    # 📺 1. Monitor off after 10 mins (600s)
    ${pkgs.xorg.xset}/bin/xset +dpms
    ${pkgs.xorg.xset}/bin/xset dpms 600 600 600 &

    # 💤 2. System sleep after 15 mins
    # -time is in minutes
    # -locker is the command to run
    ${pkgs.xautolock}/bin/xautolock -time 15 -locker "/run/current-system/sw/bin/systemctl suspend" &
  '';
}
