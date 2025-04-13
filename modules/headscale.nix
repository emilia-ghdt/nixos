{ lib, pkgs, config, ... }:
let cfg = config.siren.headscale;
in
{
  options.siren.headscale = {
    enable = lib.mkEnableOption "activate headscale";
    enableNginx = lib.mkEnableOption "activate nginx proxy";

    port = lib.mkOption {
      type = lib.types.port;
      default = 8443;
      description = "port to listen on";
    };

    domain = lib.mkOption {
      type = lib.types.str;
      default = "headscale.nyriad.de"; #${config.siren.domain}";
      description = "domain name for headscale";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      services.headscale = {
        enable = true;
        address = "127.0.0.1";
        port = cfg.port;
        serverUrl = "https://${cfg.domain}";
        settings = {
          dns = {
            baseDomain = "nyriad.internal";
          };
        };
      };
    }

    (lib.mkIf cfg.enableNginx {
      siren.nginx.enable = true;

      services.nginx.virtualHosts."${cfg.domain}" = {
        forceSSL = true;

        sslCertificate = "/var/lib/acme/${config.siren.domain}/cert.pem";
        sslCertificateKey = "/var/lib/acme/${config.siren.domain}/key.pem";

        locations."/" = {
          proxyPass = "http://127.0.0.1:${builtins.toString cfg.port}";
        };
      };
    })

  ]);

}
