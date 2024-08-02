{ config, flake-self, system-config, pkgs, lib, ... }:
with lib;
let cfg = config.siren.plasma;
in
{
  options.siren.plasma = {
    enable = mkEnableOption "plasma";
  };
  
  config = mkIf cfg.enable {
    # Enable the KDE Plasma Desktop Environment.
    services.desktopManager.plasma6.enable = true;
  };
}
