{ config, flake-self, system-config, pkgs, lib, ... }:
with lib;
let cfg = config.siren.xserver;
in
{
  options.siren.xserver = {
    enable = lib.mkEnableOption "xserver config";
  };
  
  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
  };
}
