{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.direnv;
in
{
  options.siren.programs.direnv.enable = mkEnableOption "direnv";

  config = mkIf cfg.enable {
    programs = {
      direnv = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
      git = { ignores = [ ".direnv/" ]; };
      vscode.profiles.default = {
        extensions = with pkgs.vscode-extensions; [ mkhl.direnv ];
      };
    };
  };
}
