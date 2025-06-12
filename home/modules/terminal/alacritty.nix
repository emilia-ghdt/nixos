{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.alacritty;
in
{
  options.siren.programs.alacritty = {
    enable = mkEnableOption "alacritty";
    setDefault = mkOption {
      type = types.bool;
      description = "Set alacritty as default terminal";
      default = false;
    };
    fontSize = mkOption {
      type = types.int;
      description = "Font Size in terminal";
      default = 16;
    };
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          decorations = "None";
          padding.x = 3;
          padding.y = 3;
          opacity = 0.8;
          # blur = true;
        };

        scrolling = {
          history = 1000;
        };

        font = {
          size = cfg.fontSize;
          builtin_box_drawing = true;
        };
      };
    };
  } //
    mkIf cfg.setDefault {
      home.sessionVariables = {
        TERMINAL = "alacritty";
      };
    };
}
