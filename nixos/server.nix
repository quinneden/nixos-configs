{ config, pkgs, ... }:

{
  imports = [
    ../roles/sshd.nix
  ];
  
  # Allow non-free applications to be installed
  nixpkgs.config.allowUnfree = true;

  # Packages to install on entire system  
  environment.systemPackages = with pkgs; [
    autoPatchelfHook
    git
    bind
    busybox
    file
    gcc
    gnumake
    gnupg 
    jq 
    nix-index
    patchelf
    powershell
    python310 
    python310Packages.pip
    unzip
    vim
    wireguard-tools
  ];

  # Enable Docker 
  virtualisation = {
    docker.enable = true;
  };

  # Define user
  users.users.heywoodlh = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/heywoodlh";
    description = "Spencer Heywood";
    extraGroups = [ "wheel" ];
    shell = pkgs.powershell;
  };
}