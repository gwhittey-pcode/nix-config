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
  virtualisation.oci-containers.containers."komga" = {
    image = "gotson/komga";
    volumes = [
      "/HD/HD2/Config/komga/config:/config:rw"
      "/HD/HD2/Share1/Comics:/data:rw"
      "/HD/HD2/Share1/Comics:/data:rw"
      "/etc/timezone:/etc/timezone:ro"
    ];
    ports = [
      "25600:25600/tcp"
    ];
    user = "1000:100";
    log-driver = "journald";
    extraOptions = [
      "--network-alias=komga"
      "--network=komga_default"
    ];
  };
  systemd.services."docker-komga" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-komga_default.service"
    ];
    requires = [
      "docker-network-komga_default.service"
    ];
    partOf = [
      "docker-compose-komga-root.target"
    ];
    wantedBy = [
      "docker-compose-komga-root.target"
    ];
  };

  # Networks
  systemd.services."docker-network-komga_default" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f komga_default";
    };
    script = ''
      docker network inspect komga_default || docker network create komga_default
    '';
    partOf = [ "docker-compose-komga-root.target" ];
    wantedBy = [ "docker-compose-komga-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-komga-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
