{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/default
      ../../modules/ssh
      ../../modules/vpn
      ../../modules/remote-builds/host
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "tsort";
  networking.hostId = "e5d58ec0";

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "22.11";
}
