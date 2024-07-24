{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.tlp;
in
{
  options.siren.tlp.enable = mkEnableOption "enable tlp config";

  config = mkIf cfg.enable {#
    # disable power profiles daemon
    services.power-profiles-daemon.enable = mkForce false;
    # use tlp instead
    services.tlp = {
      enable = mkDefault true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "balance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        
        CPU_MIN_PERF_ON_AC = 10;
        CPU_MAX_PERF_ON_AC = 80;

        CPU_MIN_PERF_ON_BAT = 10;
        CPU_MAX_PERF_ON_BAT = 50;

        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
  };
}
