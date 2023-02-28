{ pkgs, lib, ... }:

{
  imports = [
    ../nix
  ];

  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxPackages_6_1;

  # Usually not needed because zfs without sync, but let's do it anyway
  boot.cleanTmpDir = true;
  console.earlySetup = true;

  boot.kernel.sysctl = {
    "vm.swappiness" = lib.mkDefault 0;
  };

  services.resolved.enable = true;

  environment.systemPackages = with pkgs; [
    lsof
    htop
    nmap
    vim
    git
    wget
    lm_sensors
    home-manager
    kind
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent.enable = true;

  services.fwupd.enable = true;

  programs.fish = {
    enable = true;
  };

  users.users.maxine = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "dialout" "docker" "plugdev" "cdrom" ];
    uid = 1002;
  };
}
