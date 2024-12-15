{ config, flake-self, system-config, pkgs, lib, ... }:
let cfg = config.siren.portainer;
in
{
  options.siren.portainer = {
    enable = lib.mkEnableOption "portainer";
    enableNginx = lib.mkEnableOption "nginx reverse proxy";

    domain = lib.mkOption {
      type = lib.types.str;
      default = "portainer.nyriad.de"; #${config.siren.domain}";
      description = "domain name for portainer";
    };

  };
  
  config =
      # TODO
    lib.mkIf cfg.enableNginx {
      siren.nginx.enable = true;

      services.nginx.virtualHosts = {
        "portainer.${config.siren.domain}" = {
          forceSSL = true;

          sslCertificate = "/var/lib/acme/${config.siren.domain}/cert.pem";
          sslCertificateKey = "/var/lib/acme/${config.siren.domain}/key.pem";

          locations."/" = {
            proxyPass = "https://localhost:9443";
          };
        };
      };
    };
  
  
}
