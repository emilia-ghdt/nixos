{ lib, pkgs, config, ... }:
let cfg = config.siren.qbittorrentvpn;
in
{
  options.siren.qbittorrentvpn = {
    enable = lib.mkEnableOption "activate jellyfin";
    enableNginx = lib.mkEnableOption "activate nginx proxy";
    enableSocks = lib.mkEnableOption "activate SOCKS proxy";
    enablePrivoxy = lib.mkEnableOption "activate SOCKS proxy";

    domain = lib.mkOption {
      type = lib.types.str;
      default = "qbit.${config.siren.domain}";
      description = "domain name for qbittorrent";
    };

    lanCidr = lib.mkOption {
      type = lib.types.str;
      default = "192.168.1.0/24";
      description = "CIDR of the LAN";
    };

    containerVersion = lib.mkOption {
      type = lib.types.str;
      default = "5.0.3-1-01";
      description = "qbittorrentvpn version";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      siren.docker.enable = true;
      siren.groups.arr.enable = true;

      users.users."qbittorrent" = {
        isSystemUser = true;
        group = "arr";
        uid = 4100;
      };

      sops.secrets = {
        "qbittorrentvpn.env" = {
          owner = "qbittorrent";
          group = "arr";
        };
      };

      virtualisation.oci-containers.backend = "docker";
      virtualisation.oci-containers.containers.qbittorrentvpn = {
        image = "binhex/arch-qbittorrentvpn:${cfg.containerVersion}";
        
        volumes = [
          "/arr/torrents:/arr/torrents"
          "qbittorrentvpn_config:/config"
        ];
        
        ports = [
          "${if cfg.enableNginx then "127.0.0.1:" else ""}8080:8080"
        ];
        
        environment = {
          VPN_ENABLED = "yes";
          VPN_PROV = "airvpn";
          VPN_CLIENT = "wireguard";
          ENABLE_STARTUP_SCRIPTS = "no";
          ENABLE_PRIVOXY = if cfg.enablePrivoxy then "yes" else "no";
          STRICT_PORT_FORWARD = "yes" ;
          USERSPACE_WIREGUARD = "no";
          ENABLE_SOCKS = if cfg.enableSocks then "yes" else "no";
          LAN_NETWORK = cfg.lanCidr;
          NAME_SERVERS = "84.200.69.80,37.235.1.174,1.1.1.1,37.235.1.177,84.200.70.40,1.0.0.1";
          VPN_INPUT_PORTS = "";
          VPN_OUTPUT_PORTS = ""; 
          DEBUG = "false";
          WEBUI_PORT = "8080";
          UMASK = "000";
          PUID = "4100";
          PGID = "4200";
        };

        environmentFiles = [
          /run/secrets/qbittorrentvpn.env
        ];

        extraOptions = [
          "--sysctl=net.ipv4.conf.all.src_valid_mark=1"
          "--privileged=true"
        ];
      };
    }

    (lib.mkIf cfg.enablePrivoxy {
      virtualisation.oci-containers.containers.qbittorrentvpn = {
        ports = [
          "${if cfg.enableNginx then "127.0.0.1:" else ""}8118:8118"
        ];
      };
    })

    (lib.mkIf cfg.enableSocks {
      virtualisation.oci-containers.containers.qbittorrentvpn = {
        ports = [
          "${if cfg.enableNginx then "127.0.0.1:" else ""}9118:9118"
        ];
      };
    })

    (lib.mkIf cfg.enableNginx {
      siren.nginx.enable = true;

      services.nginx.virtualHosts."${cfg.domain}" = {
        forceSSL = true;

        sslCertificate = "/var/lib/acme/${config.siren.domain}/cert.pem";
        sslCertificateKey = "/var/lib/acme/${config.siren.domain}/key.pem";

        locations."/" = {
          proxyPass = "http://127.0.0.1:8080";
        };
      };
    })

  ]);

}
