{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.hyprland;
in
{
  options.siren.programs.hyprland.enable = mkEnableOption "hyprland config";

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = builtins.replaceStrings 
        [
          "wezterm"
          "yazi"
          "wofi"
        ]
        [
          "${pkgs.wezterm}/bin/wezterm"
          "${pkgs.yazi}/bin/yazi"
          "${pkgs.wofi}/bin/wofi"
        ]
        (builtins.readFile ./hyprland.conf);
    };

    # services.hypridle.enable = true;

    programs.hyprlock.enable = true;
    programs.hyprlock.settings = {};

    # home.packages = with pkgs; [
    #   swaylock
    #   swaybg
    # ];
  };
}
