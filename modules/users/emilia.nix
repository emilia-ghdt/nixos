{ config, flake-self, system-config, pkgs, lib, ... }:
with lib;
let cfg = config.siren.users.emilia;
in
{
  options.siren.users.emilia = {
    enable = mkEnableOption "user emilia";
  };
  
  config = mkIf cfg.enable {
    users.users.emilia = {
      isNormalUser = true;
      description = "Emilia Groß-Hardt";
      shell = pkgs.fish;
      extraGroups = [ "networkmanager" "wheel" "dialout" ]
      ++ lib.optionals config.siren.wayland.enable [ "audio" "video" ];
    };
  };
}
