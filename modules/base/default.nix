{ pkgs, lib, config, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.cleanTmpDir = true;
  boot.plymouth.enable = true;
  console.earlySetup = true;

  boot.kernel.sysctl = {
    "vm.swappiness" = lib.mkDefault 0;
  };

  networking.useDHCP = false;
  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    lsof htop nmap vim wget lm_sensors
    home-manager
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent.enable = true;

  nix = {
    nixPath = [
      "nixos-config=/run/current-system/systems/hosts/${config.networking.hostName}/configuration.nix"
      "/var/run/current-system/systems" "nixpkgs-maxine=/home/maxine/Development/maxeaubrey/nixpkgs-maxine"
    ];
    useSandbox = true;
    autoOptimiseStore = true;
    trustedUsers = [ "@wheel" ];

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

  system.extraSystemBuilderCmds = ''
    ln -s ${lib.cleanSource ../..} $out/systems
  '';

  services.tlp.enable = true;
  services.fwupd.enable = true;
  hardware.cpu.intel.updateMicrocode = true;

  programs.fish = {
    enable = true;
  };

  users.users.maxine = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "dialout" "docker" ];
  };
}
