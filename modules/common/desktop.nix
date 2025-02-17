{ lib, pkgs, config, ... }:
let cfg = config.siren.desktop;
in
{
  options.siren.desktop.enable = lib.mkEnableOption "desktop config";

  config = lib.mkIf cfg.enable {
    siren = {
      common.enable = true;
      wayland.enable = true;
      hyprland.enable = true;
      fonts.enable = true;
    };
    
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    programs = {
      localsend = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
