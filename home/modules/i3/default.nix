{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.i3;
in
{
  options.siren.programs.i3.enable = mkEnableOption "enable i3 config";

  config = mkIf cfg.enable {
    # TODO
  };
}
