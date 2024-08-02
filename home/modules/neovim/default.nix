{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.neovim;
in
{
  options.siren.programs.neovim.enable = mkEnableOption "neovim config";

  config = mkIf cfg.enable {
    home.sessionVariables = {
      EDITOR = "nvim";
    };
    
    programs.neovim.enable = true;
    # TODO
  };
}
