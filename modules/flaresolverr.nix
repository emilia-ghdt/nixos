{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.flaresolverr;
in
{

  options.siren.flaresolverr = {
    enable = mkEnableOption "activate flaresolverr";
    openFirewall = mkOption {
      type = types.bool;
      default = true;
      description = "open the firewall for flaresolverr";
    };

    port = mkOption {
      type = types.port;
      default = 8191;
      description = "port to listen on";
    };
  };

  config = mkIf cfg.enable {
    siren.docker.enable = true;

    virtualisation.oci-containers.containers.flaresolverr = {
      autoStart = true;
      image = "flaresolverr/flaresolverr";
      ports = [ "8191:${builtins.toString cfg.port}/tcp" ];
    };

  };
}
