{ config, flake-self, system-config, pkgs, lib, ... }:
with lib;
let cfg = config.siren.plasma;
in
{
  options.siren.plasma = {
    enable = mkEnableOption "enable plasma";
  };
  
  config = mkIf cfg.enable {
    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}
