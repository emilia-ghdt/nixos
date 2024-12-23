{ config, pkgs, lib, ... }:
let cfg = config.siren.groups.arr;
in
{
  options.siren.groups.arr = {
    enable = lib.mkEnableOption "user emilia";
  };
  
  config = lib.mkIf cfg.enable {
    users.groups.arr.gid = 4200;
  };
}
