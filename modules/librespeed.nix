{ lib, pkgs, config, ... }:
let cfg = config.siren.librespeed;
in
{
  options.siren.librespeed = {
    enable = lib.mkEnableOption "activate librespeed";
    enableNginx = lib.mkEnableOption "activate nginx proxy";

    port = lib.mkOption {
      type = lib.types.port;
      default = 5894;
      description = "port to listen on";
    };

    domain = lib.mkOption {
      type = lib.types.str;
      default = "speedtest.nyriad.de"; #${config.siren.domain}";
      description = "domain name for librespeed";
    };

    title = lib.mkOption {
      type = lib.types.str;
      default = "LibreSpeed";
      description = "title to display";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      # siren.docker.enable = true;

      virtualisation.oci-containers.containers.librespeed = {
        autoStart = true;
        image = "adolfintel/speedtest";
        environment = {
          TITLE = "${cfg.title}";
          ENABLE_ID_OBFUSCATION = "true";
          WEBPORT = builtins.toString cfg.port;
          MODE = "standalone";
        };
        ports = [ "${builtins.toString cfg.port}:${builtins.toString cfg.port}/tcp" ];
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

      systemd.services.docker-librespeed = {
        preStop = "${pkgs.docker}/bin/docker kill librespeedtest";
      };
    })

  ]);

}
