{ lib, pkgs, stable, flake-self, config, home-manager, ... }:
with lib;
let cfg = config.siren.common;
in
{
  options.siren.common.enable = mkEnableOption "enable common config";
  
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      neovim
      git
      wget
      bat
      btop
      tree
      du-dust
      ripgrep
      nix-ld
      busybox
    ] ++ [ flake-self.inputs.nix-autobahn ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Enable nix command and flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
