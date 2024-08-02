{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.desktop;
in
{
  options.siren.desktop.enable = mkEnableOption "desktop config";

  config = mkIf cfg.enable {
    siren = {
      common.enable = true;
      wayland.enable = true;
      fonts.enable = true;
    };
    
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
