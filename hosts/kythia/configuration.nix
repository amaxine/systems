{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/base
      ../../modules/graphical
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

  boot.kernelParams = [ "mem_sleep_default=deep" ];

  services.fstrim.enable = true;
  services.thermald.enable = true;

  virtualisation.docker.enable = true;

  system.stateVersion = "21.03";
}

