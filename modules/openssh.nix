{ config, flake-self, system-config, pkgs, lib, ... }:
let cfg = config.siren.openssh;
in
{
  options.siren.openssh = {
    enable = lib.mkEnableOption "openssh config";
  };
  config = lib.mkIf cfg.enable {
    programs.ssh.package = pkgs.openssh_hpn;

    services.openssh = {
      enable = true;

      settings = {
        PasswordAuthentication = false;
      };
    };
  };
}
