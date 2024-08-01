{ config, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan.
  ];

  # Modules
  siren = {
    users.emilia.enable = true;
    common.enable = true;
    laptop.enable = true;
    convertible.enable = true;
    gaming.enable = true;
    locale.enable = true;
    fonts.enable = true;
    # plasma.enable = true;
    # xserver.enable = true;
    xserver.xkb.enable = true;
    udev.enable = true;
    openshut.enable = true;
    openshut.keyboardInputPath = "/dev/input/event8";
    home-assistant.enable = true;
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

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  # services.xserver.videoDrivers = ["nvidia"];

  # hardware.nvidia = {
  #   # Modesetting is required.
  #   modesetting.enable = true;

  #   # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
  #   # Enable this if you have graphical corruption issues or application crashes after waking
  #   # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
  #   # of just the bare essentials.
  #   powerManagement.enable = false;

  #   # Fine-grained power management. Turns off GPU when not in use.
  #   # Experimental and only works on modern Nvidia GPUs (Turing or newer).
  #   powerManagement.finegrained = false;

  #   # Use the NVidia open source kernel module (not to be confused with the
  #   # independent third-party "nouveau" open source driver).
  #   # Support is limited to the Turing and later architectures. Full list of 
  #   # supported GPUs is at: 
  #   # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
  #   # Only available from driver 515.43.04+
  #   # Currently alpha-quality/buggy, so false is currently the recommended setting.
  #   open = false;

  #   # Enable the Nvidia settings menu,
  # # accessible via `nvidia-settings`.
  #   nvidiaSettings = true;

  #   # Optionally, you may need to select the appropriate driver version for your specific GPU.
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;

  #   prime = {
  #     sync.enable = true;

  #     # Make sure to use the correct Bus ID values for your system!
  #     nvidiaBusId = "PCI:1:0:0";
  #     amdgpuBusId = "PCI:8:0:0";
  #   };
  # };

  # specialisation = {
  #   on-the-go.configuration = {
  #     system.nixos.tags = [ "on-the-go" ];
  #     hardware.nvidia = {
  #       prime.offload.enable = lib.mkForce true;
  #       prime.offload.enableOffloadCmd = lib.mkForce true;
  #       prime.sync.enable = lib.mkForce false;
  #     };
  #   };
  # };


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
