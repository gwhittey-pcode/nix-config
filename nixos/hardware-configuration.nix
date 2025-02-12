# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
    ];

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "xhci_pci" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/ca163eb1-c687-4fa3-8fab-53fdbb39a8e7";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/A445-40B5";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/HD/HD1" =
    { device = "/dev/disk/by-label/HD1";
      fsType = "ext4";
    };

  fileSystems."/HD/HD2" =
    { device = "/dev/disk/by-label/HD2";
      fsType = "ext4";
    };

  fileSystems."/HD/HD3" =
    { device = "/dev/disk/by-label/HD3";
      fsType = "ext4";
    };
  fileSystems."/HD/HD4" =
    { device = "/dev/disk/by-label/swap";
      fsType = "ext4";
    };
   swapDevices = [ {
    device = "/HD/HD4/swapfile";
    size = 16*1024;
  } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  #networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.ens18.useDHCP = lib.mkDefault true;
  networking.interfaces.ens18.ipv4.addresses = [ {
    address = "192.168.1.3";
    prefixLength = 24;
  } ];
  networking.defaultGateway = "192.168.1.254";
  networking.nameservers = [ "8.8.8.8" ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
