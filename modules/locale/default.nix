{ lib, pkgs, config, home-manager, ... }:
let cfg = config.siren.locale;
in
{
  options.siren.locale.enable = lib.mkEnableOption "locale config";

  config = lib.mkIf cfg.enable {
    # Set your time zone.
    time.timeZone = "Europe/Berlin";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };

    # Configure keymap
    services.xserver.xkb = {
      layout = "us";
      variant = "altgr-intl";
    };

    # Configure console keymap
    console.useXkbConfig = true;
  };
}
