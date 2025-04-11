{ config, lib, pkgs, ... }:
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
    docker.enable = true;
    plasma.enable = true;
    udev.enable = true;
    nvidia.enable = true;
    netbird.enable = true;
    # impermanence.enable = true;
    openssh.enable = true;
    vm.enable = true;
    ytblock.enable = true;
  };

  environment.systemPackages = with pkgs; [ vulkan-hdr-layer-kwin6 ];

  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
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
  # services.printing.enable = true;

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
