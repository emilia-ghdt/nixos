{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.wezterm;
in
{
  options.siren.programs.wezterm.enable = mkEnableOption "wezterm";

  config = mkIf cfg.enable {
    home.sessionVariables = {
      TERMINAL = "wezterm";
    };
    wayland.windowManager.sway.config.terminal = "wezterm";
    
    programs.wezterm = {
      enable = true;
      package = pkgs.wezterm;

      # TODO: interpolate with color theme
      extraConfig = builtins.readFile ./settings.lua;
    };

  };
}
