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
  virtualisation.oci-containers.containers."readarr" = {
    image = "lscr.io/linuxserver/readarr:develop";
    environment = {
      "PGID" = "1001";
      "PUID" = "1000";
      "TZ" = "Etc/New_York";
    };
    volumes = [
      "/HD/HD2/Config/readarr:/config:rw"
      "/HD/HD2/Torrent:/downloads:rw"
      "/HD/HD3/Ebooks:/books:rw"
    ];
    ports = [
      "192.168.1.3:8787:8787/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=readarr"
      "--network=readarr_default"
    ];
  };
  systemd.services."docker-readarr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-readarr_default.service"
    ];
    requires = [
      "docker-network-readarr_default.service"
    ];
    partOf = [
      "docker-compose-readarr-root.target"
    ];
    wantedBy = [
      "docker-compose-readarr-root.target"
    ];
  };

  # Networks
  systemd.services."docker-network-readarr_default" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f readarr_default";
    };
    script = ''
      docker network inspect readarr_default || docker network create readarr_default
    '';
    partOf = [ "docker-compose-readarr-root.target" ];
    wantedBy = [ "docker-compose-readarr-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-readarr-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
