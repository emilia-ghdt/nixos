{ lib, pkgs, ... }:
{
  imports = [ ../modules ./common/desktop.nix ./common/gaming.nix ];

  siren.programs = {
    hyprland.monitors = [
      "HDMI-A-1, 3840x2160@120, 0x0, 1"
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
