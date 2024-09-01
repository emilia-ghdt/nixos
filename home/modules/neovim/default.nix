{ lib, pkgs, config, flake-self, ... }:
let cfg = config.siren.programs.neovim;
in
{
  imports = [
    ./nvim
  ];
  
  options.siren.programs.neovim.enable = lib.mkEnableOption "neovim config";

  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      EDITOR = "nvim";
    };

    # TODO move to lsp config
    home.file.".LLS-3rd-Party-Addons/cc-tweaked".source = flake-self.inputs.lua-ls-cc-tweaked;

    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      # performance = {
      #   byteCompileLua.enable = true;
      #   combinePlugins = {};
      # };
    };
  };
}
