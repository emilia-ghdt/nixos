{ lib, config, ... }:
let cfg = config.siren.programs.neovim;
in
{
  config = lib.mkIf cfg.enable {
    # programs.nixvim.plugins.dap = {
    #   enable = true;
    #   signs = {
    #     dapBreakpoint = {
    #       text = "";
    #       texthl = "DiagnosticSignWarn";
    #       linehl = "Visual";
    #       numhl = "DiagnosticSignWarn";
    #     };
    #     dapBreakpointRejected = {
    #       text = "";
    #       texthl = "DiagnosticSignError";
    #       linehl = "";
    #       numhl = "";
    #     };
    #     dapStopped = {
    #       text = "";
    #       texthl = "DiagnosticSignWarn";
    #       linehl = "Visual";
    #       numhl = "DiagnosticSignWarn";
    #     };
    #   };

    #   extensions = {
    #     dap-virtual-text = {
    #       enable = true;
    #       enabledCommands = true;
    #       highlightNewAsChanged = false;
    #       showStopReason = true;
    #       commented = false;
    #       onlyFirstDefinition = true;
    #       allReferences = false;
    #       virtTextPos = "eol";
    #       allFrames = false;
    #       virtLines = false;
    #       virtTextWinCol = null;
    #     };
    #     dap-ui = {
    #       enable = true;
    #       controls = {
    #         element = "repl";
    #         icons = {
    #           disconnect = "";
    #           pause = "";
    #           play = "";
    #           run_last = "";
    #           step_back = "";
    #           step_into = "";
    #           step_out = "";
    #           step_over = "";
    #           terminate = "";
    #         };
    #       };

    #       elementMappings = { };
    #       expandLines = true;
    #       floating = {
    #         border = "single";
    #         mappings = {
    #           close = [ "q" "<ESC>" ];
    #         };
    #       };

    #       forceBuffers = true;
    #       icons = {
    #         collapsed = "";
    #         current_frame = "";
    #         expanded = "";
    #       };

    #       render = {
    #         indent = 1;
    #         maxValueLines = 100;
    #       };

    #       layouts = [
    #         {
    #           position = "left";
    #           size = 10;
    #           elements = [
    #             {
    #               id = "scopes";
    #               size = 0.25;
    #             }
    #             {
    #               id = "breakpoints";
    #               size = 0.25;
    #             }
    #             {
    #               id = "stacks";
    #               size = 0.25;
    #             }
    #             {
    #               id = "watches";
    #               size = 0.25;
    #             }
    #           ];
    #         }
    #       ];
    #     };
    #   };
    # };
  };
}
