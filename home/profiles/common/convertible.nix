{ lib, pkgs, flake-self, config, system-config, ... }:
with lib; {
  imports = [ ./laptop.nix ];

  home.packages = with pkgs; [
    xournalpp # notes
    krita # drawing
  ];
}