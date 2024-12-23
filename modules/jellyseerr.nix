{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.jellyseerr;
in
{
  options.siren.jellyseerr = {
    enable = mkEnableOption "activate jellyseerr";
    openFirewall = mkOption {
      type = types.bool;
      default = true;
      description = "allow jellyseerr port in firewall";
    };

    port = mkOption {
      type = types.port;
      default = 5055;
      description = "Port to listen on";
    };
  };


  config = mkIf cfg.enable {
    siren.sonarr.enable = true;
    siren.radarr.enable = true;

    services.jellyseerr = {
      enable = true;
      port = cfg.port;
      openFirewall = cfg.openFirewall;
    };

  };

}
