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
      
    };
  };
}
