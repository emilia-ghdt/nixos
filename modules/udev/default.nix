{ lib, ... }:
with lib;
{
  imports = [
    ./vial.nix
    ./arduino.nix
    ./probe-rs.nix
  ];

  options.siren.udev = {
    enable = mkEnableOption "activate udev rules";
  };
}
