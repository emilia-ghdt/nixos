{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.alacritty;
in
{
  options.siren.programs.alacritty.enable = mkEnableOption "alacritty";

  config = mkIf cfg.enable {
    siren.fonts.enable = mkDefault true;
    
    home.sessionVariables = {
      TERMINAL = "alacritty";
    };
    wayland.windowManager.sway.config.terminal = "alacritty";
    
    programs.alacritty = {
      enable = true;

      # TODO: interpolate with color theme
      settings = import ./settings.nix;
    };

  };
}
