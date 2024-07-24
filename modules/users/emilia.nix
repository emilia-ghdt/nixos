{ config, flake-self, system-config, pkgs, lib, ... }:
with lib;
let cfg = config.siren.users.emilia;
in
{
  options.siren.users.emilia = {
    enable = mkEnableOption "enable user emilia";
  };
  
  config = mkIf cfg.enable {
    users.users.emilia = {
      isNormalUser = true;
      description = "Emilia Groß-Hardt";
      extraGroups = [ "networkmanager" "wheel" "dialout" ];
    };
  };
}
