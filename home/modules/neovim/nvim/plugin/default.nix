{ lib, config, ... }:
let cfg = config.siren.programs.neovim;
in
{
  imports = [
    ./telescope.nix
    ./lualine.nix
    ./treesitter.nix
    ./gitsigns.nix
    ./nvimtree.nix
    ./lsp
    ./dap.nix
  ];

  config = lib.mkIf cfg.enable {
    programs.nixvim.plugins = {
    #   sleuth.enable = true;
      comment.enable = true;
    #   indent-blankline.enable = true;

      git-worktree = {
        enable = true;
        enableTelescope = true;
      };
    };
  };
}
