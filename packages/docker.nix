{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";
 imports = [
    ./contriners/jackett.nix
    ./contriners/medusa.nix
    ./contriners/plex.nix
    ./contriners/readarr.nix
    ./contriners/prowlarr.nix
    ./contriners/vpn_transmission.nix
    ./contriners/portainer.nix
    ./contriners/calibre.nix
    ./contriners/komga.nix    
    ./contriners/adguardhome.nix
    ./contriners/radarr.nix
    ./containers/watchtower.nix
    ./contriners/update-containers.nix

    #./contriners/readarr.nix
    #./contriners/jellyseerr.nix
    #./contriners/sonarr.nix
    
  ];
}