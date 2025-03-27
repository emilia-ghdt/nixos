{ lib, config, ... }:
let cfg = config.siren.programs.neovim;
in
{

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      keymaps = [
        # { mode = [ "n" "v" ]; key = "<SPACE>"; action = "<NOP>"; options.silent = true; }
        # { mode = "n"; key = "<LEADER>;"; action = "A;<ESC>"; options.silent = true; }
        # { mode = "n"; key = "<LEADER>,"; action = "A,<ESC>"; options.silent = true; }

        # # Remainign cursor
        # { mode = "n"; key = "J"; action = "mzJ`z"; options.silent = true; }
        # { mode = "n"; key = "<C-d>"; action = "<C-d>zz"; options.silent = true; }
        # { mode = "n"; key = "<C-u>"; action = "<C-u>zz"; options.silent = true; }
        # { mode = "n"; key = "n"; action = "nzzzv"; options.silent = true; }
        # { mode = "n"; key = "N"; action = "Nzzzv"; options.silent = true; }

        # # COPY PASTE
        # { mode = "v"; key = "J"; action = ":m '>+1<CR>gv=gv"; options.silent = true; }
        # { mode = "v"; key = "K"; action = ":m '<-2<CR>gv=gv"; options.silent = true; }

        # # Paste and delete to void
        # { mode = "x"; key = "<LEADER>p"; action = "\"_dP"; options.silent = true; }
        # # Copy to system
        # { mode = [ "n" "v" ]; key = "<LEADER>y"; action = "\"+y"; options.silent = true; }
        # # Delete to void
        # { mode = [ "n" "v" ]; key = "<LEADER>d"; action = "\"_d"; options.silent = true; }

        # # UTIL
        # # replace current word
        # { mode = "n"; key = "<LEADER>s"; action = "[[:%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<LEFT><LEFT><LEFT]]"; options.silent = true; }
        # # make executable
        # { mode = "n"; key = "<LEADER>x"; action = "<CMD>!chmod +x %<CR>"; options.silent = true; }
        # { mode = "i"; key = "<C-c>"; action = "<ESC>"; options.silent = true; }
        # # Exit terminal mode
        # { mode = "t"; key = "<ESC>"; action = "<C-\\><C-n"; options.silent = true; }

        # # PLANES
        # { mode = "n"; key = "<C-h>"; action = "<C-w>h"; options.silent = true; }
        # { mode = "n"; key = "<C-j>"; action = "<C-w>j"; options.silent = true; }
        # { mode = "n"; key = "<C-k>"; action = "<C-w>k"; options.silent = true; }
        # { mode = "n"; key = "<C-l>"; action = "<C-w>l"; options.silent = true; }


        # # DIAGNOSTICS
        # # { mode = "n"; key = "[d"; action = { __raw = "vim.diagnostics.goto_prev"; }; options.silent = true; }
        # # { mode = "n"; key = "]d"; action = { __raw = "vim.diagnostics.goto_next"; }; options.silent = true; }
        # # { mode = "n"; key = "<LEADER>e"; action = { __raw = "vim.diagnostics.open_float"; }; options.silent = true; }

        # # NVIM TREE
        { mode = "n"; key = "<C-t>"; action = "<CMD>NvimTreeToggle<CR>"; options.silent = true; }
        # { mode = "n"; key = "<C-t>"; action = "<CMD>NvimTreeOpen<CR>"; options.silent = true; }

        # # DAP
        # { mode = "n"; key = "<F5>"; action = { __raw = "require\"dap\".continue"; }; options.silent = true; }
        # { mode = "n"; key = "<F10>"; action = { __raw = "require\"dap\".step_over"; }; options.silent = true; }
        # { mode = "n"; key = "<F11>"; action = { __raw = "require\"dap\".step_into"; }; options.silent = true; }
        # { mode = "n"; key = "<F12>"; action = { __raw = "require\"dap\".step_out"; }; options.silent = true; }
        # { mode = "n"; key = "<LEADER>b"; action = { __raw = "require\"dap\".toggle_breakpoint"; }; options.silent = true; }
        # { mode = "n"; key = "<LEADER>B"; action = { __raw = "function() require\"dap\".set_breakpoint(vim.fn.input(\"Breakpoint condition: \")) end"; }; options.silent = true; }
        # { mode = "n"; key = "<LEADER>lp"; action = { __raw = "function() require\"dap\".set_breakpoint(nil, nil, vim.fn.input(\"Log point message: \")) end"; }; options.silent = true; }
        # { mode = "n"; key = "<LEADER>dr"; action = { __raw = "require\"dap\".repl.open"; }; options.silent = true; }

        # # DAPUI
        # { mode = "n"; key = "<F6>"; action = { __raw = "require\"dapui\".close"; }; options.silent = true; }
        # { mode = "n"; key = "<F7>"; action = { __raw = "require\"dapui\".toggle"; }; options.silent = true; }
        # { mode = "n"; key = "<F8>"; action = "<CMD>lua require\"dapui\".float_element(<element ID>, <optional settings>)<CR>"; options.silent = true; }
        # { mode = [ "n" "v" ]; key = "<F9>"; action = "<CMD>lua require\"dapui\".eval(<expression>)<CR>"; options.silent = true; }

        # # TELESCOPE
        # { mode = "n"; key = "<LEADER>?"; action = { __raw = "require\"telescope.builtin\".oldfiles"; }; options = { silent = true; desc = "[?] Find recently opened files"; }; }
        # { mode = "n"; key = "<LEADER><SPACE>"; action = { __raw = "require\"telescope.builtin\".buffers"; }; options = { silent = true; desc = "[ ] Find existing buffers"; }; }
        # {
        #   mode = "n";
        #   key = "<LEADER>/";
        #   action.__raw = ''
        #     				function() 
        #     					require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        #     						winblend = 0;
        #     						previewer = false;
        #     					})
        #     				end'';
        #   options = { silent = true; desc = "[/] Fuzzily search in current buffer"; };
        # }
        { mode = "n"; key = "<LEADER>ff"; action.__raw = "require('telescope.builtin').find_files"; options = { silent = true; desc = "[F]ind [F]iles"; }; }
        { mode = "n"; key = "<LEADER>sh"; action.__raw = "require('telescope.builtin').help_tags"; options = { silent = true; desc = "[S]earch [H]elp"; }; }
        # { mode = "n"; key = "<LEADER>sw"; action.__raw = "require('telescope.builtin').grep_string"; options = { silent = true; desc = "[S]earch current [W]ord"; }; }
        { mode = "n"; key = "<LEADER>sg"; action.__raw = "require('telescope.builtin').live_grep"; options = { silent = true; desc = "[S]earch by [G]rep"; }; }
        # { mode = "n"; key = "<LEADER>sd"; action.__raw = "require('telescope.builtin').diagnostics"; options = { silent = true; desc = "[S]earch [D]iagnostics"; }; }
        # { mode = "n"; key = "<LEADER>sf"; action.__raw = "require('telescope.builtin').git_files"; options = { silent = true; desc = "[S]earch [F]iles tracked by git"; }; }

        # { mode = "n"; key = "<LEADER>gw"; action.__raw = "function() require('telescope').extensions.git_worktree.git_worktrees() end"; options = { silent = true; desc = "[G]it [W]orktrees"; }; }
        # { mode = "n"; key = "<LEADER>gc"; action.__raw = "function() require('telescope').extensions.git_worktree.create_git_worktree() end"; options = { silent = true; desc = "[G]it [create] worktree"; }; }

        # # UNDOTREE
        # { mode = "n"; key = "<LEADER>F5"; action.__raw = "vim.cmd.UndotreeToggle"; options.silent = true; }

        # # GIT
        # { mode = "n"; key = "<LEADER>igb"; action = "<CMD>Gitsigns toggle_current_line_blame<CR>"; options = { desc = "[I]nline [G]it [B]lame"; silent = true; }; }
        # { mode = "n"; key = "<LEADER>gb"; action = "<CMD>Gitsigns blame_line <CR>"; options = { desc = "[G]it [B]lame"; silent = true; }; }
        # { mode = "n"; key = "<C-y>"; action.__raw = "function() vim.lsp.buf.format({async = true}) end"; options.silent = true; }
      ];
    };
  };
}
