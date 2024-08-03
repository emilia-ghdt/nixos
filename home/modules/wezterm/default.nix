{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.wezterm;
in
{
  options.siren.programs.wezterm.enable = mkEnableOption "wezterm";

  config = mkIf cfg.enable {
    siren.fonts.enable = mkDefault true;
    
    home.sessionVariables = {
      TERMINAL = "wezterm";
    };
    wayland.windowManager.sway.config.terminal = "${pkgs.wezterm}/bin/wezterm";
    wayland.windowManager.hyprland.settings.terminal = "${pkgs.wezterm}/bin/wezterm";

    programs.wezterm = {
      enable = true;

      # TODO: interpolate with color theme
      extraConfig = builtins.readFile ./settings.lua;
    };

  };
}
