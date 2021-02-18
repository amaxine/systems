{ pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/base
      ../../modules/graphical
      ../../modules/graphical/steam
      ../../modules/remote-builds/user
      ../../modules/yubikey
      ../../modules/mfp
    ];

  networking.hostName = "chirm";
  networking.hostId = "c53a6417";

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 9309 ];
    allowedUDPPorts = [ 9309 ];
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

  fileSystems."/home/maxine/NAS" = {
    device = "192.168.178.105:spool/home/maxine";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto"];
  };

  boot.kernelParams = [ "mem_sleep_default=deep" ];

  services.fstrim.enable = true;
  services.thermald.enable = true;

  virtualisation.docker.enable = true;

  system.stateVersion = "20.03";
}

