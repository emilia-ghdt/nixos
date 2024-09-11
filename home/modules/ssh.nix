{ config, flake-self, pkgs, lib, ... }@inputs:
with lib;
let 
  cfg = config.siren.programs.ssh;
in
{
  options.siren.programs.ssh = {
    enable = mkEnableOption "ssh";
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      
      matchBlocks = {
        "git.fachschaft.info" = {
          identityFile = "~/.ssh/fs_gitlab";
          user = "git";
          port = 10022;
        };
      };

      matchBlocks = {
        "github.com" = {
          identityFile = "~/.ssh/emilia_ed25519";
          user = "git";
          port = 22;
        };
      };

      matchBlocks = {
        "gitlab.ptyonic.dev" = {
          identityFile = "~/.ssh/emilia_ed25519";
          user = "git";
          port = 22;
        };
      };

      matchBlocks = {
        "contabo" = {
          hostname = "ptyonic.dev";
          identityFile = "~/.ssh/emilia_ed25519";
          user = "root";
          port = 21449;
        };
      };
    };
  };
}
