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
      package = pkgs.openssh_hpn;
      
      matchBlocks = {
        "git.fachschaft.info" = {
          identityFile = "~/.ssh/fs_gitlab";
          user = "git";
          port = 10022;
        };
      
        "github.com" = {
          identityFile = "~/.ssh/emilia_ed25519";
          user = "git";
          port = 22;
        };
      
        "gitlab.ptyonic.dev" = {
          identityFile = "~/.ssh/emilia_ed25519";
          user = "git";
          port = 22;
        };

        "contabo" = {
          hostname = "ptyonic.dev";
          identityFile = "~/.ssh/emilia_ed25519";
          user = "root";
          port = 21449;
        };

        "git.cs.uni-bonn.de" = {
          identityFile = "~/.ssh/emilia_ed25519";
          user = "git";
          port = 22;
        };

        "nyriad" = {
          hostname = "nyriad.de";
          identityFile = "~/.ssh/emilia_ed25519";
          user = "emilia";
          port = 22;
        };
      };
    };
  };
}
