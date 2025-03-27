{ lib, pkgs, config, system-config, ... }:
with lib;
let cfg = config.siren.programs.shell;
in
{
  options.siren.programs.shell = {
    enable = mkEnableOption "shell config";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      "PAGER" = "${pkgs.bat}/bin/bat";
    };
    programs.fish.enable = true;
    programs.starship = {
      enable = true;
      settings = {};
    };

    home.packages = with pkgs.fishPlugins; [

    ];
  };
}
