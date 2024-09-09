{ lib, config, ... }:
let cfg = config.siren.programs.neovim;
in
{

  config = lib.mkIf cfg.enable {

    programs.nixvim = {
      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };
      opts = {
      #   colorcolumn = "79";
      #   hlsearch = false;
        number = true;
        relativenumber = true;

      #   scrolloff = 25;

        tabstop = 2;
        shiftwidth = 2;
      #   autoindent = true;
        expandtab = true;

        ignorecase = true;
        smartcase = true;
        incsearch = true;

        termguicolors = true;
      #   background = "dark";
      #   mouse = "a";

      #   breakindent = true;
        undofile = true;
        undodir = "${config.home.homeDirectory}/.vim/undodir";

      #   updatetime = 250;
      #   signcolumn = "yes";
      #   completeopt = "menuone,noselect";
      };

      # autoGroups.YankHighlight.clear = true;
      # autoCmd = [
      #   {
      #     event = "TextYankPost";
      #     callback = { __raw = "function() vim.highlight.on_yank() end"; };
      #     group = "YankHighlight";
      #     pattern = "*";
      #   }
      #   {
      #     event = [ "BufRead" "BufNewFile" ];
      #     pattern = "*";
      #     command = "set tabstop=4";
      #   }
      # ];
    };
  };
}
