{ config, pkgs, lib, ... }:
let cfg = config.siren.udev;
in
{
  config = lib.mkIf cfg.enable {
    services.udev.packages = let
      udevRules = pkgs.callPackage ./probe-rs-udev-rules.nix { inherit pkgs; };
    in 
      [ udevRules ];
  };
}
