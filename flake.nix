{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    stable.url = "github:NixOS/nixpkgs/nixos";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {    
      nixosConfigurations.cassiopeia = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; inherit stable; };
        modules = [ 
          ./hosts/cassiopeia/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };

      nixosConfiguration.orion = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; inherit stable; };
        modules = [
          ./hosts/orion/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      
formatter = system: nixpkgs.${system}.nixpkgs-fmt;
  
    };
}
