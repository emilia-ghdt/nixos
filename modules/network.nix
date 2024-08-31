{ lib, pkgs, config, ... }:
let cfg = config.siren.networking;
in
{
  options.siren.networking = {
    ports = {
      localsend = lib.mkEnableOption "allow localsend port";
    };
  };

  config = lib.mkIf cfg.ports.localsend {
    networking.firewall.allowedTCPPorts = [ 53317 ];
    networking.firewall.allowedUDPPorts = [ 53317 ];
  };
}
