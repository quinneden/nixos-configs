# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./custom.nix
      <home-manager/nixos> 
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-a600cf6f-b6a7-4e9c-a20b-d370b524f907".device = "/dev/disk/by-uuid/a600cf6f-b6a7-4e9c-a20b-d370b524f907";
  boot.initrd.luks.devices."luks-a600cf6f-b6a7-4e9c-a20b-d370b524f907".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "nix-xps"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = false;
  services.xserver.desktopManager.gnome = {
    enable = true;
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.heywoodlh = {
    isNormalUser = true;
    description = "Spencer Heywood";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.powershell;
    packages = with pkgs; [
      aerc
      ansible
      automake
      awscli2
      bind
      bitwarden
      bitwarden-cli
      cider
      coreutils
      curl
      file
      firefox
      fzf
      gcc
      git
      gitleaks
      glib.dev
      gnomeExtensions.caffeine
      gnomeExtensions.myhiddentopbar
      gnomeExtensions.pop-shell
      gnumake
      gnupg
      guake
      jq
      k9s
      keyutils
      kubectl
      pass 
      (pass.withExtensions (ext: with ext; 
      [ 
        pass-otp 
      ])) 
      kitty
      lefthook
      mosh
      nordic
      peru
      pinentry-gnome
      powershell
      qemu-utils
      rbw
      rofi
      rofi-rbw
      slack
      teams
      thunderbird
      tmux
      vim
      wireguard-tools
      xclip
      xdotool
      zoom-us
    ];
  };

  services = {
    syncthing = {
      enable = true;
      user = "heywoodlh";
      dataDir = "/home/heywoodlh/Sync";
      configDir = "/home/heywoodlh/.config/syncthing";
    };
    unclutter = {
      enable = true;
      timeout = 10;
    };
    gnome = {
      chrome-gnome-shell.enable = true;
      evolution-data-server.enable = true;
    };
  };

  virtualisation = {
    docker.rootless = {
      enable = true;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  # So that `nix search` works
  nix.extraOptions = '' 
    extra-experimental-features = nix-command flakes
  '';

  networking.firewall.enable = true;
  system.stateVersion = "22.05";


  ## This is a home-manager setting
  home-manager.users.heywoodlh = {
    # Define custom keyboard shortcuts in GNOME 40
    dconf.settings =
      let
        inherit (builtins) length head tail listToAttrs genList;
        range = a: b: if a < b then [a] ++ range (a+1) b else [];
        globalPath = "org/gnome/settings-daemon/plugins/media-keys";
        path = "${globalPath}/custom-keybindings";
        mkPath = id: "${globalPath}/custom${toString id}";
        isEmpty = list: length list == 0;
        mkSettings = settings:
          let
            checkSettings = { name, command, binding }@this: this;
            aux = i: list:
              if isEmpty list then [] else
                let
                  hd = head list;
                  tl = tail list;
                  name = mkPath i;
                in
                  aux (i+1) tl ++ [ {
                    name = mkPath i;
                    value = checkSettings hd;
                  } ];
            settingsList = (aux 0 settings);
          in
            listToAttrs (settingsList ++ [
              {
                name = globalPath;
                value = {
                  custom-keybindings = genList (i: "/${mkPath i}/") (length settingsList);
                };
              }
            ]);
      in
        mkSettings [
          {
            name = "rofi launcher";
            command = "rofi -theme nord -show run -display-run 'run: '";
            binding = "<Super>space";
          }
          {
            name = "kitty super";
            command = "kitty -e tmux";
            binding = "<Super>Enter";
          }
          {
            name = "kitty super";
            command = "kitty -e tmux";
            binding = "<Ctrl><Alt>t";
          }
          {
            name = "rofi-rbw";
            command = "rofi-rbw";
            binding = "<Ctrl><Super>s";
          }
        ];
  };
}
