{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.fonts;
in
{
  options.siren.fonts.enable = mkEnableOption "enable fonts";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "RobotoMono" ]; })
    ];
  };
}
