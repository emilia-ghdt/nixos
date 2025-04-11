{ lib, pkgs, config, ... }:
let cfg = config.siren.laptop;
in
{
  options.siren.laptop.enable = lib.mkEnableOption "laptop config";

  config = lib.mkIf cfg.enable {
    siren = {
      desktop.enable = true;
      bluetooth.enable = true;
    };
    
    programs.light.enable = true;
  };
}
