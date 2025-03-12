{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";
 imports = [
    ./containers/jackett.nix
    ./containers/medusa.nix
    ./containers/plex.nix
    ./containers/readarr.nix
    ./containers/prowlarr.nix
    ./containers/vpn_transmission.nix
    ./containers/portainer.nix
    ./containers/calibre.nix
    ./containers/komga.nix    
    ./containers/adguardhome.nix
    ./containers/radarr.nix
    ./containers/watchtower.nix
    ./containers/update-containers.nix
     ./containers/flaresolverr.nix
    #./containers/readarr.nix
    #./containers/jellyseerr.nix
    #./containers/sonarr.nix
    
  ];
}