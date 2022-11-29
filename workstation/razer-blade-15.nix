# Config specific to Razer Blade 15

{ config, pkgs, lib, ... }:

{
  boot.kernelParams = [ "button.lid_init_state=open" ];

  services.xserver = {
    videoDrivers = [ "nouveau" "intel" ];
#    config = 
#    ''
#      # nvidia-settings: X configuration file generated by nvidia-settings
#      # nvidia-settings:  version 515.48.07
#      
#      Section "Monitor"
#          # HorizSync source: edid, VertRefresh source: edid
#          Identifier     "Monitor0"
#          VendorName     "Unknown"
#          ModelName      "DELL U2419H"
#          HorizSync       30.0 - 83.0
#          VertRefresh     56.0 - 76.0
#          Option         "DPMS"
#      EndSection
#      
#      Section "Device"
#          Identifier     "Device0"
#          Driver         "nvidia"
#          VendorName     "NVIDIA Corporation"
#          BoardName      "NVIDIA GeForce RTX 2070 Super with Max-Q Design"
#      EndSection
#      
#      Section "Screen"
#          Identifier     "Screen0"
#          Device         "Device0"
#          Monitor        "Monitor0"
#          DefaultDepth    24
#          Option         "Stereo" "0"
#          Option         "nvidiaXineramaInfoOrder" "DFP-0"
#          Option         "metamodes" "DP-4.1: nvidia-auto-select +0+238, DP-0: 1920x1080 +1920+0"
#          Option         "SLI" "Off"
#          Option         "MultiGPU" "Off"
#          Option         "BaseMosaic" "off"
#          SubSection     "Display"
#              Depth       24
#          EndSubSection
#      EndSection
#
#      Section "Device"
#        Identifier "Intel Graphics"
#        Driver "intel"
#        BusID "PCI:0:2:0"
#      EndSection
#    '';
  };
  hardware.opengl.enable = true;
#  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
#
#  hardware.nvidia = {
#    powerManagement.enable = true;
#    modesetting.enable = true;
#    prime = {
#      sync.enable = true;
#      nvidiaBusId = "PCI:1:0:0";
#      intelBusId = "PCI:0:2:0";
#    };
#  };
}
