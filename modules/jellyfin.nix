{ lib, pkgs, config, ... }:
let cfg = config.siren.jellyfin;
in
{
  options.siren.jellyfin = {
    enable = lib.mkEnableOption "activate jellyfin";
    enableNginx = lib.mkEnableOption "activate nginx proxy";

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "open firewall for jellyfin";
    }; 

    domain = lib.mkOption {
      type = lib.types.str;
      default = "kino.nyriad.de"; #${config.siren.domain}";
      description = "domain name for jellyfin";
    };

    dataDir = lib.mkOption {
      type = lib.types.str;
      default = "/arr/jellyfin";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      siren.groups.arr.enable = true;

      services.jellyfin = {
        enable = true;
        dataDir = cfg.dataDir;
        openFirewall = cfg.openFirewall;
        group = "arr";
      };
    }

    (lib.mkIf cfg.enableNginx {
      siren.nginx.enable = true;

      services.nginx.virtualHosts."${cfg.domain}" = {
        forceSSL = true;

        sslCertificate = "/var/lib/acme/${config.siren.domain}/cert.pem";
        sslCertificateKey = "/var/lib/acme/${config.siren.domain}/key.pem";

        locations."/" = {
          proxyPass = "http://127.0.0.1:8096";
        };
      };
    })

  ]);

}
