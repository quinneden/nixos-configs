{
  config,
  pkgs,
  spicetify,
  hyprland,
  ...
}:

let
  hostname = "nixos-macbook";
in
{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ../../roles/nixos/asahi.nix
    ../../desktop.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "${hostname}"; # Define your hostname

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Configuration for this machine
  services.xserver.displayManager.defaultSession = "hyprland";
  environment.systemPackages = with pkgs; [
    signal-desktop
    webcord
  ];

  system.stateVersion = "23.11";
}
