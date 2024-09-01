{ lib, config, ... }:
let cfg = config.siren.programs.neovim;
in
{
  config = lib.mkIf cfg.enable {
    programs.nixvim.plugins.treesitter = {
      enable = true;
    #   nixGrammars = false;
    #   nixvimInjections = true;
    #   parserInstallDir = "${config.home.homeDirectory}/.vim/treesitter";
    #   indent = true;
    #   incrementalSelection = {
    #     enable = true;
    #     keymaps = {
    #       initSelection = "<c-space>";
    #       nodeIncremental = "<c-space>";
    #       scopeIncremental = "<c-s";
    #       nodeDecremental = "<c-backspace>";
    #     };
    #   };
    #   disabledLanguages = [
    #     "vimdoc"
    #   ];
    };
  };
}
