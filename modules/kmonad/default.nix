{ config, flake-self, system-config, pkgs, lib, ... }:
let cfg = config.siren.kmonad;
in
{
  options.siren.kmonad = {
    enable = lib.mkEnableOption "kmonad";
    device = lib.mkOption {
      type = lib.types.str;
      description = "which device to apply kmonad layout to";
    };
  };
  
  config = lib.mkIf cfg.enable {
    services.kmonad = {
      enable = true;
      keyboards = {
        miryoku = {
          device = cfg.device;
          extraGroups = [ "wheel" "uinput" "input" ];
          config = (builtins.readFile ./miryoku_kmonad.kbd);
        };
      };
    };
  };
}
