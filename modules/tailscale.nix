{ lib, pkgs, config, ... }:
let cfg = config.siren.tailscale;
in
{
  options.siren.tailscale = {
    enable = lib.mkEnableOption "tailscale config";
  };

  config = lib.mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      openFirewall = true;
    };
  };
}
