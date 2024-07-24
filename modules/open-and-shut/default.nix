{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.openshut;
in
{
  options.siren.openshut = {
    enable = mkEnableOption "enable open shut morse";
    keyboardInputPath = mkOption {
      type = types.str;
      example = "/dev/input/event3";
      description = "use evemu describe to find";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      evemu
      acpid
      busybox
    ];

    environment.etc = {
      "acpi/morse_code_acpi.sh" = {
        source = pkgs.writeText "morse_code_acpi.sh" ''
          #!${pkgs.bash}/bin/bash

          ${pkgs.busybox}/bin/grep -q close /proc/acpi/button/lid/*/state
          if [ $? = 0 ]; then
              /etc/acpi/morse_code_close.sh & disown
          fi
          ${pkgs.busybox}/bin/grep -q open /proc/acpi/button/lid/*/state
          if [ $? = 0 ]; then
              /etc/acpi/morse_code_open.sh & disown
          fi
        '';
        mode = "0755";
      };


      "acpi/morse_code_close.sh" = {
        source = pkgs.writeText "morse_code_acpi.sh" ''
          #!${pkgs.bash}/bin/bash

          # If the user closes the lid without opening it again for this duration, then
          # suspend the system
          suspend_pause=15

          closed_at=$(date +%s%3N)
          ${pkgs.busybox}/bin/pkill -f morse_code_open.sh

          echo "$closed_at" > /tmp/morse_code_close.timestamp

          sleep "$suspend_pause"
          systemctl suspend
        '';
        mode = "0755";
      };


      "acpi/morse_code_open.sh" = {
        source = pkgs.writeText "morse_code_acpi.sh" ''
          #!${pkgs.bash}/bin/bash

          readonly KEYBOARD_DEV=${cfg.keyboardInputPath}

          opened_at=$(date +%s%3N)
          ${pkgs.busybox}/bin/pkill -f morse_code_close.sh

          # Max duration of a dot and dash, in milliseconds
          dot_length=250
          dash_length=3000

          # Duration to pause before typing a letter or space, in seconds
          letter_pause=2
          space_pause=2

          declare -A morse_letters=(
              [.-]=A
              [-...]=B
              [-.-.]=C
              [-..]=D
              [.]=E
              [..-.]=F
              [--.]=G
              [....]=H
              [..]=I
              [.---]=J
              [-.-]=K
              [.-..]=L
              [--]=M
              [-.]=N
              [---]=O
              [.--.]=P
              [--.-]=Q
              [.-.]=R
              [...]=S
              [-]=T
              [..-]=U
              [...-]=V
              [.--]=W
              [-..-]=X
              [-.--]=Y
              [--..]=Z
              [-----]=0
              [.----]=1
              [..---]=2
              [...--]=3
              [....-]=4
              [.....]=5
              [-....]=6
              [--...]=7
              [---..]=8
              [----.]=9
              [.-.-.-]=DOT
              [--..--]=COMMA
              [---...]=:
              [..--..]=?
              [.----.]=APOSTROPHE
              [-....-]=MINUS
              [-..-.]=SLASH
              [-.--.]='('
              [-.--.-]=')'
              [.-..-.]='"'
              [-...-]=EQUAL
              [.-.-.]=+
              [.--.-.]=@
          )

          # Grab environment variables to interact with X
          # From https://gist.github.com/AladW/de1c5676d93d05a5a0e1/
          pid=$(pgrep -t tty"$(${pkgs.busybox}/bin/fgconsole)" xinit)
          pid=$(pgrep -P "$pid" -n)
          import_environment() {
              (( pid )) && for var; do
                  IFS='=' read key val < <(egrep -z "$var" /proc/$pid/environ)

                  printf -v "$key" %s "$val"
                  [[ ''${!key} ]] && export "$key"
              done
          }
          import_environment XAUTHORITY USER DISPLAY

          echo "$opened_at" > /tmp/morse_code_open.timestamp

          if [ ! -f /tmp/morse_code_close.timestamp ]; then
              exit 0
          fi
          closed_at=$(cat /tmp/morse_code_close.timestamp)
          elapsed="$((opened_at - closed_at))"

          if [ "$elapsed" -lt "$dot_length" ]; then
              printf "%s" "." >> /tmp/morse_code_letter
          elif [ "$elapsed" -lt "$dash_length" ]; then
              printf "%s" "-" >> /tmp/morse_code_letter
          else
              exit 0
          fi

          sleep "$letter_pause"
          sequence=$(cat /tmp/morse_code_letter)
          if [[ ! -v "morse_letters[$sequence]" ]] ; then
              exit 0
          fi

          if [[ "''${morse_letters[$sequence]}" == [A-Z] ]]; then
              ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code KEY_LEFTSHIFT --value 1 --sync
              ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_''${morse_letters[$sequence]}" --value 1 --sync
              ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_''${morse_letters[$sequence]}" --value 0 --sync
              ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code KEY_LEFTSHIFT --value 0 --sync
          elif [[ "''${morse_letters[$sequence]}" =~ [A-Z0-9] ]]; then
              ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_''${morse_letters[$sequence]}" --value 1 --sync
              ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_''${morse_letters[$sequence]}" --value 0 --sync
          else
              ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code KEY_LEFTSHIFT --value 1 --sync
              if [[ "''${morse_letters[$sequence]}" == ":" ]]; then
                  ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_SEMICOLON" --value 1 --sync
                  ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_SEMICOLON" --value 0 --sync
              elif [[ "''${morse_letters[$sequence]}" == "?" ]]; then
                  ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_SLASH" --value 1 --sync
                  ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_SLASH" --value 0 --sync
              elif [[ "''${morse_letters[$sequence]}" == '"' ]]; then
                  ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_APOSTROPHE" --value 1 --sync
                  ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_APOSTROPHE" --value 0 --sync
              elif [[ "''${morse_letters[$sequence]}" == '(' ]]; then
                  ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_9" --value 1 --sync
                  ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_9" --value 0 --sync
              elif [[ "''${morse_letters[$sequence]}" == ')' ]]; then
                  ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_0" --value 1 --sync
                  ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_0" --value 0 --sync
              elif [[ "''${morse_letters[$sequence]}" == '@' ]]; then
                  ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_2" --value 1 --sync
                  ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_2" --value 0 --sync
              elif [[ "''${morse_letters[$sequence]}" == '+' ]]; then
                  ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_EQUAL" --value 1 --sync
                  ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_EQUAL" --value 0 --sync
              fi
              ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code KEY_LEFTSHIFT --value 0 --sync
          fi

          rm /tmp/morse_code_letter

          sleep "$space_pause"
          ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_SPACE" --value 1 --sync
          ${pkgs.evemu}/bin/evemu-event $KEYBOARD_DEV --type EV_KEY --code "KEY_SPACE" --value 0 --sync
        '';
        mode = "0755";
      };
    };

    services.acpid = {
      enable = true;
      handlers = {
        "lm_lid" = {
          event = "button/lid.*";
          action = "/etc/acpi/morse_code_acpi.sh";
        };
      };
    };
  };
}
