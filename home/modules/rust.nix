{ config, flake-self, pkgs, lib, ... }@inputs:
with lib;
let 
  cfg = config.siren.programs.rust;
in
{
  options.siren.programs.rust = {
    enable = mkEnableOption "rust overlay";
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [ flake-self.inputs.rust-overlay.overlays.default ];

    home.packages = with pkgs; [
      (rust-bin.stable.latest.default.override {
        extensions = [ "rust-src" ];
      })
    ];
  };
}
