{ config, ... }:

{
  #homebrew packages
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    onActivation.cleanup = "zap";
    brews = [
      "ansible"
      "aerc"
      "argocd"
      "aria2"
      "awscli"
      "bandit"
      "bash"
      "buildkit"
      "browserpass"
      "bitwarden-cli"
      "choose-gui"
      "clamav"
      "cliclick"
      "coreutils"
      "croc"
      "curl"
      "dante"
      "dos2unix"
      "ffmpeg"
      "findutils"
      "fzf"
      "gcc"
      "gitleaks"
      "glib"
      "glow"
      "gnupg"
      "gnu-sed"
      "gh"
      "git"
      "go"
      "gomuks"
      "harfbuzz"
      "helm"
      "htop"
      "jailkit"
      "jq"
      "jwt-cli"
      "k9s"
      "kdash"
      "kind"
      "kompose"
      "kubectl"
      "lefthook"
      "libolm"
      "lima"
      "m-cli"
      "mas"
      "moreutils"
      "mosh"
      "neofetch"
      "neovim"
      "nim"
      "node"
      "openssl@3"
      "pandoc"
      "pass"
      "pass-otp"
      "pinentry-mac"
      "popeye"
      "pre-commit"
      "pwgen"
      "python"
      "rbw"
      "ripgrep"
      "screen"
      "speedtest-cli"
      "tarsnap"
      "tcpdump"
      "tfenv"
      "tmux"
      "tor"
      "torsocks"
      "tree"
      "vim"
      "vultr-cli"
      "watch"
      "w3m"
      "weechat"
      "wireguard-go"
      "wireguard-tools"
      "zsh"
    ];
    extraConfig = ''
      cask_args appdir: "~/Applications"
    '';
    taps = [
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/core"
      "homebrew/services"
      "vultr/vultr-cli"
      "amar1729/formulae"
      "derailed/k9s"
      "derailed/popeye"
      "colindean/fonts-nonfree"
      "kidonng/malt"
      "mike-engel/jwt-cli"
      "aaronraimist/homebrew-tap"
      "kdash-rs/kdash"
    ];
    casks = [
      "alacritty"
      "bitwarden"
      "blockblock"
      "brave-browser"
      "caffeine"
      "cursorcerer"
      "element"
      "docker"
      "firefox"
      "font-droid-sans-mono-for-powerline"
      "font-iosevka-nerd-font"
      "font-jetbrains-mono-nerd-font"
      "font-microsoft-office"
      "hiddenbar"
      "hyper"
      "knockknock"
      "lastpass"
      "lulu"
      "microsoft-remote-desktop"
      "microsoft-teams"
      "oversight"
      "plexamp"
      "powershell"
      "raycast"
      "reikey"
      "rustdesk"
      "secretive"
      "slack"
      "syncthing"
      "tailscale"
      "tunnelblick"
      "utm"
    ];
    #masApps = {
      #DaisyDisk = 411643860;
      #Vimari = 1480933944;
      #"WiFi Explorer" = 494803304;
      #"Reeder 5." = 1529448980;
      #"Okta Extension App" = 1439967473;
    #};
  };
}
