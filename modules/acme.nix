{ config, flake-self, system-config, pkgs, lib, ... }:
let cfg = config.siren.acme;
in
{
  options.siren.acme = {
    enable = lib.mkEnableOption "acme";
  };
  
  config = lib.mkIf cfg.enable {
    security.acme = {
      acceptTerms = true;
      defaults.email = "emilia.ghdt+acme@gmail.com";
      certs."${config.siren.domain}" = {
        domain = "*.${config.siren.domain}";
        extraDomainNames = [
          "${config.siren.domain}"
        ];
        dnsProvider = "netcup";
        credentialFiles = {
          "NETCUP_CUSTOMER_NUMBER_FILE" = "/run/secrets/netcup-api/customer-number";
          "NETCUP_API_KEY_FILE" = "/run/secrets/netcup-api/api-key";
          "NETCUP_API_PASSWORD_FILE" = "/run/secrets/netcup-api/api-password";
          "NETCUP_PROPAGATION_TIMEOUT_FILE" = "${pkgs.writeText "netcup-propagation-timeout" ''
          300
          ''}";
        };
        group = "nginx";
      };
      validMinDays = 30;
    };

    sops.secrets = let 
      secretConf = { mode = "0040"; group = "acme"; };
    in {
      "netcup-api/customer-number" = secretConf;
      "netcup-api/api-key" = secretConf;
      "netcup-api/api-password" = secretConf;
    };
  };
}
