{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.sonarr;
in
{
  options.siren.sonarr = {
    enable = mkEnableOption "activate sonarr";
    openFirewall = mkOption {
      type = types.bool;
      default = true;
      description = "allow sonarr port in firewall";
    };
  };

  config = mkIf cfg.enable {
    siren.groups.arr.enable = true;
    siren.prowlarr.enable = true;

    services.sonarr = {
      enable = true;
      group = "arr";
      openFirewall = cfg.openFirewall;
    };

    #TODO: remove this once Sonarr supports .NET 8 (https://github.com/Sonarr/Sonarr/issues/7442)
    nixpkgs.config.permittedInsecurePackages = [
      "aspnetcore-runtime-wrapped-6.0.36"
      "aspnetcore-runtime-6.0.36"
      "dotnet-sdk-wrapped-6.0.428"
      "dotnet-sdk-6.0.428"
    ];
  };
}

