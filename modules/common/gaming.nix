{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.gaming;
in
{
  options.siren.gaming.enable = mkEnableOption "gaming config";

  config = mkIf cfg.enable {
    programs = {
      steam.enable = true;
      steam.gamescopeSession.enable = true;
    };
  };
}
