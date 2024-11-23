{ lib, pkgs, config, ... }:
let cfg = config.siren.laptop;
in
{
  options.siren.laptop.enable = lib.mkEnableOption "laptop config";

  config = lib.mkIf cfg.enable {
    siren = {
      desktop.enable = true;
      # TODO: autocpufreq
      autocpufreq.enable = true;
    };
    
    hardware.bluetooth = {
      enable = true; # enables support for Bluetooth
      powerOnBoot = true; # powers up the default Bluetooth controller on boot
    };

    programs.light.enable = true;
  };
}
