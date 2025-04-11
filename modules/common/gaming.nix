{ lib, pkgs, config, ... }:
let cfg = config.siren.gaming;
in
{
  options.siren.gaming.enable = lib.mkEnableOption "gaming config";

  config = lib.mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
        extraPackages = with pkgs; [
          gamescope-wsi
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      lutris
    ];
  };
}
