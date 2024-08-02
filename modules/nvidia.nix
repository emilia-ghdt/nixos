{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.nvidia;
in
{
  options.siren.nvidia = {
    enable = mkEnableOption "nvidia config";
    onTheGoBootOption = mkOption {
      type = types.bool;
    };
    hasIGpu = mkOption {
      type = types.bool;
      description = "Whether or not the device has an iGPU";
    };
    iGpuBrand = mkOption {
      type = types.enum [ "amdgpu" "intel" ];
      description = "iGPU";
    };
    iGpuId = mkOption {
      type = types.str;
      example = "PCI:8:0:0";
      description = "iGPU id";
    };
    dGpuId = mkOption {
      type = types.str;
      example = "PCI:1:0:0";
      description = "dGPU id";
    };
  };

  config = mkIf cfg.enable {
    # Enable OpenGL
    hardware.opengl = {
      enable = true;
    };

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = ["nvidia"];
    
    boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

    hardware.nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
      # of just the bare essentials.
      powerManagement.enable = false;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of 
      # supported GPUs is at: 
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      prime = mkIf cfg.enable {
        sync.enable = true;

        # Make sure to use the correct Bus ID values for your system!
        nvidiaBusId = cfg.hasIGpu;
        "${cfg.iGpuBrand}BusId" = cfg.iGpuId;
      };
    };

    specialisation = mkIf cfg.onTheGoBootOption && mkIf cfg.hasIGpu {
      on-the-go.configuration = {
        system.nixos.tags = [ "on-the-go" ];
        hardware.nvidia = {
          prime.offload.enable = lib.mkForce true;
          prime.offload.enableOffloadCmd = lib.mkForce true;
          prime.sync.enable = lib.mkForce false;
        };
      };
    };

    environment.systemPackages = with pkgs; (lib.optionals siren.wayland [
      egl-wayland
    ]);
  };
}
