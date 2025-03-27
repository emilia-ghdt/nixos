{ lib, pkgs, config, ... }:
let cfg = config.siren.laptop;
in
{
  options.siren.laptop.enable = lib.mkEnableOption "laptop config";

  config = lib.mkIf cfg.enable {
    siren = {
      desktop.enable = true;
      # TODO: autocpufreq
      bluetooth.enable = true;
      autocpufreq.enable = true;
    };
    
    programs.light.enable = true;
  };
}
