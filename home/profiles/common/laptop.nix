{ lib, pkgs, flake-self, config, system-config, ... }:
{
  imports = [ ./desktop.nix ];

  home.packages = with pkgs; [
    wifi-qr
  ];
}
