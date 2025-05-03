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

    containerVersion = lib.mkOption {
      type = lib.types.str;
      default = "latest";
      description = "portainer version";
    };
  };
  
  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      siren.docker.enable = true;

      virtualisation.oci-containers.backend = "docker";
      virtualisation.oci-containers.containers.portainer = {
        image = "portainer/portainer-ce:${cfg.containerVersion}";
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
          "portainer_data:/data"
        ];
        ports = [
          "${if cfg.enableNginx then "127.0.0.1:" else ""}8000:8000"
          "${if cfg.enableNginx then "127.0.0.1:" else ""}9443:9443"
        ];
      };
    }

    (lib.mkIf cfg.enableNginx {
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
    })
  ]);
  
  
}
