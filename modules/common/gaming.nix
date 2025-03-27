{ lib, pkgs, config, ... }:
let cfg = config.siren.gaming;
in
{
  options.siren.gaming.enable = lib.mkEnableOption "gaming config";

  config = lib.mkIf cfg.enable {
    programs = {
      steam.enable = true;
      steam.gamescopeSession.enable = true;
    };

    environment.systemPackages = with pkgs; [
      lutris
    ];
  };
}
