{ config, flake-self, system-config, pkgs, lib, ... }:
let cfg = config.siren.ssh;
in
{
  options.siren.ssh = {
    enable = lib.mkEnableOption "ssh config";
  };
  config = lib.mkIf cfg.enable {
    # TODO
  };
}
