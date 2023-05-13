{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [
    1080
  ];

  environment.etc."proxy.pac" = {
    text = ''
      function FindProxyForURL(url, host)
      {
      
          // Allow direct connections for LAN traffic 
          if (isPlainHostName(host) ||
              shExpMatch(host, "*.local") ||
              isInNet(dnsResolve(host), "10.0.0.0", "255.0.0.0") ||
              isInNet(dnsResolve(host), "172.16.0.0",  "255.240.0.0") ||
              isInNet(dnsResolve(host), "192.168.0.0",  "255.255.0.0") ||
              isInNet(dnsResolve(host), "127.0.0.0", "255.255.255.0"))
              return "DIRECT";
          
           // Proxy traffic if none of the rules above match
           return "SOCKS 10.64.0.1:1080";
      }
    '';
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      http-proxy-pac = {
        image = "docker.io/httpd:latest";
        autoStart = true;
        ports = ["1080:80"];
        volumes = [
          "/etc/proxy.pac:/usr/local/apache2/htdocs/proxy.pac"
        ];
      };
    };
  };
}