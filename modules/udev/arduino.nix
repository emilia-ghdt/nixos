{ config, flake-self, system-config, pkgs, lib, ... }:
with lib;
let cfg = config.siren.udev;
in
{
  config = mkIf cfg.enable {
    services.udev.packages = with pkgs; [
      arduino-ide
      # adafruit-nrfutil
    ];
  };
}
