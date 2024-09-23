{ lib, pkgs, config, ... }:
let cfg = config.siren.programs.hyprland;
in
{
  options.siren.programs.hyprland = {
    enable = lib.mkEnableOption "hyprland config";
    monitors = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "monitors";
      default = [",preferred,auto,1"];
    };
    terminal = lib.mkOption {
      type = lib.types.str;
      description = "default terminal emulator";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      
      settings = {
        # This is an example Hyprland config file.
        # Refer to the wiki for more information.
        # https://wiki.hyprland.org/Configuring/Configuring-Hyprland/

        # Please note not all available settings / options are set here.
        # For a full list, see the wiki

        # You can split this configuration into multiple files
        # Create your files separately and then link them to this file like this:
        # source = ~/.config/hypr/myColors.conf


        ################
        ### MONITORS ###
        ################

        # See https://wiki.hyprland.org/Configuring/Monitors/
        monitor = cfg.monitors;


        ###################
        ### MY PROGRAMS ###
        ###################

        # See https://wiki.hyprland.org/Configuring/Keywords/

        # Set programs that you use
        "$terminal" = cfg.terminal;
        "$fileManager" = "${pkgs.yazi}/bin/yazi";
        "$menu" = "${pkgs.wofi}/bin/wofi --show drun";
        "$brightness" = "${pkgs.brightnessctl}/bin/brightnessctl";

        #################
        ### AUTOSTART ###
        #################

        # Autostart necessary processes (like notifications daemons, status bars, etc.)
        # Or execute your favorite apps at launch like this:

        # exec-once = $terminal
        # exec-once = nm-applet &
        # exec-once = waybar & hyprpaper & firefox


        #############################
        ### ENVIRONMENT VARIABLES ###
        #############################

        # See https://wiki.hyprland.org/Configuring/Environment-variables/

        env = [
          "XCURSOR_SIZE,40"
          "HYPRCURSOR_SIZE,40"
        ];


        #####################
        ### LOOK AND FEEL ###
        #####################

        # Refer to https://wiki.hyprland.org/Configuring/Variables/

        # https://wiki.hyprland.org/Configuring/Variables/#general
        general = { 
            gaps_in = 4;
            gaps_out = 15;

            border_size = 2;

            # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
            "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
            "col.inactive_border" = "rgba(595959aa)";

            # Set to true enable resizing windows by clicking and dragging on borders and gaps
            resize_on_border = true;

            # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
            allow_tearing = false;

            layout = "master";
        };

        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        master = {
            new_status = "slave";
            orientation = "left";
            smart_resizing = "false";
        };

        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        dwindle = {
            pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = true; # You probably want this
        };

        # https://wiki.hyprland.org/Configuring/Variables/#decoration
        decoration = {
            rounding = 8;

            # Change transparency of focused and unfocused windows
            active_opacity = 1.0;
            inactive_opacity = 1.0;

            drop_shadow = true;
            shadow_range = 4;
            shadow_render_power = 3;
            "col.shadow" = "rgba(1a1a1aee)";

            # https://wiki.hyprland.org/Configuring/Variables/#blur
            blur = {
                enabled = true;
                size = 3;
                passes = 3;
                
                vibrancy = 0.13;
            };
        };

        # https://wiki.hyprland.org/Configuring/Variables/#animations
        animations = {
            enabled = true;

            # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
            animation = [
              "windows, 1, 7, myBezier"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "borderangle, 1, 8, default"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
            ];
        };

        # https://wiki.hyprland.org/Configuring/Variables/#misc
        misc = { 
            force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
            disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
        };


        #############
        ### INPUT ###
        #############

        # https://wiki.hyprland.org/Configuring/Variables/#input
        input = {
            kb_layout = "de";
            kb_variant = "";
            kb_model = "";
            kb_options = "";
            kb_rules = "";

            follow_mouse = 1;

            sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
            accel_profile = "flat";

            touchpad = {
                natural_scroll = false;
            };
        };

        # https://wiki.hyprland.org/Configuring/Variables/#gestures
        gestures = {
            workspace_swipe = false;
        };

        ####################
        ### KEYBINDINGSS ###
        ####################

        # See https://wiki.hyprland.org/Configuring/Keywords/
        "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier

        bind = [
          # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
          "$mainMod, Q, exec, $terminal"
          "$mainMod, C, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$mainMod, R, exec, $menu"
          "$mainMod, P, pseudo, # dwindle"
          "$mainMod, J, togglesplit, # dwindle"

          # Move focus with mainMod + arrow keys
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          "$mainMod SHIFT, left, movewindow, l"
          "$mainMod SHIFT, right, movewindow, r"
          "$mainMod SHIFT, up, movewindow, u"
          "$mainMod SHIFT, down, movewindow, d"

          # Switch workspaces with mainMod + [0-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          # Example special workspace (scratchpad)
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];

        bindm = [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        bindel = [
          # Audio volume
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

          # Brightness
          ", XF86MonBrightnessUp, exec, $brightness set 51+"
          ", XF86MonBrightnessDown, exec, $brightness set 51-"
        ];

        bindl = [
          # Audio mute
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ];

        ##############################
        ### WINDOWS AND WORKSPACES ###
        ##############################

        # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
        # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

        # Example windowrule v1
        # windowrule = float, ^(kitty)$

        # Example windowrule v2
        # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

      };
    };

    # services.hypridle.enable = true;

    programs.hyprlock.enable = true;
    programs.hyprlock.settings = {};
  };
}
