{ config, flake-self, system-config, pkgs, lib, ... }:
{
  options.siren.domain = lib.mkOption {
    type = lib.types.string;
    default = "nyriad.de";
    description = "base domain for all that good stuff";
  };
}
