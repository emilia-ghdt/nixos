{ lib, pkgs, flake-self, config, system-config, ... }:
with lib; {
  imports = [ ./common.nix ];

  home.packages = with pkgs; [
  ];
}