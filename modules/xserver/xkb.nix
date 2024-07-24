{ config, flake-self, system-config, pkgs, lib, ... }:
with lib;
let cfg = config.siren.xserver.xkb;
in
{
  options.siren.xserver.xkb = {
    enable = mkEnableOption "xkb config";
  };
  
  config = mkIf cfg.enable {
    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "de";
      variant = "";
    };
  };
}
