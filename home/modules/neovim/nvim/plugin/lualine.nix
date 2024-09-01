{ lib, config, ... }:
let cfg = config.siren.programs.neovim;
in
{
  config = lib.mkIf cfg.enable {
    programs.nixvim.plugins.lualine = {
      enable = true;
    #   iconsEnabled = true;
    #   theme = null;
    #   componentSeparators = { left = "|"; right = "|"; };
    #   sectionSeparators = { left = ""; right = ""; };
    #   disabledFiletypes.statusline = [ "NvimTree" "alpha" ];
    #   disabledFiletypes.winbar = [ "NvimTree" "alpha" ];
    };
  };
}
