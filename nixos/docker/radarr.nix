# Auto-generated using compose2nix v0.3.1.
{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  # Containers
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
      "--network=radarr_default"
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
      "docker-network-radarr_default.service"
    ];
    requires = [
      "docker-network-radarr_default.service"
    ];
    partOf = [
      "docker-compose-radarr-root.target"
    ];
    wantedBy = [
      "docker-compose-radarr-root.target"
    ];
  };

  # Networks
  systemd.services."docker-network-radarr_default" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f radarr_default";
    };
    script = ''
      docker network inspect radarr_default || docker network create radarr_default
    '';
    partOf = [ "docker-compose-radarr-root.target" ];
    wantedBy = [ "docker-compose-radarr-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-radarr-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
