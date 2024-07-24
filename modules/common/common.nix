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

    nixpkgs.overlays = [ flake-self.overlays.default ];

    nix = {
      settings = {
        # Enable nix command and flakes
        experimental-features = [ "nix-command" "flakes" ];

        # Use binary cache
        substituters = [ "https://cache.lounge.rocks/nix-cache" ];
        trusted-public-keys = [ "nix-cache:4FILs79Adxn/798F8qk2PC1U8HaTlaPqptwNJrXNA1g=" ];
      };
      # Set the $NIX_PATH entry for nixpkgs. This is necessary in
      # this setup with flakes, otherwise commands like `nix-shell
      # -p pkgs.htop` will keep using an old version of nixpkgs.
      # With this entry in $NIX_PATH it is possible (and
      # recommended) to remove the `nixos` channel for both users
      # and root e.g. `nix-channel --remove nixos`. `nix-channel
      # --list` should be empty for all users afterwards
      nixPath = [ "nixpkgs=${flake-self.inputs.nixpkgs}" ];
    };
  };
}
