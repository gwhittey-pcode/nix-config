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
  virtualisation.oci-containers.containers."plex" = {
    image = "lscr.io/linuxserver/plex:latest";
    environment = {
      "PGID" = "1000";
      "PLEX_CLAIM" = "";
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
  systemd.services."docker-plex" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    partOf = [
      "docker-compose-plex2-root.target"
    ];
    wantedBy = [
      "docker-compose-plex2-root.target"
    ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-plex2-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
