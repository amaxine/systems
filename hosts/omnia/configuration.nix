{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/base
      ../../modules/remote-builds/host
      ../../modules/ssh
    ];

  networking.hostName = "omnia";
  networking.hostId = "080f5139";

  boot.loader = {
    systemd-boot = {
      configurationLimit = 10;
      enable = true;
      editor = false;
    };
    timeout = 3;
    efi.canTouchEfiVariables = true;
  };

  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  time.timeZone = "UTC";

  virtualisation.docker.enable = true;

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "20.09";
}

