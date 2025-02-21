{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";
 imports = [
    ./jackett.nix
    ./medusa.nix
    ./plex.nix
    ./readarr.nix
    ./prowlarr.nix
    ./vpn_transmission.nix
    ./portainer.nix
    ./calibre.nix
    ./komga.nix
    ./readarr.nix
    ./update-containers.nix
    #./adguardhome.nix
    ./radarr.nix
    
  ];
}