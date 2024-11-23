{ config, flake-self, system-config, pkgs, lib, ... }:
let cfg = config.siren.autocpufreq;
in
{
  options.siren.autocpufreq = {
    enable = lib.mkEnableOption "autocpufreq config";
  };
  config = lib.mkIf cfg.enable {
    services.auto-cpufreq = {
      enable = true;

      settings = {
        charger = {
          governor = "performance";
          energy_performance_preference = "performance";
          turbo = "auto";
        };

        battery = {
          
        };
      };
    };
  };
}
