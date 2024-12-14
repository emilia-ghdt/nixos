{ lib, pkgs, config, ... }:
let cfg = config.siren.netbird;
in
{
  options.siren.netbird = {
    enable = lib.mkEnableOption "netbird config";
  };

  config = lib.mkIf cfg.enable {
    services.netbird.enable = true;
  };
}
