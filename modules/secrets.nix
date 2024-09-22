{ lib, pkgs, config, ... }:
{
  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/emilia/.config/sops/age/keys.txt";

  sops.secrets.mullvad-id = {
    owner = "emilia";
  };
}
