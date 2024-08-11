{ lib, pkgs, ... }:
with lib; {
  imports = [ ../modules ./common/convertible.nix ];

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
