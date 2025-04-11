{ config, flake-self, system-config, pkgs, lib, ... }:
let cfg = config.siren.plasma;
in
{
  options.siren.plasma = {
    enable = lib.mkEnableOption "plasma";
  };
  
  config = lib.mkIf cfg.enable {
    # Enable the KDE Plasma Desktop Environment.
    services.desktopManager.plasma6.enable = true;
    services.xserver.enable = true;
  };
}
