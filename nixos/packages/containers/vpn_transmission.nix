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
  virtualisation.oci-containers.containers."transmission_glutun" = {
    image = "lscr.io/linuxserver/transmission:latest";
    environment = {
      "PGID" = "1001";
      "PUID" = "1000";
      "WEBPROXY_ENABLED" = "false";
    };
    volumes = [
      "/HD/HD2/Config/Transmission/:/config:rw"
      "/HD/HD2/Torrent:/data:rw"
    ];
    labels = {
      "autoheal-app" = "true";
    };
    dependsOn = [
      "vpn_glutune"
    ];
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=curl -sf https://example.com  || exit 1"
      "--health-interval=1m0s"
      "--health-retries=1"
      "--health-timeout=10s"
      "--network=container:vpn_glutune"
    ];
  };
  systemd.services."docker-transmission_glutun" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "no";
    };
    partOf = [
      "docker-compose-vpn_transmission-root.target"
    ];
    wantedBy = [
      "docker-compose-vpn_transmission-root.target"
    ];
  };
  virtualisation.oci-containers.containers."vpn_glutune" = {
    image = "qmcgaw/gluetun";
    environment = {
      "VPN_SERVICE_PROVIDER" = "custom";
      "VPN_TYPE" = "wireguard";
      "WIREGUARD_ADDRESSES" = "10.100.132.179/32";
      "WIREGUARD_ENDPOINT_IP" = "204.187.100.82";
      "WIREGUARD_ENDPOINT_PORT" = "15254";
      "WIREGUARD_PRESHARED_KEY" = "34c3RvS0Ezvg+6D9uRVL4XgQqGk9uNMdu2m638KMp6M=";
      "WIREGUARD_PRIVATE_KEY" = "yGW/hFcAciZMn59CcDKNxYH9iLoB7TzKgRfi+EltCn0=";
      "WIREGUARD_PUBLIC_KEY" = "0JqkYQqIPJ1OLmQKdISA+uvOMoFS3f55GjwD8zTJSGU=";
    };
    ports = [
      "192.168.1.3:9091:9091/tcp"
      "192.168.1.3:51413:51413/tcp"
      "192.168.1.3:51413:51413/udp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--cap-add=NET_ADMIN"
      "--device=/dev/net/tun:/dev/net/tun:rwm"
      "--network-alias=gluetun"
      "--network=vpn_transmission_default"
    ];
  };
  systemd.services."docker-vpn_glutune" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-vpn_transmission_default.service"
    ];
    requires = [
      "docker-network-vpn_transmission_default.service"
    ];
    partOf = [
      "docker-compose-vpn_transmission-root.target"
    ];
    wantedBy = [
      "docker-compose-vpn_transmission-root.target"
    ];
  };
  # virtualisation.oci-containers.containers."vpn_transmission-autoheal" = {
  #   image = "willfarrell/autoheal:latest";
  #   environment = {
  #     "AUTOHEAL_CONTAINER_LABEL" = "autoheal-app";
  #   };
  #   volumes = [
  #     "/etc/localtime:/etc/localtime:ro"
  #     "/var/run/docker.sock:/var/run/docker.sock:rw"
  #   ];
  #   log-driver = "journald";
  #   extraOptions = [
  #     "--network=none"
  #   ];
  # };
  # systemd.services."docker-vpn_transmission-autoheal" = {
  #   serviceConfig = {
  #     Restart = lib.mkOverride 90 "always";
  #     RestartMaxDelaySec = lib.mkOverride 90 "1m";
  #     RestartSec = lib.mkOverride 90 "100ms";
  #     RestartSteps = lib.mkOverride 90 9;
  #   };
  #   partOf = [
  #     "docker-compose-vpn_transmission-root.target"
  #   ];
  #   wantedBy = [
  #     "docker-compose-vpn_transmission-root.target"
  #   ];
  # };

  # Networks
  systemd.services."docker-network-vpn_transmission_default" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f vpn_transmission_default";
    };
    script = ''
      docker network inspect vpn_transmission_default || docker network create vpn_transmission_default
    '';
    partOf = [ "docker-compose-vpn_transmission-root.target" ];
    wantedBy = [ "docker-compose-vpn_transmission-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-vpn_transmission-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
