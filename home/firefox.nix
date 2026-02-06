{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    
    profiles.anirudh = {
      search.default = "ddg";
      search.force = true;

      # Extension for Tokyo Night (using the official Add-on ID)
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        # Note: This requires the NUR (Nix User Repository) or 
        # you can just install the theme manually once.
      ];

      # 🔒 The Privacy/Telemetry Lockdown
      settings = {
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "experiments.activeExperiment" = false;
        "experiments.enabled" = false;
        "experiments.supported" = false;
        "network.allow-experiments" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        
      };
    };
  };
}
