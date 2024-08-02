{ config, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan.
  ];

  # Modules
  siren = {
    users.emilia.enable = true;
    convertible.enable = true;
    gaming.enable = true;
    # plasma.enable = true;
    # xserver.enable = true;
    xserver.xkb.enable = true;
    udev.enable = true;
    openshut.enable = true;
    openshut.keyboardInputPath = "/dev/input/event8";
    home-assistant.enable = true;
    nvidia = {
      enable = true;
      iGpuBrand = "amdgpu";
      iGpuId = "PCI:8:0:0";
      dGpuId = "PCI:1:0:0";
    };
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

  # Enable sound with pipewire.
  sound.enable = true;
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
  system.stateVersion = "23.11"; # Did you read the comment?
}
