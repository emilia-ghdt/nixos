{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.wayland;
in
{
  options.siren.wayland.enable = mkEnableOption "wayland config";

  config = mkIf cfg.enable {
    # xdg-desktop-portal works by exposing a series of D-Bus interfaces
    # known as portals under a well-known name
    # (org.freedesktop.portal.Desktop) and object path
    # (/org/freedesktop/portal/desktop).
    # The portal interfaces include APIs for file access, opening URIs,
    # printing and others.
    services.dbus.enable = true;

    xdg = {
      mime.enable = true;
      icons.enable = true;

      portal = {
        enable = true;
        wlr.enable = true;
        xdgOpenUsePortal = true;
        configPackages = with pkgs; [ xdg-desktop-portal-hyprland xdg-desktop-portal-wlr ]
          ++ lib.optionals (config.siren.plasma.enable) [ kdePackages.xdg-desktop-portal-kde ];
        extraPortals = with pkgs; [ xdg-desktop-portal-hyprland xdg-desktop-portal-wlr ]
          ++ lib.optionals (config.siren.plasma.enable) [ kdePackages.xdg-desktop-portal-kde ];
      };
    };

    security = {
      # Allow swaylock to unlock the computer for us
      pam.services.swaylock.text = "auth include login";
      pam.services.hyprlock = {};
      polkit.enable = true;
      rtkit.enable = true;
    };

    environment.systemPackages = with pkgs; [
      wl-clipboard-rs
    ];

    programs.light.enable = true;
  };
}
