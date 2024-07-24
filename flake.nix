{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      stable = import nixpkgs-stable { inherit system; };
    in
    {
      # Output all modules in ./modules to flake. Modules should be in
      # individual subdirectories and contain a default.nix file
      nixosModules = builtins.listToAttrs (map
        (x: {
          name = x;
          #specialArgs = { flake-self = self; } // inputs;
          value = import (./modules + "/${x}");
        })
        (builtins.attrNames (builtins.readDir ./modules)));
      nixosConfigurations.cassiopeia = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; inherit stable; };
        modules = builtins.attrValues self.nixosModules ++ [ 
          ./hosts/cassiopeia/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };

      nixosConfigurations.orion = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; inherit stable; };
        modules = builtins.attrValues self.nixosModules ++ [
          ./hosts/orion/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      
      formatter = { ${system} = nixpkgs.${system}.nixpkgs-fmt;};
  
    };
}
