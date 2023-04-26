{ config, pkgs, lib, home-manager, ... }:

{
  imports = [
    ./base.nix
    ./firefox/linux.nix
  ];
  # So that `nix search` works
  nix = lib.mkForce {
    package = pkgs.nix;
    extraOptions = '' 
      extra-experimental-features = nix-command flakes
    '';
  };

  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      xkb-options = ["caps:super"];
    };
    "apps/guake/general" = {
      abbreviate-tab-names = false;
      compat-delete = "delete-sequence";
      default-shell = "/home/heywoodlh/.nix-profile/bin/tmux";
      display-n = 0;
      display-tab-names = 0;
      gtk-prefer-dark-theme = true;
      gtk-theme-name = "Adwaita-dark";
      gtk-use-system-default-theme = true;
      hide-tabs-if-one-tab = false;
      history-size = 1000;
      load-guake-yml = true;
      max-tab-name-length = 100;
      mouse-display = true;
      open-tab-cwd = true;
      prompt-on-quit = true;
      quick-open-command-line = "gedit %(file_path)s";
      restore-tabs-notify = false;
      restore-tabs-startup = false;
      save-tabs-when-changed = false;
      schema-version = "3.9.0";
      scroll-keystroke = true;
      start-at-login = true;
      use-default-font = false;
      use-login-shell = false;
      use-popup = false;
      use-scrollbar = true;
      use-trayicon = false;
      window-halignment = 0;
      window-height = 50;
      window-losefocus = false;
      window-refocus = false;
      window-tabbar = false;
      window-width = 100;
    };
    "apps/guake/keybindings/global" = {
      show-hide = "<Primary>grave";
    };
    "apps/guake/keybindings/local" = {
      focus-terminal-left = "<Primary>braceleft";
      focus-terminal-right = "<Primary>braceright";
      split-tab-horizontal = "<Primary>underscore";
      split-tab-vertical = "<Primary>bar";
    };
    "apps/guake/style" = {
      cursor-shape = 1;
    };
    "apps/guake/style/background" = {
      transparency = 82;
    };
    "apps/guake/style/font" = {
      allow-bold = true;
      palette = "#3B3B42425252:#BFBF61616A6A:#A3A3BEBE8C8C:#EBEBCBCB8B8B:#8181A1A1C1C1:#B4B48E8EADAD:#8888C0C0D0D0:#E5E5E9E9F0F0:#4C4C56566A6A:#BFBF61616A6A:#A3A3BEBE8C8C:#EBEBCBCB8B8B:#8181A1A1C1C1:#B4B48E8EADAD:#8F8FBCBCBBBB:#ECECEFEFF4F4:#D8D8DEDEE9E9:#2E2E34344040";
      palette-name = "Nord";
      style = "IosevkaTerm Nerd Font Mono Regular 14";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = ["disabled"];
      enabled-extensions = [
        "native-window-placement@gnome-shell-extensions.gcampax.github.com"
        "pop-shell@system76.com"
        "caffeine@patapon.info"
        "hidetopbar@mathieu.bidon.ca"
        "gsconnect@andyholmes.github.io"
      ];
      favorite-apps = ["firefox.desktop" "alacritty.desktop"];
      had-bluetooth-devices-setup = true;
      remember-mount-password = false;
      welcome-dialog-last-shown-version = "42.4";
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };
    "org/gnome/shell/extensions/hidetopbar" = {
      enable-active-window = false;
      enable-intellihide = false; 
    };
    "org/gnome/desktop/interface" = {
      clock-show-seconds = true;
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      gtk-theme = "Nordic";
      toolkit-accessibility = true;
    };
    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = ["disabled"];
      toggle-message-tray = ["disabled"];
      close = "['<Super>q', '<Alt>F4']";
      maximize = ["disabled"];
      minimize = "['<Super>comma']";
      move-to-monitor-down = ["disabled"];
      move-to-monitor-left = ["disabled"];
      move-to-monitor-right = ["disabled"];
      move-to-monitor-up = ["disabled"];
      move-to-workspace-down = ["disabled"];
      move-to-workspace-up = ["disabled"];
      switch-to-workspace-left = ["<Super>bracketleft"];
      switch-to-workspace-right = ["<Super>bracketright"];
      switch-input-source = ["disabled"];
      switch-input-source-backward = ["disabled"];
      toggle-maximized = ["<Super>Up"];
      unmaximize = ["disabled"];
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close,minimize,maximize:appmenu";
      num-workspaces = 10;
    };
    "org/gnome/shell/extensions/pop-shell" = {
      focus-right = ["disabled"];
      tile-by-default = true;
      tile-enter = ["disabled"];
    };
    "org/gnome/desktop/notifications" = {
      show-in-lock-screen = false;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      next = [ "<Shift><Control>n" ];
      previous = [ "<Shift><Control>p" ];
      play = [ "<Shift><Control>space" ];
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "terminal super";
      command = "alacritty";
      binding = "<Super>Return";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "terminal ctrl_alt";
      command = "alacritty";
      binding = "<Ctrl><Alt>t";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "rofi-rbw";
      command = "rofi-rbw --action copy";
      binding = "<Ctrl><Super>s";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      name = "rofi launcher";
      command = "rofi -theme nord -show run -display-run 'run: '";
      binding = "<Super>space";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
      binding = "<Ctrl><Shift>s";
      command = "scrot /home/heywoodlh/Documents/screenshots/scrot-+%Y-%m-%d_%H_%M_%S.png -s -e 'xclip -selection clipboard -t image/png -i $f'";
      name = "screenshot";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5" = {
      binding = "<Shift><Control>e";
      command = "/home/heywoodlh/bin/vim-ime.py --cmd 'gnome-terminal --geometry=60x8 -- vim' --outfile '/home/heywoodlh/tmp/vim-ime.txt'";
      name = "vim-ime";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6" = {
      binding = "<Shift><Control>b";
      command = "bash -c 'notify-send $(acpi -b | grep -Eo [0-9]+%)'";
      name = "battpop";
    };
  }; 
  # End dconf.settings 

  home.packages = with pkgs; [
    acpi
    alacritty
    appimage-run
    aerc
    ansible
    automake
    awscli2
    bind
    bitwarden-cli
    calcurse
    cargo
    cmake
    coreutils
    curl
    dante
    docker-client
    docker-compose
    gnome.dconf-editor
    go
    ffmpeg
    file
    fzf
    gcc
    git
    github-cli
    gitleaks
    glib.dev
    glow
    gnome.gnome-terminal
    gnome.gnome-tweaks
    gnomeExtensions.caffeine
    gnomeExtensions.gsconnect
    gnomeExtensions.hide-top-bar
    gnomeExtensions.pop-shell
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.zilence
    gnumake
    gnupg
    go
    gomuks
    gotify-cli
    gotify-desktop
    guake
    htop
    hyper
    inotify-tools
    jq
    k9s
    keyutils
    kind
    kubectl
    kubernetes-helm
    libarchive
    libnotify
    lima
    matrix-commander
    moreutils
    nixfmt
    nixos-generators
    nixos-install-tools
    nodejs
    nodePackages.cspell
    lefthook
    mosh
    neovim
    nim
    nordic
    olm
    openssl
    pandoc
    pciutils
    pinentry-gnome
    pinentry-rofi
    plexamp
    pomerium-cli
    powershell
    procmail
    pwgen
    python310
    qemu-utils
    rbw
    rofi
    rofi-rbw
    scrot
    slack
    tcpdump
    terraform-docs
    texlive.combined.scheme-full
    tmux
    tree
    unzip
    uxplay
    virt-manager
    vultr-cli
    w3m
    wireguard-tools
    xautomation
    xclip
    xdotool
    zip
    zoom-us
    zsh
  ];

  home.file.".config/rofi/config.rasi" = {
    text = ''
      configuration {
          font: "JetBrainsMono Nerd Font Mono 16";
          line-margin: 10;
      
          display-ssh:    "";
          display-run:    "";
          display-drun:   "";
          display-window: "";
          display-combi:  "";
          show-icons:     true;
      }
      
      @theme "~/.config/rofi/nord.rasi"
      
      listview {
      	lines: 6;
      	columns: 2;
      }
      
      window {
      	width: 30%;
      }
    ''; 
  };
  home.file.".config/rofi/nord.rasi" = {
    text = ''
      /**
       * Nordic rofi theme
       * Adapted by undiabler <undiabler@gmail.com>
       *
       * Nord Color palette imported from https://www.nordtheme.com/
       *
       */
      
      
      * {
      	nord0: #2e3440;
      	nord1: #3b4252;
      	nord2: #434c5e;
      	nord3: #4c566a;
      
      	nord4: #d8dee9;
      	nord5: #e5e9f0;
      	nord6: #eceff4;
      
      	nord7: #8fbcbb;
      	nord8: #88c0d0;
      	nord9: #81a1c1;
      	nord10: #5e81ac;
      	nord11: #bf616a;
      
      	nord12: #d08770;
      	nord13: #ebcb8b;
      	nord14: #a3be8c;
      	nord15: #b48ead;
      
          foreground:  @nord9;
          backlight:   #ccffeedd;
          background-color:  transparent;
          
          highlight:     underline bold #eceff4;
      
          transparent: rgba(46,52,64,0);
      }
      
      window {
          location: center;
          anchor:   center;
          transparency: "screenshot";
          padding: 10px;
          border:  0px;
          border-radius: 6px;
      
          background-color: @transparent;
          spacing: 0;
          children:  [mainbox];
          orientation: horizontal;
      }
      
      mainbox {
          spacing: 0;
          children: [ inputbar, message, listview ];
      }
      
      message {
          color: @nord0;
          padding: 5;
          border-color: @foreground;
          border:  0px 2px 2px 2px;
          background-color: @nord7;
      }
      
      inputbar {
          color: @nord6;
          padding: 11px;
          background-color: #3b4252;
      
          border: 1px;
          border-radius:  6px 6px 0px 0px;
          border-color: @nord10;
      }
      
      entry, prompt, case-indicator {
          text-font: inherit;
          text-color:inherit;
      }
      
      prompt {
          margin: 0px 1em 0em 0em ;
      }
      
      listview {
          padding: 8px;
          border-radius: 0px 0px 6px 6px;
          border-color: @nord10;
          border: 0px 1px 1px 1px;
          background-color: rgba(46,52,64,0.9);
          dynamic: false;
      }
      
      element {
          padding: 3px;
          vertical-align: 0.5;
          border-radius: 4px;
          background-color: transparent;
          color: @foreground;
          text-color: rgb(216, 222, 233);
      }
      
      element selected.normal {
      	background-color: @nord7;
      	text-color: #2e3440;
      }
      
      element-text, element-icon {
          background-color: inherit;
          text-color:       inherit;
      }
      
      button {
          padding: 6px;
          color: @foreground;
          horizontal-align: 0.5;
      
          border: 2px 0px 2px 2px;
          border-radius: 4px 0px 0px 4px;
          border-color: @foreground;
      }
      
      button selected normal {
          border: 2px 0px 2px 2px;
          border-color: @foreground;
      }
    '';
  };
  home.file.".config/rbw/config.json" = {
    text = ''
      {
        "email": "l.spencer.heywood@protonmail.com",
        "base_url": null,
        "identity_url": null,
        "lock_timeout": 3600,
        "pinentry": "pinentry-gnome3",
        "client_cert_path": null
      }
    '';
  };

  programs.zsh = {
    initExtra = ''
      # Linux specific config 
      if [[ $(uname) == 'Linux' ]]
      then
        alias pbcopy='xclip -selection clipboard'
  
        function toon {
          echo -n ""
        }
  
        #NixOS specific config
        if grep -q 'ID=nixos' /etc/os-release
        then
          alias sudo="/run/wrappers/bin/sudo $@"
          function nixos-switch {
            git -C ~/opt/nixos-configs pull origin master
            /run/wrappers/bin/sudo nixos-rebuild switch --flake ~/opt/nixos-configs#$(hostname) --impure
          }
        # All other Linux distros managed with Nix
        else
          function home-switch {
            git -C ~/opt/nixos-configs pull origin master
            nix run ~/opt/nixos-configs#homeConfigurations.$(whoami).activationPackage --impure
          } 
        fi
      fi
    '';
  };
  
  home.file.".zshenv".text = lib.mkForce ''
    [[ -e $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]] && . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" 

    # Only source this once
    if [[ -z "$__HM_ZSH_SESS_VARS_SOURCED" ]]
    then
      export __HM_ZSH_SESS_VARS_SOURCED=1
    fi
    
    ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh";
    ZSH_CACHE_DIR="/var/empty/.cache/oh-my-zsh";
  '';
}
