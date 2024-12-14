{ config, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan.
    (import ../../disko/desktop.nix { device = "/dev/nvme1n1"; })
  ];

  # Modules
  siren = {
    users.emilia.enable = true;
    desktop.enable = true;
    gaming.enable = true;
    # plasma.enable = true;
    # xserver.enable = true;
    udev.enable = true;
    nvidia.enable = true;
    netbird.enable = true;
    # impermanence.enable = true;
    openssh.enable = true;
  };

  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

  siren.networking = {
    ports = {
      localsend = true;
    };
  };

  # Home-Manager
  siren.home-manager = {
    enable = true;
    username = "emilia";
    profile = "orion";
    stateVersion = "24.05"; # Please read the comment before changing.
  };

  virtualisation.docker.storageDriver = "btrfs";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "orion";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
