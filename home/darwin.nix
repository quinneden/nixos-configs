{ config, pkgs, home-manager, nur, lib, myFlakes, ... }:

let
  system = pkgs.system;
  homeDir = config.home.homeDirectory;
  myZellij = myFlakes.packages.${system}.zellij;
in {
  imports = [
    ./base.nix
    ./desktop.nix
  ];

  home.file."bin/battpop.sh" = {
    enable = true;
    executable = true;
    text = ''
    '';
  };

  home.packages = [
    pkgs.docker-client
    pkgs.m-cli
    pkgs.mas
    pkgs.pinentry_mac
  ];

  home.shellAliases = {
    ls = "ls --color";
  };

  home.file."Pictures/wallpaper.png" = {
    enable = true;
    source = ../wallpapers/nord-apple.png;
  };

  home.file."bin/choose-launcher.zsh" = {
    text = ''
      #!/run/current-system/sw/bin/zsh
      source ~/.zshrc
      application_dirs=( /Applications /System/Applications /System/Library/CoreServices /System/Applications/Utilities $HOME/Applications )

      ### Simple MacOS application launcher that relies on choose: https://github.com/chipsenkbeil/choose
      ### brew install choose-gui

      if ! command -v choose > /dev/null
      then
      	echo 'Please install choose. Exiting.'
      fi

      selection=$(for dir in ''${application_dirs[@]}; do /bin/ls ''${dir};done | grep ".app" | rev | cut -d/ -f1 | rev | /usr/bin/sort -u | choose)

      open -a "''${selection}"

    '';
    executable = true;
  };

  home.file.".config/iterm2/iterm2-profiles.json" = {
    text = import ./iterm/iterm2-profiles.nix { inherit myZellij; };
  };
  home.file.".config/iterm2/com.googlecode.iterm2.plist" = {
    text = import ./iterm/com.googlecode.iterm2.plist.nix { inherit myZellij; };
  };
  home.file.".config/iterm2/README.md" = {
    source = ./iterm/README.md;
  };

  #1Password config
  home.file.".config/git/config" = {
    text = ''
[user]
  signingkey = ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCYn+7oSNHXN3qqDDidw42Vv7fDS0iEpYqaa0wCXRPBlfWAnD81f6dxj/QPGfZtxpl9jvk7nAKpE7RVUvQiJzUC2VM3Bw/4ucT+xliEHo3oesMQQa1AT70VPTbP5PdU7oUpgQWLq39j9XHno2YPJ/WWtuOl/UTjY6IDokkAmNmvft/jqqkiwSkGMmw68qrLFEM7+rNwJV5cXKvvpB6Gqc7qnbJmk1TZ1MRGW5eLjP9ofDqiyoLbnTm7Dw3iHn40GgTcnv5CWGpa0vrKnnLEGrgRB7kR/pyvfsjapkHz0PDvuinQov+MgJfV8B8PHdPC94dsS0DEWJplxhYojtsYa1VZy5zTEMNWICz1QG1yKHN1JQtpbEreHG6DVYvqwnKvK/XN5yiEeiamhD2oKnSh36PexIR0h0AAPO29Ln+anqpRlqJ0nET2CNS04e0vpV4VDJrG6BnyGUQ6CCo7THSq97F4Ne0nY9fpYu5WTFTCh1tTm+nSey0fP/xk22oINl/41VTI/Vk5pNQuuhHUvQupJHw9cD74aKzRddwvgfuAQjPlEuxxsqgFTltTiPF6lZQNeoMIc1OMCRsnl1xNqIepnb7Q5O1CGq+BqtOWh3G4/SPQI5ZUIkOAZegsnPpGWYMrRd7s6LJn5LrBYaY6IvRxmpGOig3tjOUy3fqk7coyTeJXmQ==

[gpg]
  format = ssh

[gpg "ssh"]
  program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"

[commit]
  gpgsign = true
    '';
  };

  home.activation = {
    aerc-link = ''
      ln -s ${homeDir}/.config/aerc ${homeDir}/Library/Preferences/aerc &>/dev/null || true
    '';
  };

  # Run Lima VM always in background
  heywoodlh.home.lima = {
    enable = true;
    enableDocker = true;
  };

  heywoodlh.home.applications = [
    {
      name = "virt-manager";
      command = "${pkgs.virt-manager}/bin/virt-manager";
    }
    {
      name = "tabby-background-start";
      command = "/Applications/Tabby.app/Contents/MacOS/Tabby --hidden";
    }
  ];

  home.file."Library/Application\ Support/tabby/config.yaml" = {
    enable = true;
    source = ./tabby/config.yaml;
  };

  nix = {
    settings = let
      # only have foreign arch because $(arch)-linux is covered by linux-builder
      myBuilders = if pkgs.system == "aarch64-darwin" then
        "ssh://heywoodlh@macos-intel-vm x86_64-darwin ; ssh://heywoodlh@nix-nvidia x86_64-linux ; ssh://builder@linux-builder aarch64-linux" else
        "ssh://heywoodlh@mac-mini aarch64-darwin ; ssh://heywoodlh@nixos-mac-mini aarch64-linux ; ssh://builder@linux-builder x86_64-linux";
    in {
      # Before you can use these, run the following command:
      # sudo -E ssh heywoodlh@nix-nvidia; sudo -E ssh heywoodlh@nixos-mac-mini; sudo -E ssh heywoodlh@mac-mini; sudo -E ssh heywoodlh@macos-intel-vm
      builders = "${myBuilders}";
    };
  };
}
