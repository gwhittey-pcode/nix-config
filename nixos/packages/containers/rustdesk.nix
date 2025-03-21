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
  virtualisation.oci-containers.containers."hbbr" = {
    image = "rustdesk/rustdesk-server:latest";
    volumes = [
      "/HD/HD2/docker_files/RustDesk/data:/root:rw"
    ];
    cmd = [ "hbbr" ];
    log-driver = "journald";
    extraOptions = [
      "--network=host"
    ];
  };
  systemd.services."docker-hbbr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    partOf = [
      "docker-compose-rustdesk-root.target"
    ];
    wantedBy = [
      "docker-compose-rustdesk-root.target"
    ];
  };
  virtualisation.oci-containers.containers."hbbs" = {
    image = "rustdesk/rustdesk-server:latest";
    environment = {
      "ALWAYS_USE_RELAY" = "Y";
    };
    volumes = [
      "/HD/HD2/docker_files/RustDesk/data:/root:rw"
    ];
    cmd = [ "hbbs" ];
    dependsOn = [
      "hbbr"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=host"
    ];
  };
  systemd.services."docker-hbbs" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    partOf = [
      "docker-compose-rustdesk-root.target"
    ];
    wantedBy = [
      "docker-compose-rustdesk-root.target"
    ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-rustdesk-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
