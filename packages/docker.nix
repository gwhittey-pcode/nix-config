{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";
 imports = [
    ./docker_contriners/jackett.nix
    ./docker_contriners/medusa.nix
    ./docker_contriners/plex.nix
    ./docker_contriners/readarr.nix
    ./docker_contriners/prowlarr.nix
    ./docker_contriners/vpn_transmission.nix
    ./docker_contriners/portainer.nix
    ./docker_contriners/calibre.nix
    ./docker_contriners/komga.nix
    ./docker_contriners/readarr.nix
    ./docker_contriners/update-containers.nix
    ./docker_contriners/adguardhome.nix
    ./docker_contriners/radarr.nix
    ./docker_contriners/jellyseerr.nix
    #./docker_contriners/sonarr.nix
    
  ];
}