{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.laptop;
in
{
  options.siren.laptop.enable = mkEnableOption "laptop config";

  config = mkIf cfg.enable {
    siren = {
      desktop.enable = true;
      nvidia.onTheGoBootOption = mkDefault true;
      # TODO: autocpufreq
      tlp.enable = true;
      nvidia.hasIGpu = true;
    };
    
    hardware.bluetooth = {
      enable = true; # enables support for Bluetooth
      powerOnBoot = true; # powers up the default Bluetooth controller on boot
    };
  };
}
