{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [
    8182
    9000
  ];

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      tabby = {
        image = "ghcr.io/eugeny/tabby-web:latest";
        ports = ["10.50.50.31:8080:80"];
        environmentFiles = [
          /opt/tabby/tabby-web-env
        ];
        volumes = [
          "/opt/tabby/distros:/app-dist"
          "/opt/tabby/db:/db"
        ];
        dependsOn = [
          "tabby-connection-gateway"
        ];
      };
      tabby-connection-gateway = {
        image = "ghcr.io/eugeny/tabby-connection-gateway:master";
        ports = ["9000:9000"];
        cmd = [
          "--token-auth"
          "--host"
          "0.0.0.0"
          "--port"
          "9000"
        ];
        environmentFiles = [
          /opt/tabby/tabby-connection-gateway-env
        ];
      };
    };
  };
}