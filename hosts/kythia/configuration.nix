{ ... }:

let
  thermald-conf = ./thermald-conf.xml;
in
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/base
      ../../modules/graphical
      ../../modules/yubikey
      ../../modules/graphical/prime
      ../../modules/remote-builds/user
    ];

  networking.hostName = "kythia";
  networking.hostId = "81dd80dd";

  boot.loader = {
    systemd-boot = {
      configurationLimit = 10;
      enable = true;
      editor = false;
    };
    timeout = 3;
    efi.canTouchEfiVariables = true;
  };

  boot.initrd.luks.devices = {
    zfsPool = {
      device = "/dev/nvme0n1p5";
    };
    lvm = {
      device = "/dev/nvme0n1p7";
    };
  };

  boot.kernelParams = [ "acpi_rev_override" ];

  services.fstrim.enable = true;
  services.thermald.enable = true;
  services.thermald.configFile = thermald-conf;

  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  };

  hardware.nvidia.modesetting.enable = true;
  services.xserver.displayManager.gdm.nvidiaWayland = true;

  virtualisation.docker.enable = true;

  system.stateVersion = "21.03";

  security.pki.certificateFiles = [ /home/maxine/ca.crt.pem ];
}

