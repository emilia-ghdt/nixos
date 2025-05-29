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
    # TODO
    # systemd.tmpfiles.rules = [
    #     "d /home/emilia/.ssh/control 0640 emilia users -"
    # ];
    home.file.".ssh/control/.placeholder" = {
      text = "";
    };

    programs.ssh = {
      enable = true;
      package = pkgs.openssh_hpn;
      
      matchBlocks = {
        "*" = {
          identitiesOnly = true;
          extraOptions = {
            "ControlMaster" = "auto";
            "ControlPath" = "~/.ssh/control/ssh-%r@%h:%p";
            "ControlPersist" = "300";
          };
        };

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

        "git.cs.uni-bonn.de" = {
          identityFile = "~/.ssh/emilia_ed25519";
          user = "git";
          port = 22;
        };

        "gitlab.informatik.uni-bonn.de" = {
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

        "loginstud" = {
          hostname = "login-stud.informatik.uni-bonn.de";
          identityFile = "~/.ssh/emilia_ed25519";
          user = "grosshardtj0";
          port = 22;
        };

        "pool-*" = {
          proxyJump = "loginstud";
          identityFile = "~/.ssh/emilia_ed25519";
          user = "grosshardtj0";
          port = 22;
        };
        
        "inform" = {
          hostname = "inform.informatik.uni-bonn.de";
          identityFile = "~/.ssh/emilia_ed25519";
          user = "emilia";
          port = 22;
        };

        "inform_proxied" = {
          hostname = "inform.informatik.uni-bonn.de";
          proxyJump = "loginstud";
          identityFile = "~/.ssh/emilia_ed25519";
          user = "emilia";
          port = 22;
        };
        
        "teq" = {
          hostname = "tequila";
          proxyJump = "inform";
          identityFile = "~/.ssh/emilia_ed25519";
          user = "emilia";
          port = 22;
        };

        "aquarius" = {
          hostname = "aquarius.knniff.internal";
          identityFile = "~/.ssh/emilia_ed25519";
          user = "emilia";
          port = 22;
        };

        "orion" = {
          hostname = "orion.knniff.internal";
          identityFile = "~/.ssh/emilia_ed25519";
          user = "emilia";
          port = 22;
        };
      };
    };
  };
}
