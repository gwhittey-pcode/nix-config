# Auto-generated using compose2nix v0.3.1.
{ pkgs, lib, ... }:

{
  # Containers
  virtualisation.oci-containers.containers."jackett" = {
    image = "linuxserver/jackett";
    environment = {
      "PGID" = "1000";
      "PUID" = "1000";
      "TZ" = "America/Denver";
    };
    volumes = [
      "/HD/HD2/Config/Jackett:/config:rw"
      "/HD/HD2/Torrent:/downloads:rw"
    ];
    ports = [
      "192.168.1.3:9117:9117/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=jackett"
      "--network=media_stack_default"
    ];
  };
  systemd.services."docker-jackett" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-media_stack_default.service"
    ];
    requires = [
      "docker-network-media_stack_default.service"
    ];
    partOf = [
      "docker-compose-media_stack-root.target"
    ];
    wantedBy = [
      "docker-compose-media_stack-root.target"
    ];
  };
  virtualisation.oci-containers.containers."jellyfin" = {
    image = "lscr.io/linuxserver/jellyfin:latest";
    environment = {
      "JELLYFIN_PublishedServerUrl" = "http://192.168.1.3";
      "PGID" = "1000";
      "PUID" = "1000";
      "TZ" = "Etc/UTC";
    };
    volumes = [
      "/HD/HD1/Movies:/data/movies:rw"
      "/HD/HD1/TV:/data/tvshows:rw"
      "/HD/HD2/Config/Plex:/config:rw"
    ];
    ports = [
      "192.168.1.3:8096:8096/tcp"
      "192.168.1.3:8920:8920/tcp"
      "192.168.1.3:7359:7359/udp"
      "192.168.1.3:1900:1900/udp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=jellyfin"
      "--network=media_stack_default"
    ];
  };
  systemd.services."docker-jellyfin" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-media_stack_default.service"
    ];
    requires = [
      "docker-network-media_stack_default.service"
    ];
    partOf = [
      "docker-compose-media_stack-root.target"
    ];
    wantedBy = [
      "docker-compose-media_stack-root.target"
    ];
  };
  virtualisation.oci-containers.containers."medusa_docker" = {
    image = "lscr.io/linuxserver/medusa:latest";
    environment = {
      "PGID" = "1001";
      "PUID" = "1000";
      "TZ" = "America/New_York";
    };
    volumes = [
      "/HD/HD1/Media:/Media:rw"
      "/HD/HD1/TV:/tv:rw"
      "/HD/HD2/Config/Medusa:/config:rw"
      "/HD/HD2/Torrent:/data:rw"
    ];
    ports = [
      "192.168.1.3:9480:8081/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=medusa"
      "--network=media_stack_default"
    ];
  };
  systemd.services."docker-medusa_docker" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-media_stack_default.service"
    ];
    requires = [
      "docker-network-media_stack_default.service"
    ];
    partOf = [
      "docker-compose-media_stack-root.target"
    ];
    wantedBy = [
      "docker-compose-media_stack-root.target"
    ];
  };
  virtualisation.oci-containers.containers."plex" = {
    image = "lscr.io/linuxserver/plex:latest";
    environment = {
      "PGID" = "1000";
      "PLEX_CLAIM" = " claim-MBPbV1LiwzFdsm5nskkR";
      "PUID" = "1000";
      "TZ" = "Etc/UTC";
      "VERSION" = "docker";
    };
    volumes = [
      "/HD/HD1/Movies:/movies:rw"
      "/HD/HD1/TV:/tv:rw"
      "/HD/HD2/Config/Plex2:/config:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=host"
    ];
  };
  
  virtualisation.oci-containers.containers."prowlarr" = {
    image = "lscr.io/linuxserver/prowlarr:latest";
    environment = {
      "PGID" = "1000";
      "PUID" = "1000";
      "TZ" = "Etc/UTC";
    };
    volumes = [
      "/HD/HD2/Config/prowlarr/:/config:rw"
    ];
    ports = [
      "9696:9696/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=prowlarr"
      "--network=media_stack_default"
    ];
  };
  systemd.services."docker-prowlarr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-media_stack_default.service"
    ];
    requires = [
      "docker-network-media_stack_default.service"
    ];
    partOf = [
      "docker-compose-media_stack-root.target"
    ];
    wantedBy = [
      "docker-compose-media_stack-root.target"
    ];
  };
  virtualisation.oci-containers.containers."radarr" = {
    image = "linuxserver/radarr";
    environment = {
      "PGID" = "1001";
      "PUID" = "1000";
      "TZ" = "America/New_York";
      "UMASK_SET" = "022";
    };
    volumes = [
      "/HD/HD1/Media:/Media:rw"
      "/HD/HD1/Movies:/movies:rw"
      "/HD/HD2/Config/Radarr:/config:rw"
      "/HD/HD2/Torrent:/data:rw"
    ];
    ports = [
      "192.168.1.3:7878:7878/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=radarr"
      "--network=media_stack_default"
    ];
  };
  systemd.services."docker-radarr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-media_stack_default.service"
    ];
    requires = [
      "docker-network-media_stack_default.service"
    ];
    partOf = [
      "docker-compose-media_stack-root.target"
    ];
    wantedBy = [
      "docker-compose-media_stack-root.target"
    ];
  };

  # Networks
  systemd.services."docker-network-media_stack_default" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f media_stack_default";
    };
    script = ''
      docker network inspect media_stack_default || docker network create media_stack_default
    '';
    partOf = [ "docker-compose-media_stack-root.target" ];
    wantedBy = [ "docker-compose-media_stack-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-media_stack-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
