{ lib, pkgs, config, ... }:
let cfg = config.siren.netbird;
in
{
  options.siren.ytblock = {
    enable = lib.mkEnableOption "netbird config";
  };

  config = lib.mkIf cfg.enable {
    networking.extraHosts = "0.0.0.0 youtube.com\n0.0.0.0 www.youtube.com";
  };
}
