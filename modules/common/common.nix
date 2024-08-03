{ lib, pkgs, flake-self, config, ... }:
with lib;
let cfg = config.siren.common;
in
{
  options.siren.common.enable = mkEnableOption "common config";

  config = mkIf cfg.enable {
    siren = {
      locale.enable = true;
    };

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
      pciutils
      calc
      fzf
      zoxide
    ] ++ [ flake-self.inputs.nix-autobahn ];

    # Shells
    programs = {
      zsh.enable = true;
      fish.enable = true;
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    nixpkgs.overlays = [
      flake-self.overlays.default
      (self: super: {
        # access overlay by using pkgs.withCUDA.<package>
        withCUDA = import flake-self.inputs.nixpkgs {
          system = "${pkgs.system}";
          config = { allowUnfree = true; cudaSupport = true; };
        };
        # access overlay by using pkgs.stableRelease.<package>
        stableRelease = import flake-self.inputs.nixpkgs-stable {
          system = "${pkgs.system}";
          config = { allowUnfree = true; };
        };
      })
    ];

    nix = {
      settings = {
        # Enable nix command and flakes
        experimental-features = [ "nix-command" "flakes" ];

        # Use binary cache
        substituters = [ "https://hyprland.cachix.org" "https://cache.lounge.rocks/nix-cache" ];
        trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" "nix-cache:4FILs79Adxn/798F8qk2PC1U8HaTlaPqptwNJrXNA1g=" ];
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
