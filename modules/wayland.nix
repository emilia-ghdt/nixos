{ lib, pkgs, config, ... }:
let cfg = config.siren.wayland;
in
{
  options.siren.wayland.enable = lib.mkEnableOption "wayland config";

  config = lib.mkIf cfg.enable {
    # xdg-desktop-portal works by exposing a series of D-Bus interfaces
    # known as portals under a well-known name
    # (org.freedesktop.portal.Desktop) and object path
    # (/org/freedesktop/portal/desktop).
    # The portal interfaces include APIs for file access, opening URIs,
    # printing and others.
    services.dbus.enable = true;

    security = {
      # Allow swaylock to unlock the computer for us
      polkit.enable = true;
      rtkit.enable = true;
    };

    environment.systemPackages = with pkgs; [
      wl-clipboard-rs
    ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
