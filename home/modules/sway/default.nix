{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.sway;
in
  {
  options.siren.programs.sway.enable = mkEnableOption "sway config";

  config = mkIf cfg.enable {
    wayland.windowManager.sway = {
      enable = true;
      config = rec {
        modifier = "Mod4";
        startup = [
          # Launch Firefox on start
          # {
          #   command = "firefox";
          # }
        ];
        input = {
          "type:keyboard" = {
            xkb_layout = "us";
            xkb_variant = "altgr-intl";
            xkb_numlock = "enabled";
          };
          "type:touchpad" = {
            click_method = "clickfinger";
            tap = "enabled";
          };   
        };
      };
    };

    home.packages = with pkgs; [
      swaylock
      swaybg
    ];
  };
}
