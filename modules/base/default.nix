{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.cleanTmpDir = true;
  boot.plymouth.enable = true;
  console.earlySetup = true;

  networking.useDHCP = false;
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    lsof htop nmap vim wget lm_sensors
    home-manager
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent.enable = true;

  nix = {
    binaryCaches = [
      "https://nixcache.infra.terrible.systems/"
    ];
    trustedBinaryCaches = [
      "https://nixcache.infra.terrible.systems/"
    ];
    binaryCachePublicKeys = [
      "nixcache.infra.terrible.systems:BXjTXh35v6pyOf6kjkhd2T2Z1hXrCa4j/64HCwbZ5Mw="
    ];
  };

  services.tlp.enable = true;
  services.fwupd.enable = true;
  hardware.cpu.intel.updateMicrocode = true;

  programs.fish = {
    enable = true;
  };

  users.users.maxine = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "dialout" ];
  };
}