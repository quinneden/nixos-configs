# Remember that this is used for GitHub Actions to test builds
{
  config,
  pkgs,
  lib,
  home-manager,
  nur,
  ...
}:

let
  hostname = "mac-vm";
  username = "heywoodlh";
in
{
  imports = [
    ../roles/defaults.nix
    ../roles/pkgs.nix
    ../roles/yabai.nix
    ../roles/network.nix
    ../../home/darwin/settings.nix
  ];

  # Define user settings
  users.users.${username} = import ../roles/user.nix {
    inherit config;
    inherit pkgs;
  };

  # Set home-manager configs for username
  home-manager.users.${username} = import ../../home/darwin.nix;

  # Extra homebrew packages for this host
  homebrew.brews = [
    "libheif" # For mautrix-imessage
  ];

  # Set hostname
  networking.hostName = "${hostname}";

  system.stateVersion = 4;
}
