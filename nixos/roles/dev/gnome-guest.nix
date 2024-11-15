# Configuration for a dev VM
{ config, pkgs, ... }:

{
  services.displayManager.autoLogin = {
    enable = true;
    user = "heywoodlh";
  };

  home-manager.users.heywoodlh =
    { ... }:
    {
      imports = [
        ../../../home/roles/gnome-terminal-fullscreen.nix
      ];
      dconf.settings = {
        "org/gnome/desktop/session" = {
          idle-delay = 0;
        };
        "org/gnome/desktop/screensaver" = {
          lock-enabled = false;
        };
      };
    };
}
