{ config, flake-self, system-config, pkgs, lib, ... }:
let cfg = config.siren.openssh;
in
{
  options.siren.openssh = {
    enable = lib.mkEnableOption "openssh config";
  };
  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;

      sftpServerExecutable = "${pkgs.openssh_hpn}/bin/sftp";

      settings = {
        PasswordAuthentication = false;
      };
    };
  };
}
