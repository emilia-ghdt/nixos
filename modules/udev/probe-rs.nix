{ config, flake-self, system-config, pkgs, lib, ... }:
with lib;
let cfg = config.siren.udev;
in
{
  config = mkIf cfg.enable {
    services.udev.extraRules = builtins.readFile ./69-probe-rs.rules;
    services.udev.packages = with pkgs; [
      probe-rs
    ];
  };
}
