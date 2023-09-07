{ config, pkgs, ... }:

{
  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [
    8082
  ];

  services.ntfy-sh = {
    enable = true;
    settings = {
      listen-http = ":8082";
    };
  };
}
