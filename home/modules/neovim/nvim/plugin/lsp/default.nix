{ lib, config, ... }:
let cfg = config.siren.programs.neovim;
in
{
  imports = [
    ./cmp.nix
  ];

  config = lib.mkIf cfg.enable {
  # programs.nixvim.plugins = {
  #   crates-nvim.enable = true ; # Does not work
  # };

    programs.nixvim.plugins.lsp = {
      enable = true;
      servers = {
        clangd = {
          enable = true;
    #       settings.arguments = [
    #         "--clang-tidy"
    #         "--background-index"
    #         "--completion-style=detailed"
    #         "--cross-file-rename"
    #         "--header-insertion=iwyu"
    #         "--all-scopes-completion"
    #         "--fallback-style=file:${config.home.homeDirectory}/.clang-format"
    #       ];
        };
        java_language_server = {
          enable = true;
          filetypes = ["java"];
        };
        pyright.enable = true;
    #     emmet-ls.enable = true;
    #     tsserver.enable = true;
    #     cssls.enable = true;
    #     pyright.enable = true;
        nixd.enable = true;
        lua_ls = {
          enable = true;
          settings = {
    #         telemetry.enable = false;
            workspace.checkThirdParty = true;
          };
        };
    #     svelte = {
    #       enable = true;
    #       settings.enable_ts_plugin = true;
    #     };
    #     slint-lsp.enable = true;
    #     zls.enable = true;
        rust_analyzer = {
          enable = true;
          installRustc = false;
          installCargo = false;
          cmd = [ "rust-analyzer" ];
          settings = {
    #         imports = {
    #           granularity.group = "crate";
    #           prefix = "self";
    #           preferNoStd = true;
    #         };
            check = {
              command = "clippy";
              allTargets = true;
            };
    #         completion.fullFunctionSignatures.enable = false;
            cargo = {
    #           buildScripts.enable = false;
              allTargets = true;
              features = "all";
            };
            procMacro.enable = true;
          };
        };
      };

    #   # inlayHints = true;
    #   capabilities = "capabilities.textDocument.completion.completionItem.snippetSupport = true";
    #   preConfig = ''
    #           local border = {
    #             { "╭", "FloatBorder" },
    #             { "─", "FloatBorder" },
    #             { "╮", "FloatBorder" },
    #             { "│", "FloatBorder" },
    #             { "╯", "FloatBorder" },
    #             { "─", "FloatBorder" },
    #             { "╰", "FloatBorder" },
    #             { "│", "FloatBorder" }
    #           }
    #           vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
    #           vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
    #           '';
      keymaps = {
    #     silent = true;
        extra = [
          { mode = "n"; key = "<leader>r"; action.__raw = "vim.lsp.buf.rename"; }
          { mode = "n"; key = "<leader>a"; action.__raw = "vim.lsp.buf.code_action"; }
          { mode = "n"; key = "<leader>di"; action.__raw = "vim.diagnostic.open_float"; }
    #       { mode = "n"; key = "<leader>dv"; action.__raw = "require('telescope.builtin').diagnostics"; }

          { mode = "n"; key = "gd"; action.__raw = "vim.lsp.buf.definition"; }
          { mode = "n"; key = "gr"; action.__raw = "require('telescope.builtin').lsp_references"; }
          { mode = "n"; key = "gI"; action.__raw = "vim.lsp.buf.implementation"; }
          { mode = "n"; key = "<leader>D"; action.__raw = "vim.lsp.buf.type_definition"; }
    #       { mode = "n"; key = "<leader>ds"; action.__raw = "require('telescope.builtin').lsp_document_symbols"; }
    #       { mode = "n"; key = "<leader>ws"; action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols"; }
          { mode = "n"; key = "<leader>K"; action.__raw = "vim.lsp.buf.hover"; }
    #       { mode = "n"; key = "<leader>k"; action.__raw = "vim.lsp.buf.signature_help"; }

    #       { mode = "n"; key = "<leader>gD"; action.__raw = "vim.lsp.buf.declaration"; }
    #       { mode = "n"; key = "<leader>wa"; action.__raw = "vim.lsp.buf.add_workspace_folder"; }
    #       { mode = "n"; key = "<leader>wr"; action.__raw = "vim.lsp.buf.remove_workspace_folder"; }
    #       { mode = "n"; key = "<leader>wl"; action.__raw = "function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end"; }
        ];
      };
    #   onAttach = ''
    #           if client.server_capabilities.documentSymbolProvider then
    #             require('nvim-navic').attach(client, bufnr)
    #           end
    #         '';
    };

    # programs.nixvim.plugins.navic = {
    #   icons = {
    #     File = "󰈙 ";
    #     Module = " ";
    #     Namespace = " ";
    #     Package = " ";
    #     Class = "󰠱 ";
    #     Method = "󰆧 ";
    #     Property = "󰜢 ";
    #     Field = " ";
    #     Constructor = " ";
    #     Enum = " ";
    #     Interface = " ";
    #     Function = "󰊕 ";
    #     Variable = "󰀫 ";
    #     Constant = "󰏿 ";
    #     String = " ";
    #     Number = "󰉻 ";
    #     Boolean = "◩ ";
    #     Array = " ";
    #     Object = "󰅩 ";
    #     Key = "󰌋 ";
    #     Null = "󰟢 ";
    #     EnumMember = " ";
    #     Struct = " ";
    #     Event = " ";
    #     Operator = "󰆕 ";
    #     TypeParameter = " ";
    #   };
    #   highlight = true;
    #   separator = "  ";
    #   depthLimit = 0;
    #   depthLimitIndicator = "…";
    #   safeOutput = true;
    # };
    # programs.nixvim.opts.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}";
  };
}
