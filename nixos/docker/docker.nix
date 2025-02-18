{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";
 imports = [
    ./media_stack.nix
    ./vpn_transmission.nix
    ./portainer.nix
   # ./calibre.nix
   # ./komga.nix
   # ./rustdesk.nix
      ./komga.nix
    ./update-containers.nix
    ./readarr.nix
 ];
}