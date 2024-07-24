{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.sway;
in
{
  options.siren.programs.sway.enable = mkEnableOption "enable sway config";

  config = mkIf cfg.enable {
    # TODO
  };
}
