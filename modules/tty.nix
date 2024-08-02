{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.tty;
in
{
  options.siren.tty.enable = mkEnableOption "tty config";

  config = mkIf cfg.enable {
    console = {
      font = "RobotoMono Nerd Font";
      useXkbConfig = true;
    };
  };
}
