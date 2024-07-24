{ config, flake-self, system-config, pkgs, lib, ... }:
with lib;
let cfg = config.siren.convertible;
in
{
  options.siren.convertible = {
    enable = mkEnableOption "activate convertible config";
  };

  config = mkIf cfg.enable {
    # TODO: screen rotation, wacom support

    hardware.sensor.iio.enable = mkDefault true;
    environment.systemPackages = with pkgs; [
      wacomtablet
      xf86_input_wacom
      maliit-keyboard
    ];
  };
}
