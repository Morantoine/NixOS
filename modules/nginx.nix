{ config, pkgs, inputs, ... }:

{

  # All the necessary secrets
  sops.secrets = {
    flame_password = { };
    gufis_token = { };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "antoine.moran@protonmail.com";
  };

  virtualisation.oci-containers = {
    containers = {
      "flame" = {
        image = "pawelmalak/flame:2.3.1";
        ports = [ "5005:5005" ];
        environmentFiles = [
          config.sops.secrets.flame_password.path
        ];
        volumes = [ "flame_data:/app/data" ];
      };
      "gufis-bot" = {
        imageFile = inputs.xp-bot.docker;
        image = "xp-bot";
        environmentFiles = [
          config.sops.secrets.gufis_token.path
        ];
        volumes = [ "/home/antoine/Repos/XP_Bot/data:/data" ];
      };
      "filebrowser" = {
        image = "filebrowser/filebrowser:v2.23.0-s6";
        ports = [ "8080:80" ];
        environment = {
          PUID = "0";
          PGID = "0";
        };
        volumes = [
          "filebrowser_root:/srv"
          "/home/antoine/filebrowser/filebrowser.db:/database/filebrowser.db"
        ];
      };
      "deluge" = {
        image = "lscr.io/linuxserver/deluge:latest";
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Paris";
          DELUGE-LOGLEVEL = "error";
        };
        ports = [ "6881:6881/udp" "6881:6881" "8112:8112" ];
        volumes = [
          "deluge-config:/config"
          "/data/torrents:/data/torrents"
        ];
        # extraOptions = [ "--restart \"unless-stopped\"" ];
      };
      "flaresolverr" = {
        image = "ghcr.io/flaresolverr/flaresolverr:latest";
        environment = {
          LOGLEVEL = "info";
        };
        ports = [ "8191:8191" ];
      };
      "radarr" = {
        image = "ghcr.io/hotio/radarr:latest";
        ports = [ "7878:7878" ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Paris";
        };
        volumes = [
          "/data:/data"
          "radarr_config:/config"
        ];
      };
      "sonarr" = {
        image = "ghcr.io/hotio/sonarr:latest";
        ports = [ "8989:8989" ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Paris";
        };
        volumes = [
          "/data:/data"
          "sonarr_config:/config"
        ];
      };
      "jellyfin" = {
        image = "lscr.io/linuxserver/jellyfin:latest";
        ports = [ "8096:8096" ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Paris";
        };
        volumes = [
          "/data:/data"
          "jellyfin_config_2:/config"
        ];
      };
      "jellyseerr" = {
        image = "fallenbagel/jellyseerr:latest";
        ports = [ "5055:5055" ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Paris";
        };
        volumes = [
          "jellyseerr_config:/app/config"
        ];
      };
    };
  };

  services.paperless = {
    enable = true;
    port = 58080;
    extraConfig.PAPERLESS_OCR_LANGUAGE = "eng";
  };
  systemd.services.paperless-scheduler.after = ["var-lib-paperless.mount"];
  systemd.services.paperless-consumer.after = ["var-lib-paperless.mount"];
  systemd.services.paperless-web.after = ["var-lib-paperless.mount"];

  services.jackett = {
    enable = true;
    group = "users";
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = let
      SSL = {
        enableACME = true;
        forceSSL = true;
      }; in {
        "rattlesnake.fr" = {
          globalRedirect = "home.rattlesnake.fr";
        };

        "home.rattlesnake.fr" = ( SSL // {
          locations."/".proxyPass = "http://127.0.0.1:5005/";
        });
        "drive.rattlesnake.fr" = ( SSL // {
          locations."/".proxyPass = "http://127.0.0.1:8080/";
        });
        "papers.rattlesnake.fr" = ( SSL // {
          locations."/".proxyPass = "http://127.0.0.1:58080/";
        });
        "tv.rattlesnake.fr" = ( SSL // {
          locations."/".proxyPass = "http://127.0.0.1:8096/";
        });
        "jackett.rattlesnake.fr" = ( SSL // {
          locations."/".proxyPass = "http://127.0.0.1:9117/";
        });
        "seerr.rattlesnake.fr" = ( SSL // {
          locations."/".proxyPass = "http://127.0.0.1:5055/";
        });
        "sonarr.rattlesnake.fr" = ( SSL // {
          locations."/".proxyPass = "http://127.0.0.1:8989/";
        });
        "radarr.rattlesnake.fr" = ( SSL // {
          locations."/".proxyPass = "http://127.0.0.1:7878/";
        });
        "torrent.rattlesnake.fr" = ( SSL // {
          locations."/".proxyPass = "http://127.0.0.1:8112/";
        });
        "flaresolverr.rattlesnake.fr" = ( SSL // {
          locations."/".proxyPass = "http://127.0.0.1:8191/";
        });
        "sync.rattlesnake.fr" = ( SSL // {
          locations."/" = {
            proxyPass = "http://127.0.0.1:8384/";
          };
        });
    };
  };

  }
