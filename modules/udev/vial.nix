{ config, pkgs, lib, ... }:
let cfg = config.siren.udev;
in
{
  config = lib.mkIf cfg.enable {
    services.udev.packages = with pkgs; [
      via
      vial
    ];
  };
}
