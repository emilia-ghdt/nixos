{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.fonts;
in
{
  options.siren.fonts.enable = mkEnableOption "fonts";

  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "BitstreamVeraSansMono" "FiraCode" "FiraMono" "RobotoMono" "Hack" ]; })
    ];
  };
}
