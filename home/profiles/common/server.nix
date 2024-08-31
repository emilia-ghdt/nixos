{ lib, pkgs, flake-self, config, system-config, ... }:
{
  imports = [ ./common.nix ];

  home.packages = with pkgs; [
  ];
}