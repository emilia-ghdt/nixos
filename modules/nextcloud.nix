{ config, flake-self, system-config, pkgs, lib, ... }:
let cfg = config.siren.nextcloud;
in
{
  options.siren.nextcloud = {
    enable = lib.mkEnableOption "nextcloud";
  };
  
  config = lib.mkIf cfg.enable {
    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud31;
      # https = true;
      hostName = "aquarius.knniff.internal";
      enableImagemagick = false;
      notify_push.enable = true;
      datadir = "/data/nextcloud";
      config.adminpassFile = "/run/secrets/nextcloud/admin-pass";
      config.dbtype = "sqlite";
    };

    sops.secrets = {
      "nextcloud/admin-pass" = {
        owner = "nextcloud";
      };
    };
  };
}
