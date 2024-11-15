{ pkgs, ... }:

with pkgs.nur.repos.rycee.firefox-addons;
[
  darkreader
  gnome-shell-integration
  kristofferhagen-nord-theme
  multi-account-containers
  noscript
  onepassword-password-manager
  privacy-badger
  redirector
  ublock-origin
  vimium
]
