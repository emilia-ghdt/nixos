{ config, flake-self, system-config, pkgs, lib, ... }:
let cfg = config.siren.fingerprint;
in
{
  options.siren.fingerprint = {
    enable = lib.mkEnableOption "fingerprint";
  };
  
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.fprintd
    ];

    services.fprintd.enable = true;
  };
}
