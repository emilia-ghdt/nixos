{ lib, ... }:
with lib;
let
  # Filters out this file, also makes the strings absolute
  validFiles = dir:
    (map (file: ./. + "/${file}") 
      (filter
        (file:
          file != "default.nix")
        (builtins.attrNames (builtins.readDir dir))
      )
    );
in
{
  imports = validFiles ./.;
}
