{ ... }:

{
  imports =
    [
      <nixos-hardware/dell/xps/13-7390>
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

  system.stateVersion = "20.03";
}

