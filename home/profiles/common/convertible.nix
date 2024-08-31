{ lib, pkgs, flake-self, config, system-config, ... }:
{
  imports = [ ./laptop.nix ];

  home.packages = with pkgs; [
    xournalpp # notes
    krita # drawing
  ];
}