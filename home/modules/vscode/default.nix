{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.vscode;
in
{
  options.siren.programs.vscode.enable = mkEnableOption "vscode";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nil
      nixpkgs-fmt
    ];

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium.fhs;
      # package = pkgs.vscode.fhsWithPackages (ps: with ps; [ rustup zlib openssl.dev pkg-config ]);
     
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      # https://rycee.gitlab.io/home-manager/options.html#opt-programs.vscode.keybindings
      keybindings = [ ];
      
      userSettings = {
        # privacy
        "telemetry.telemetryLevel" = "off";
        "redhat.telemetry.enabled" = false;

        # editor
        "editor.unicodeHighlight.includeStrings" = false;
        "editor.wordWrap" = "on";
        "editor.wrappingIndent" = "none";
        "editor.unicodeHighlight.allowedCharacters" = {
            "🦈" = true;
        };
        "editor.unicodeHighlight.nonBasicASCII" = false;
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "files.autoSave" = "onFocusChange";

        # style
        "editor.fontFamily" = "RobotoMono Nerd Font Mono";
        "editor.fontSize" = 18;
        "terminal.integrated.fontFamily" = "RobotoMono Nerd Font Mono";
        "terminal.integrated.fontSize" = 18;
        "workbench.colorTheme" = "GitHub Dark Default";


        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
        };
        "nix" = {
          "enableLanguageServer" = true;
          # "serverPath" = "${pkgs.nil}/bin/nil";
          "serverPath" = "${pkgs.nixd}/bin/nixd";
          "serverSettings" = {
          # "nil" = {
          #   "formatting" = {
          #     "command" = [ "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt" ];
          #   };
          # };
            "nixd" = {
              # "eval" = { };
              "formatting" = {
                "command" = [ "${pkgs.nixfmt-rfc-style}/bin/nixfmt" ];
              };
              "options" = {
                "nixos" = {
                  "expr" = "(builtins.getFlake \"/home/emilia/nixos\").nixosConfigurations.cassiopeia.options";
                };
                "home-manager" = {
                  "expr" = "(builtins.getFlake \"/home/emilia/nixos\").homeConfigurations.cassiopeia.options";
                };
                # "target" = {
                #   "args" = [ ];
                #   "installable" = "(builtins.getFlake \"\${workspaceFolder}\")#nixosConfigurations.<name>.options";
                # };
              };
            };
          };
        };

        # latex workshop for fs protocols
        #latex-workshop.latex.external.build.args
        "latex-workshop" = {
          "latex.recipes" = [
            {
              "name" = "protokoll";
              "tools" = [
                "protokoll"
              ];
            }
          ];
          "latex.tools" = [
            {
              "name" = "protokoll";
              "command" = "pdflatex";
              "args" = [
                "-f"
                "-output-directory=%OUTDIR%"
                "%DOC%"
              ];
            }
          ];
          "latex.external.build.args" = [
            "-f"
          ];
          "synctex" = {
            "synctexjs.enabled" = true;
            "afterBuild.enabled" = true;
          };
          "view.pdf.viewer"= "tab";
        };

        # Markdown
        "[markdown]" = {
          "editor.defaultFormatter" = "DavidAnson.vscode-markdownlint";
        };
      };

      extensions = with pkgs.vscode-extensions; [
        davidanson.vscode-markdownlint
        github.copilot
        github.vscode-github-actions
        github.vscode-pull-request-github
        james-yu.latex-workshop
        jnoortheen.nix-ide
        ms-azuretools.vscode-docker
        ms-python.debugpy
        ms-python.python
        ms-vscode-remote.remote-ssh
        ms-vscode.cpptools
        redhat.vscode-xml
        redhat.vscode-yaml
        rust-lang.rust-analyzer
        yzhang.markdown-all-in-one
        valentjn.vscode-ltex
	ms-vscode.hexeditor
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-rhai";
          publisher = "rhaiscript";
          version = "0.6.7";
          sha256 = "sha256-KLfHPt+Emad7kHIyrqpjJRC28G3FEwKsAr8A5sYAhy0=";
        }
        {
          name = "probe-rs-debugger";
          publisher = "probe-rs";
          version = "0.24.2";
          sha256 = "sha256-1Gs5D5was/ZOZQrVD3/UiRm5bb12vGIl60AZV2EnazQ=";
        }
	{
          name = "vscode-opencl";
          publisher = "galarius";
          version = "0.8.3";
          sha256 = "sha256-c9F6BGa2Mxl/Vvrvifwpq76hwMGkl0Li8IrJG865wBM=";
        }
      ];
    };
  };
}
