{ lib, pkgs, flake-self, config, home, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  siren = {
    aliases.enable = true;
  };
  siren.programs = {
    shell.enable = true;
    direnv.enable = true;
    neovim.enable = true;
    # rust.enable = true;
    ssh.enable = true;
    git.enable = true;
  };

  # TODO shell
  home.packages = with pkgs; [
    sops

    # Passwords
    rbw # bitwarden cli
    xkcdpass # TODO: rewrite in Rust
    apg # generate passwords

    # Network
    wireguard-tools
    mozwire

    # Files
    unzip
    zip
  ];

  programs.nix-index = {
    enable = true;
    # package = pkgs.nix-index-with-db;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  nixpkgs = {
    # Allow "unfree" licenced packages
    config = {
      allowUnfree = true;
    };
    overlays = [
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
          config = {
            allowUnfree = true; 
          };
        };
      })
    ];
  };
}
