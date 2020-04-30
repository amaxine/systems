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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    zfsPool = {
      device = "/dev/nvme0n1p1";
    };
    swap = {
      device = "/dev/nvme0n1p2";
    };
  };

  services.fstrim.enable = true;
  services.fwupd.enable = true;
  services.thermald.enable = true;
  boot.kernelParams = [ "mem_sleep_default=deep" ];

  system.stateVersion = "20.03";
}

