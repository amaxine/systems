{ pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/default
      ../../modules/hardware/amd.nix
      ../../modules/graphical
      ../../modules/mfp
      ../../modules/yubikey
      ../../modules/ssh
      ../../modules/remote-builds/host
    ];

  networking.hostName = "morpork";
  networking.hostId = "7ea0d1a3";

  networking.firewall = {
    enable = true;
  };

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

  services.xserver.videoDrivers = [ "amdgpu" ];

  system.stateVersion = "21.05";
}
