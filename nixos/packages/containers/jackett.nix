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
      "--network=jackett_default"
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
      "docker-network-jackett_default.service"
    ];
    requires = [
      "docker-network-jackett_default.service"
    ];
    partOf = [
      "docker-compose-jackett-root.target"
    ];
    wantedBy = [
      "docker-compose-jackett-root.target"
    ];
  };

  # Networks
  systemd.services."docker-network-jackett_default" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f jackett_default";
    };
    script = ''
      docker network inspect jackett_default || docker network create jackett_default
    '';
    partOf = [ "docker-compose-jackett-root.target" ];
    wantedBy = [ "docker-compose-jackett-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-jackett-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
