{ lib, pkgs, ... }:
with lib; {
  imports = [ ../modules ./common/convertible.nix ];

  siren.programs = {
    hyprland.monitors = [
      "eDP-1, 1920x1200@120, 0x0, 1"
      "HDMI-A-1, preferred, auto-up, auto"
    ];
  };
  
  fonts.fontconfig.enable = true;
  
  services.kdeconnect = {
    enable = true;
    indicator = false;
  };
  
  home.packages = with pkgs; [
    ungoogled-chromium
  ];
}
