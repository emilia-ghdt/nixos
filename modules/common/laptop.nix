{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.laptop;
in
{
  options.siren.laptop.enable = mkEnableOption "enable laptop config";

  config = mkIf cfg.enable {
    # TODO: autocpufreq
    siren.tlp.enable = true;

    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

  services.displayManager.sddm.enable = true;
}
