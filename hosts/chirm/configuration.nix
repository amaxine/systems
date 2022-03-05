{ pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/default
      ../../modules/graphical
      ../../modules/graphical/steam
      ../../modules/remote-builds/user
      ../../modules/yubikey
      ../../modules/mfp
      ../../modules/vpn
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
    device = "sintra.home.arpa:storage/home/maxine";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "nfsvers=4.2" ];
  };

  fileSystems."/var/lib/docker" = {
    device = "/mnt/docker.img";
    fsType = "ext4";
  };

  boot.kernelParams = [
    "mem_sleep_default=deep"
    "i915.enable_guc=2"
  ];

  services.fstrim.enable = true;
  services.thermald.enable = true;

  virtualisation.docker.enable = true;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  system.stateVersion = "20.03";
}

