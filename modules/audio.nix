{ config, flake-self, system-config, pkgs, lib, ... }:
let cfg = config.siren.audio;
in
{
  options.siren.audio = {
    enable = lib.mkEnableOption "audio";
  };
  
  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      # jack.enable = true;

      wireplumber.extraConfig.bluetoothEnhancements =
        lib.mkIf config.siren.bluetooth.enable {
          "monitor.bluez.properties" = {
            "bluez5.enable-sbc-xq" = true;
            # "bluez5.enable-msbc" = true;
            "bluez5.enable-hw-volume" = true;
            # "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
          };
        };
    };
  };
}
