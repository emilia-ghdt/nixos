{ lib, pkgs, config, ... }:
let cfg = config.siren.hyprland;
in
{
  options.siren.hyprland.enable = lib.mkEnableOption "wayland config";

  config = lib.mkIf cfg.enable {
    programs.hyprland.enable = true;
    programs.hyprland.xwayland.enable = true;

    environment = {
      sessionVariables = {
      };
    };

    security = {
      # Allow swaylock to unlock the computer for us
      pam.services.swaylock.text = "auth include login";
      pam.services.hyprlock = {};
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      xdgOpenUsePortal = true;
    };
  };
}
