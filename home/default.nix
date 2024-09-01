{ config, pkgs, lib, flake-self, home-manager, ... }:
with lib;
let 
  cfg = config.siren.home-manager;
in
{
  options.siren.home-manager = {
    enable = mkEnableOption "home-manager configuration";

    # TODO support multiple users with home manager
    username = mkOption {
      type = types.str;
      default = "emilia";
      description = "Main user";
    };

    profile = mkOption {
      type = types.str;
      description = "Profile to use";
      example = "desktop";
    };

    stateVersion = mkOption {
      type = types.str;
      description = "State version for backwards compatibility";
      example = "23.05";
    };
  };

  imports = [ home-manager.nixosModules.home-manager ];

  config = mkIf cfg.enable {
    # DON'T set useGlobalPackages! It's not necessary in newer
    # home-manager versions and does not work with configs using
    # nixpkgs.config`
    home-manager.useUserPackages = true;

    home-manager.extraSpecialArgs = { inherit flake-self; system-config = config; };
    home-manager.users."${cfg.username}" = {
      imports = [
        {
          home.stateVersion = config.siren.home-manager.stateVersion;

          # Home Manager needs a bit of information about you and the paths it should manage.
          home.username = "${config.siren.home-manager.username}";
          home.homeDirectory = "/home/${config.siren.home-manager.username}";
        }
        (./profiles + "/${cfg.profile}.nix")
        flake-self.inputs.nixvim.homeManagerModules.nixvim
      ];
    };
  };
}