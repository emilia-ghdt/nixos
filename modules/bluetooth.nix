{ config, flake-self, system-config, pkgs, lib, ... }:
let cfg = config.siren.bluetooth;
in
{
  options.siren.bluetooth = {
    enable = lib.mkEnableOption "bluetooth";
  };
  
  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true; # enables support for Bluetooth
      powerOnBoot = true; # powers up the default Bluetooth controller on boot
      settings = {
        General = {
          Experimental = true;
        };
      };
    };

    services.blueman.enable = true;
  };
}
