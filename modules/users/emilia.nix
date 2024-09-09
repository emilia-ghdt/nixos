{ config, pkgs, lib, ... }:
let cfg = config.siren.users.emilia;
in
{
  options.siren.users.emilia = {
    enable = lib.mkEnableOption "user emilia";
  };
  
  config = lib.mkIf cfg.enable {
    users.users.emilia = {
      isNormalUser = true;
      description = "Emilia Groß-Hardt";
      shell = pkgs.fish;
      extraGroups = [ "networkmanager" "wheel" "dialout" ]
      ++ lib.optionals config.siren.wayland.enable [ "audio" "video" ];
	initialPassword = "1";
    };
  };
}
