{ config, flake-self, system-config, pkgs, lib, ... }:
with lib;
let cfg = config.siren.xserver;
in
{
  options.siren.xserver = {
    enable = mkEnableOption "enable xserver config";
  };
  
  config = mkIf cfg.enable {
    services.xserver.enable = true;
  };
}
