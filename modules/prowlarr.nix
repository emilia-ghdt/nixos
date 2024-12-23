{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.prowlarr;
in
{
  options.siren.prowlarr = {
    enable = mkEnableOption "activate prowlarr";
    openFirewall = mkOption {
      type = types.bool;
      default = true;
      description = "allow prowlarr port in firewall";
    };
  };

  config = mkIf cfg.enable {
    # siren.flaresolverr.enable = true;

    services.prowlarr = {
      enable = true;
      openFirewall = cfg.openFirewall;
    };
  };
}

