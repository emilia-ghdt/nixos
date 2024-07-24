{ config, flake-self, system-config, pkgs, lib, ... }:
with lib;
let cfg = config.link.convertible;
in
{
  options.link.convertible = {
    enable = mkEnableOption "activate convertible laptop";
  };
  config = mkIf cfg.enable {
    hardware.sensor.iio.enable = true;
    environment.systemPackages = with pkgs; [
      wacomtablet
      xf86_input_wacom
      maliit-keyboard
    ];
  };
}
