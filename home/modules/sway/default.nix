{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.sway;
in
{
  options.siren.programs.sway.enable = mkEnableOption "enable sway config";

  config = mkIf cfg.enable {
    wayland.windowManager.sway = {
      enable = true;
      config = rec {
        modifier = "Mod4";
        # Use alacritty as default terminal
        terminal = "alacritty";
        startup = [
          # Launch Firefox on start
          # {
          #   command = "firefox";
          # }
        ];
      };
    };

    home.packages = with pkgs; [
      swaylock
      swaybg
    ];
  };
}
