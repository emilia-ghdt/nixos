{ lib, pkgs, stable, self, flake-self, config, home-manager, ... }:
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

    nixpkgs.overlays = [ self.overlays.default ];

    nix.settings = {
      substituters = [ "https://cache.lounge.rocks/nix-cache" ];
      trusted-public-keys = [ "nix-cache:4FILs79Adxn/798F8qk2PC1U8HaTlaPqptwNJrXNA1g=" ];
    };

    # Enable nix command and flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
