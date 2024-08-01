{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.firefox;
in
{
  options.siren.programs.firefox.enable = mkEnableOption "enable firefox config";

  config = mkIf cfg.enable {
    home.sessionVariables = {
      BROWSER = "firefox";
    };
    # TODO
  };
}
