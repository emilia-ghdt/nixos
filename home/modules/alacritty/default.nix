{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.alacritty;
in
{
  options.siren.programs.alacritty.enable = mkEnableOption "enable alacritty";

  config = mkIf cfg.enable {
    siren.fonts.enable = mkDefault true;

    programs.alacritty = {
      enable = true;

      # TODO: interpolate with color theme
      settings = import ./settings.nix;
    };
  };
}
