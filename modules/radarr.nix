{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.radarr;
in
{
  options.siren.radarr = {
    enable = mkEnableOption "activate radarr";
    openFirewall = mkOption {
      type = types.bool;
      default = true;
      description = "allow radarr port in firewall";
    };
  };

  config = mkIf cfg.enable {
    siren.groups.arr.enable = true;
    siren.prowlarr.enable = true;

    users.users.radarr.uid = mkForce 7878;
    users.users.radarr.isSystemUser = true;

    services.radarr = {
      enable = true;
      user = "radarr";
      group = "arr";
      openFirewall = cfg.openFirewall;
    };
  };
}

