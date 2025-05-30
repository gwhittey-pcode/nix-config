# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: 
  
  let
    cockpit-apps = pkgs.callPackage packages/cockpit/default.nix { inherit pkgs; };
  in
  {
  
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    #flatpak handaling
    ./flatpak/flatpak.nix
    ./packages/docker.nix
    ./packages/samba.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # FIXME: Add the rest of your current configuration
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

   # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "gwhittey";
  programs.firefox.enable = true;
   # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  # Allow unfree packages
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
   # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;
  programs.zsh.enable = true;
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # TODO: Set your hostname
  networking.hostName = "gwhit-nixos";

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.groups.gwhittey.gid = 1000;
  users.users = {
    # FIXME: Replace with your username
    gwhittey = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "1872";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "networkmanager" "wheel" "gwhittey" "docker"];
      shell = pkgs.zsh;
    };
  };
   programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [

    # Add any missing dynamic libraries for unpackaged programs

    # here, NOT in environment.systemPackages

  ];

  environment.systemPackages = with pkgs; [
    quickemu
	  git
	  docker-compose
    jellyfin-media-player
    microsoft-edge
    vscode
    parsec-bin
    rustdesk-flutter
    colorls
    git-credential-manager
    meslo-lgs-nf
    compose2nix
    htop
    gh
    kdePackages.partitionmanager
    persepolis
    neofetch
    kdePackages.kalk
    virt-viewer
    unar
    urserver
    heroic
    cifs-utils 
    lazydocker
    cockpit
    # cockpit-apps.podman-containers
    cockpit-apps.virtual-machines
    libvirt # Needed for virtual-machines
    virt-manager # Needed for virtual-machines
    powershell
    szyszka
    unar
    peazip
    
  ];
  nixpkgs.config.permittedInsecurePackages = [
                "archiver-3.5.1"
              ];

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      #PasswordAuthentication = false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
  virtualisation.docker.enable = true;
  services.flatpak.enable = true;
  services.urserver.enable = true;
  services.gvfs.enable = true;
  systemd.tmpfiles.rules = [
  "d /HD/ 0755 gwhittey gwhittey"
  "d /HD/HD1 0755 gwhittey gwhittey"
  "d /HD/HD2 0755 gwhittey gwhittey"
  "d /HD/HD3 0755 gwhittey gwhittey"
  "d /HD/HD4 0755 gwhittey gwhittey"


];

  virtualisation.virtualbox.host.enable = true;   
  users.extraGroups.vboxusers.members = [ "gwhittey" ];
  services.cockpit = {
  enable = true;
  port = 9090;
  # openFirewall = true; # Please see the comments section
  settings = {
    WebService = {
      AllowUnencrypted = true;
    };
  };
};
  
  
  #Need hardware.enableRedistributableFirmware = lib.mkDefault true; for nixos guest to use GPU
  hardware.enableRedistributableFirmware = lib.mkDefault true;


}
