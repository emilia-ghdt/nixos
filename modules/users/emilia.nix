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
      extraGroups = [ "networkmanager" "wheel" "input" "uinput" ]
	  ++ lib.optionals config.siren.wayland.enable [ "audio" "video" ]
	  ++ lib.optionals config.siren.udev.enable [ "plugdev" "dialout" ]
          ++ lib.optionals config.siren.docker.enable [ "docker" ]
          ++ lib.optionals config.siren.virtualbox.enable [ "user-with-access-to-virtualbox" ];
      initialPassword = "1";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGkNqsh2GgeSKML7hZKkXlGDLXHEdXYQw+CHK/Emilia orion/cassiopeia"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG068VL02MKo28ZtJmInCWizZ1AKU+zYFxSI1l+WgPyL nix-on-droid@localhost"
      ];
    };
  };
}
