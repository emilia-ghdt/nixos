{ config, flake-self, system-config, pkgs, lib, ... }:
let cfg = config.siren.virtualbox;
in
{
  options.siren.virtualbox = {
    enable = lib.mkEnableOption "virtualbox";
  };
  
  config = lib.mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;
  };
}
