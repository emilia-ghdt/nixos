# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import ../../disko/aquarius.nix { device = "/dev/vda"; })
    ];

  siren = {
    common.enable = true;
    users.emilia.enable = true;
    docker.enable = true;
    portainer.enable = true;
    openssh.enable = true;
    jellyfin = {
      enable = true;
    };
    librespeed.enable = true;
    netbird.enable = true;
  };

  siren.home-manager = {
    enable = true;
    username = "emilia";
    profile = "aquarius";
    stateVersion = "24.11"; # Don't change!
  };

  # boot.loader.systemd-boot.enable = true;
  boot.loader.grub = {
    enable = true;
    zfsSupport = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    mirroredBoots = [
      { devices = [ "nodev"]; path = "/boot"; }
    ];
  };
  boot.zfs.extraPools = [ "vault" ];
  # boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "aquarius"; # Define your hostname.
  networking.hostId = "77a933a4";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 443 80 ];
  # networking.firewall.allowedUDPPorts = [ ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}