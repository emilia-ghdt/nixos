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
      # https = true;
      hostName = "aquarius.knniff.internal";
      enableImagemagick = false;
      notify_push.enable = true;
      datadir = "/vault/nextcloud";
      config.adminpassFile = "/run/secrets/netcup/admin-pass";
    };

    sops.secrets = {
      "netcup/admin-pass" = {
        owner = "nextcloud";
      };
    };
  };
}
