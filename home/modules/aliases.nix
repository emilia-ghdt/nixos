{ config, flake-self, pkgs, lib, ... }@inputs:
with lib;
let 
  cfg = config.siren.aliases;
in
{
  options.siren.aliases = {
    enable = mkEnableOption "aliases";
  };

  config = mkIf cfg.enable {
    home.shellAliases = {
      ns = "nix-shell --run fish -p";
      ls = "${pkgs.eza}/bin/eza";
      ll = "${pkgs.eza}/bin/eza -la";
      la = "${pkgs.eza}/bin/eza -a";
    };
  };
}
