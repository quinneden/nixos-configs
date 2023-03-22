{ config, pkgs, ... }:

{
  imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../desktop.nix
    ../../../roles/sshd.nix
    ../../../roles/sshd-monitor.nix
    ../../../roles/xrdp.nix
    ../../../roles/sunshine.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
  ];
  
  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "nix-zalman"; # Define your hostname

  # Allow specific ports over Wireguard
  networking.firewall.interfaces.shadow = {
    allowedTCPPorts = [
      8384 # syncthing
      47990 # sunshine
    ];
  };
  
  # Allow syncthing on all interfaces
  services.syncthing.guiAddress = "0.0.0.0:8384";
  # Enable wireguard
  networking.wg-quick.interfaces = {
    shadow = {
      address = [ "10.51.51.2/24" ];
      privateKeyFile = "/root/wgkey";
      listenPort = 51821;

      peers = [
        {
          publicKey = "iXvsTj8+YvzRwpbTF45/oXC1P8W9f9ns3XMth7ACIAU=";
          allowedIPs = [ "10.50.50.0/24" "10.51.51.0/24" ];
          endpoint = "10.0.50.50:51821";
          persistentKeepalive = 25;
        }
      ];
    };
  };

  # Set your time zone.
  time.timeZone = "America/Denver";
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Set DNS
  networking.nameservers = [ "10.50.50.1" ];
  environment.etc = {
    "resolv.conf".text = "nameserver 10.50.50.1\n";
  };

  # Enable Nvidia driver 
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "heywoodlh";
  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Install exfat package
  environment.systemPackages = with pkgs; [
    btrfs-progs
    gnomeExtensions.no-overview
  ];

  # Mount wd-black
  #fileSystems."/home/heywoodlh/mnt/wd-black" = { 
  #  device = "/dev/disk/by-uuid/f5dacd21-9a46-40c3-9f96-09fe1161f63b";
  #  fsType = "btrfs"; 
  #  options = [ "rw" "relatime" "x-systemd" "mount-timeout=1min" "uid=heywoodlh" ];
  #};

  ## Mount games-ssd
  #fileSystems."/home/heywoodlh/mnt/games-ssd" = { 
  #  device = "/dev/disk/by-uuid/656c682b-8746-4b81-8bdc-3449513c4683";
  #  fsType = "btrfs"; 
  #  options = [ "rw" "relatime" "x-systemd" "mount-timeout=1min" "uid=heywoodlh" ];
  #};

  system.stateVersion = "23.05";
}
