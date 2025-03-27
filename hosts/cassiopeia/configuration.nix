{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan.
  ];

  networking.extraHosts = "172.23.107.243 server";

  # Modules
  siren = {
    users.emilia.enable = true;
    convertible.enable = true;
    gaming.enable = true;
    # plasma.enable = true;
    # xserver.enable = true;
    udev.enable = true;
    openshut.enable = true;
    openshut.keyboardInputPath = "/dev/input/event8";
    nvidia.enable = true;
    fingerprint.enable = true;
    netbird.enable = true;
    virtualbox.enable = true;
    librespeed.enable = true;
  };

  # Home-Manager
  siren.home-manager = {
    enable = true;
    username = "emilia";
    profile = "cassiopeia";
    stateVersion = "23.11"; # Please read the comment before changing.
  };

  # services.openvpn.servers = {
  #   infoVPN  = { config = '' config /home/emilia/Documents/Uni/openvpn_grosshardtj0_udp.ovpn ''; };
  # };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-dc9b251b-a0ff-47f9-ae68-ca5466370d49".device = "/dev/disk/by-uuid/dc9b251b-a0ff-47f9-ae68-ca5466370d49";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # TODO move to config
  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "cassiopeia";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
