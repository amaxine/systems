{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/base
      ../../modules/remote-builds/host
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

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  users.users.maxine = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKDmex7rvB7BFd9OxQHfgqKogiN69kHvixCzWWEGh5oY maxine@chirm"
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "20.09";
}

