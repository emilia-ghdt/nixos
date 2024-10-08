# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import ../../disko/server.nix { device = "/dev/vda"; })
    ];

  siren = {
    common.enable = true;
    users.emilia.enable = true;
    docker.enable = true;
    openssh.enable = true;
  };

  siren.home-manager = {
    enable = true;
    username = "emilia";
    profile = "cygnus";
    stateVersion = "24.05"; # Don't change!
  };

  virtualisation.docker.storageDriver = "btrfs";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "cygnus"; # Define your hostname.

  security.acme = {
    acceptTerms = true;
    defaults.email = "emilia.ghdt+acme@gmail.com";
    certs."nyriad.de" = {
      domain = "*.nyriad.de";
      extraDomainNames = [
        "nyriad.de"
      ];
      dnsProvider = "netcup";
      credentialFiles = {
        "NETCUP_CUSTOMER_NUMBER_FILE" = "/run/secrets/netcup-api/customer-number";
        "NETCUP_API_KEY_FILE" = "/run/secrets/netcup-api/api-key";
        "NETCUP_API_PASSWORD_FILE" = "/run/secrets/netcup-api/api-password";
        "NETCUP_PROPAGATION_TIMEOUT_FILE" = "${pkgs.writeText "netcup-propagation-timeout" ''
          300
        ''}";
      };
      group = "nginx";
    };
  };

  sops.secrets = let 
    secretConf = { mode = "0040"; group = "acme"; };
  in {
    "netcup-api/customer-number" = secretConf;
    "netcup-api/api-key" = secretConf;
    "netcup-api/api-password" = secretConf;
  };

  services.nginx.enable = true;
  services.nginx.virtualHosts."portainer.nyriad.de" = {
    forceSSL = true;

    sslCertificate = "/var/lib/acme/nyriad.de/cert.pem";
    sslCertificateKey = "/var/lib/acme/nyriad.de/key.pem";

    locations."/" = {
      proxyPass = "https://localhost:9443";
    };
  };

  users.users.minecraft = {
    isSystemUser = true;
    uid = 25565;
    group = "minecraft";
  };
  users.groups.minecraft = {
    gid = 25565;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 443 80 ];
  networking.firewall.allowedUDPPorts = [ ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

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
  system.stateVersion = "24.05"; # Did you read the comment?

}
