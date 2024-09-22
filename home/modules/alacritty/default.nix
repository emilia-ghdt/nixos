{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.alacritty;
in
{
  options.siren.programs.alacritty.enable = mkEnableOption "alacritty";

  config = mkIf cfg.enable {
    home.sessionVariables = {
      TERMINAL = "alacritty";
    };
    wayland.windowManager.sway.config.terminal = "alacritty";
    siren.programs.hyprland.terminal = "${pkgs.alacritty}/bin/alacritty";
    
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          decorations = "None";
          padding.x = 3;
          padding.y = 3;
          opacity = 0.7;
          blur = true;
        };

        scrolling = {
          history = 100000;
        };

        font = {
          size = 18.0;
          builtin_box_drawing = true;
        };
      };
    };

  };
}
