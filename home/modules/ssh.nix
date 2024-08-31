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
        "github.com" = {
          identityFile = "~/.ssh/emilia_ed25519";
          user = "git";
          port = 22;
        };
      };
    };
  };
}
