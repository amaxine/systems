{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/base
      ../../modules/graphical
    ];

  networking.hostName = "chirm";
  networking.hostId = "c53a6417";

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
      device = "/dev/nvme0n1p1";
    };
    swap = {
      device = "/dev/nvme0n1p2";
    };
  };

  boot.kernelParams = [ "mem_sleep_default=deep" ];

  services.fstrim.enable = true;
  services.thermald.enable = true;

  virtualisation.docker.enable = true;

  system.stateVersion = "20.03";
}

