{ config, pkgs, home-manager, nur, vim-configs, ... }:

let
  system = pkgs.system;
in {
  imports = [
    home-manager.nixosModule
    ./roles/sshd.nix
    ./roles/sshd-monitor.nix
    ./roles/squid-client.nix
    ./roles/tailscale.nix
    ./roles/syslog-ng/client.nix
  ];

  home-manager.useGlobalPkgs = true;

  # Import nur as nixpkgs.overlays
  nixpkgs.overlays = [
    nur.overlay
  ];

  # Allow non-free applications to be installed
  nixpkgs.config.allowUnfree = true;

  # So that `nix search` works
  nix.extraOptions = ''
    extra-experimental-features = nix-command flakes
  '';
  # Automatically optimize store for better storage
  nix.settings.auto-optimise-store = true;

  # Packages to install on entire system
  environment.systemPackages = [
    pkgs.ansible
    pkgs.autoPatchelfHook
    pkgs.bind
    pkgs.bitwarden-cli
    pkgs.btrfs-progs
    pkgs.busybox
    pkgs.croc
    pkgs.file
    pkgs.gcc
    pkgs.git
    pkgs.gnumake
    pkgs.gnupg
    pkgs.gptfdisk
    pkgs.htop
    pkgs.jq
    pkgs.nix-index
    pkgs.patchelf
    pkgs.python310
    pkgs.python310Packages.pip
    pkgs.unzip
    vim-configs.defaultPackage.${system}
    pkgs.wireguard-tools
    pkgs.zsh
  ];

  # Enable Docker
  virtualisation = {
    docker.enable = true;
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Define use
  programs.zsh.enable = true;
  users.users.heywoodlh = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/heywoodlh";
    description = "Spencer Heywood";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  # Set home-manager configs for username
  home-manager.users.heywoodlh = { ... }: {
    imports = [
      ../roles/home-manager/linux.nix
      ../roles/home-manager/linux/no-desktop.nix
    ];
  };

  # Allow heywoodlh to run sudo commands without password
  security.sudo.wheelNeedsPassword = false;

  # Disable wait-online service for Network Manager
  systemd.services.NetworkManager-wait-online.enable = false;

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };
}
