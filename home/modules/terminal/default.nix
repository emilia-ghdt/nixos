{ lib, pkgs, config, ... }:
{
  imports = [
    ./alacritty.nix
    ./kitty.nix
  ];
}
