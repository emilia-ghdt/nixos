{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.programs.hyprland;
in
{
  options.siren.programs.hyprland.enable = mkEnableOption "hyprland config";

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "monitor" = ",preferred,auto,auto";
        "$terminal" = "${pkgs.wezterm}/bin/wezterm";
        "$fileManager" = "${pkgs.yazi}/bin/yazi";
        "$menu" = "${pkgs.wofi}/bin/wofi";

        "general" = {
          "gaps_in" = 5;
          "gaps_out" = 20;

          "border_size" = 2;
        };

        "input" = {
          "kb_layout" = "de";
          "touchpad" = {
            "natural_scroll" = false;
          };
        };

        "misc" = {
          "force_default_wallpaper" = -1;
          "disable_hyprland_logo" = false;
        };


        "windowrulev2" = [
          "suppressevent maximize, class:.*"
        ];

        # Bindings
        "$mainMod" = "SUPER";

        "bind" = [
          "$mainMod, Q, exec, $terminal"
        ];
      };
    };

    # services.hypridle.enable = true;

    programs.hyprlock.enable = true;
    programs.hyprlock.settings = {};

    # home.packages = with pkgs; [
    #   swaylock
    #   swaybg
    # ];
  };
}
