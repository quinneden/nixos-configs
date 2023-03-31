{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services.pomerium = {
    enable = true;
    configFile = /services/pomerium/config.yaml;
  };
}
