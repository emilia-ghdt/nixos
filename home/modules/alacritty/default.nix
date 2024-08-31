{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.alacritty;
in
{
  options.siren.programs.alacritty.enable = mkEnableOption "alacritty";

  config = mkIf cfg.enable {
    home.sessionVariables = {
      TERMINAL = "alacritty";
    };
    wayland.windowManager.sway.config.terminal = "alacritty";
    siren.programs.hyprland.terminal = "${pkgs.alacritty}/bin/alacritty";
    
    programs.alacritty = {
      enable = true;
    };

  };
}
