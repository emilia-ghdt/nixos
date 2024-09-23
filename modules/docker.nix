{ config, flake-self, system-config, pkgs, lib, ... }:
let cfg = config.siren.docker;
in
{
  options.siren.docker = {
    enable = lib.mkEnableOption "docker";
  };
  
  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;
  };
}
