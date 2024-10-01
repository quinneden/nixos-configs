# Configuration loaded for all NixOS hosts
{ config, pkgs, lib, stdenv, nur, ... }:

{
  imports = [
    ./roles/virtualization/multiarch.nix
  ];

  # Allow olm for gomuks until issues are resolved
  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];

  # Enable flakes
  nix.extraOptions = ''
    extra-experimental-features = nix-command flakes
  '';
  # Automatically optimize store for better storage
  nix.settings = {
    auto-optimise-store = true;
    trusted-users = [
      "heywoodlh"
    ];
    substituters = [
      "https://nix-community.cachix.org"
      "http://attic.barn-banana.ts.net/nixos"
      "https://heywoodlh-helix.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixos:ZffGHlb0Ng3oXu8cLT9msyOB/datC4r+/K9nImONIec="
      "heywoodlh-helix.cachix.org-1:qHDV95nI/wX9pidAukzMzgeok1415rgjMAXinDsbb7M="
    ];
  };

  environment.systemPackages = with pkgs; [
    gptfdisk
    (pkgs.writeShellScriptBin "nixos-switch" ''
    [[ -d /home/heywoodlh/opt/nixos-configs ]] || ${pkgs.git}/bin/git clone https://github.com/heywoodlh/nixos-configs /home/heywoodlh/opt/nixos-configs
    sudo chown -R heywoodlh /home/heywoodlh/opt/nixos-configs
    sudo ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake /home/heywoodlh/opt/nixos-configs#$(hostname) --impure
    '')
  ];

  # Enable appimage
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Allow non-free applications to be installed
  nixpkgs.config.allowUnfree = true;

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit nur;
    };
    users.heywoodlh = { ... }: {
      home.activation.docker-rootless-context = ''
        if ! ${pkgs.docker-client}/bin/docker context ls | grep -iq rootless
        then
          ${pkgs.docker-client}/bin/docker context create rootless --docker "host=unix:///run/user/1000/docker.sock" &> /dev/null || true
          ${pkgs.docker-client}/bin/docker context use rootless
        fi
      '';
    };
  };
}
