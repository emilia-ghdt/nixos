{ config, flake-self, pkgs, lib, ... }@inputs:
with lib;
let 
  cfg = config.siren.fonts;
in
{
  options.siren.fonts = {
    enable = mkEnableOption "fonts";
  };

  config = mkIf cfg.enable {
    programs.alacritty.settings.font.normal = {
      family = "FiraCode Nerd Font Mono";
      style = "Regular";
    };

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
