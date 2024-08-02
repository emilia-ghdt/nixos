{ config, flake-self, system-config, pkgs, lib, ... }:
with lib;
let cfg = config.siren.ssh;
in
{
  options.siren.ssh = {
    enable = mkEnableOption "ssh config";
  };
  config = mkIf cfg.enable {
    # TODO
  };
}
