{ lib, pkgs, flake-self, config, home, ... }:
with lib;
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # TODO shell
  home.packages = with pkgs; [
    # Passwords
    rbw # bitwarden cli
    xkcdpass # TODO: rewrite in Rust
    apg # generate passwords

    # Network
    wireguard-tools
    mozwire
    netbird
  ];

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
        # access overlay by using pkgs.stable.<package>
        stable = import flake-self.inputs.nixpkgs-stable {
          system = "${pkgs.system}";
          config = { allowUnfree = true; };
        };
      })
    ];
  };
}
