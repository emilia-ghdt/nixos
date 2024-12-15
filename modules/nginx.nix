{ config, flake-self, system-config, pkgs, lib, ... }:
let cfg = config.siren.nginx;
in
{
  options.siren.nginx = {
    enable = lib.mkEnableOption "nginx";
  };
  
  config = lib.mkIf cfg.enable {
    services.nginx = {
      enable = true;
      clientMaxBodySize = "8196m"; # 8GiB
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts = {
        "${config.siren.domain}" = {
          serverAliases = [ "*.${config.siren.domain}" ];

          addSSL = true;

          sslCertificate = "/var/lib/acme/${config.siren.domain}/cert.pem";
          sslCertificateKey = "/var/lib/acme/${config.siren.domain}/key.pem";

          locations = {
            "*" = {
              return = "404";
            };
            "/" = {
              return = "404";
            };
          };
        };
      };
    };
  };
}
