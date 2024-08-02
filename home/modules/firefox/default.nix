{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.firefox;
in
{
  options.siren.programs.firefox.enable = mkEnableOption "firefox config";

  config = mkIf cfg.enable {
    home.sessionVariables = {
      BROWSER = "firefox";
    };
    # TODO
  };
}
