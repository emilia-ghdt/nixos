{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.kitty;
in
{
  options.siren.programs.kitty = {
    enable = mkEnableOption "kitty";
    setDefault = mkOption {
      type = types.bool;
      description = "Set kitty as default terminal";
      default = false;
    };
    fontSize = mkOption {
      type = types.int;
      description = "Font Size in terminal";
      default = 16;
    };
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font = {
        size = cfg.fontSize;
      };
      settings = {
        background_opacity = 0.8;
        scrollback_lines = 3000;
      };
    };
  } //
    mkIf cfg.setDefault {
      home.sessionVariables = {
        TERMINAL = "kitty";
      };
    };
}
