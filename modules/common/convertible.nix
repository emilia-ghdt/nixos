{ config, pkgs, lib, ... }:
let cfg = config.siren.convertible;
in
{
  options.siren.convertible = {
    enable = lib.mkEnableOption "activate convertible config";
  };

  config = lib.mkIf cfg.enable {
    siren.laptop.enable = true;
    # TODO: screen rotation, wacom support

    hardware.sensor.iio.enable = lib.mkDefault true;
    environment.systemPackages = with pkgs; [
      wacomtablet
      xf86_input_wacom
      maliit-keyboard
    ];
  };
}
