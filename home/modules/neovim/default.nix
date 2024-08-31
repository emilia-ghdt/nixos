{ lib, pkgs, config, flake-self, ... }:
with lib;
let cfg = config.siren.programs.neovim;
in
{
  options.siren.programs.neovim.enable = mkEnableOption "neovim config";

  config = mkIf cfg.enable {
    home.sessionVariables = {
      EDITOR = "nvim";
    };

    home.file.".LLS-3rd-Party-Addons/cc-tweaked".source = flake-self.inputs.lua-ls-cc-tweaked;
    
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      extraLuaConfig = ''
        print("Test")
        vim.o.clipboard = 'unnamedplus'
      '';

      plugins = [
        {
          plugin = pkgs.vimPlugins.lualine-nvim;
          config = ''
            require("lualine").setup()
          '';
        }
      ];
    };
  };
}
