{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Pure Nix flake utility functions
    # https://github.com/numtide/flake-utils
    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-3.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-autobahn = {
      url = "github:Lassulus/nix-autobahn";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-24.05";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    lua-ls-cc-tweaked = {
      url = "github:nvim-computercraft/lua-ls-cc-tweaked";
      flake = false;
    };

    plugin-lazydev-nvim.url = "github:folke/lazydev.nvim";
    plugin-lazydev-nvim.flake = false;
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
    # Helper function to get regular files in a directory
      filesIn = dirPath: 
        let
          dirContents = builtins.readDir dirPath;
        in 
          (builtins.filter (name: dirContents.${name} == "regular") (builtins.attrNames dirContents));
          
      # provide a nixpkgs for a specific architecture
      supportedSystems = [ "aarch64-linux" "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; overlays = [ self.overlays.default ]; });
    in
    {
      formatter = forAllSystems
        (system: nixpkgsFor.${system}.nixpkgs-fmt);

      overlays.default = final: prev:
        (import ./pkgs inputs) final prev;

      # Output all modules in ./modules to flake. Modules should be in
      # individual subdirectories and contain a default.nix file
      nixosModules = builtins.listToAttrs
        (map
          (x: {
            name = x;
            value = import (./modules + "/${x}");
          })
          (builtins.attrNames (builtins.readDir ./modules))) // {
        home-manager = { config, pkgs, lib, ... }: {
          imports = [ ./home ];
        };
      };

      # Each subdirectory in ./hosts is a host. Add them all to
      # nixosConfiguratons. Host configurations need a file called
      # configuration.nix that will be read first
      nixosConfigurations = builtins.listToAttrs (map
        (name: {
          inherit name;
          value = nixpkgs.lib.nixosSystem {
            # Make inputs and the flake itself accessible as module parameters.
            # Technically, adding the inputs is redundant as they can be also
            # accessed with flake-self.inputs.X, but adding them individually
            # allows to only pass what is needed to each module.
            specialArgs = { flake-self = self; } // inputs;
            modules = builtins.attrValues self.nixosModules ++ [
              (./hosts + "/${name}/configuration.nix")
              inputs.sops-nix.nixosModules.sops
              inputs.disko.nixosModules.default
              inputs.impermanence.nixosModules.impermanence
              inputs.lix-module.nixosModules.default
            ];
          };
        })
        (builtins.attrNames (builtins.readDir ./hosts))
      );

      homeConfigurations = builtins.listToAttrs (map
        (name: {
          inherit name;
          value = { pkgs, lib, ... }: {
          imports = [
            (./home/profiles + "/${name}")
          ] ++ (builtins.attrValues self.homeManagerModules);
        };
        })
        (filesIn ./home/profiles)
      );

      # by using forAllSystems, we generate a package for each supported system
      packages = forAllSystems (system: {
        woodpecker-pipeline = nixpkgsFor.${system}.callPackage ./pkgs/woodpecker-pipeline {
          inputs = inputs;
          flake-self = self;
        };
      });

    };
}
