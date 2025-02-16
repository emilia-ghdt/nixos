{ config, flake-self, system-config, pkgs, lib, ... }:
let cfg = config.siren.docker;
in
{
  options.siren.vm = {
    enable = lib.mkEnableOption "enable vm config";
  };
  
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.qemu ];
  };
}
