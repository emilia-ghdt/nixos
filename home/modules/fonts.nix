{ config, flake-self, pkgs, lib, ... }@inputs:
with lib;
let 
  cfg = config.siren.fonts;
in
{
  options.siren.fonts = {
    enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {
    fonts.fontconfig.defaultFonts = {
      emoji = [

      ];
      serif = [];
      sansSerif = [];
      monospace = [
        "Monocraft Nerd Font"
      ];
    };
  };
}
