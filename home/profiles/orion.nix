{ lib, pkgs, ... }:
with lib; {
  imports = [ ../modules ./common/desktop.nix ];

  siren.programs = {
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
