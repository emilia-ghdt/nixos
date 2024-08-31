{ config, flake-self, pkgs, lib, ... }@inputs:
with lib;
let 
  cfg = config.siren.programs.git;
in
{
  options.siren.programs.git = {
    enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;

          aliases = {
        gud = "add";
        on-my-level = "push -f --with-lease";
      };
      extraConfig = {
        user = {
          name = "Emilia Groß-Hardt";
          # email = "${secrets.user.mainemail}"; TODO
        };
        commit.gpgsign = true;
        init.defaultBranch = "main";
        merge = {
          ff = "no";
          no-commit = "yes";
        };
        pull.ff = "only";
      };

      includes = [
        {
          condition = "hasconfig:remote.*.url:github.com/**";
          contents = {
            user = {
              name = "Emilia Groß-Hardt";
              email = "<56568085+emilia-ghdt@users.noreply.github.com>";
            };
          };
        }
        {
          condition = "hasconfig:remote.*.url:git.fachschaft.info/**";
          contents = {
            user = {
              name = "Emilia Groß-Hardt";
              email = "<emilia@fachschaft.info>";
            };
          };
        }
        # TODO uni git, privates gitlab
      ];
    };

  };
}
