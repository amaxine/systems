{ config, pkgs, ... }:

{
  nix = {
    buildMachines = [
      {
        hostName = "ssh://remote-build-user@omnia.fritz.box";
        system = "x86_64-linux";
        maxJobs = 8;
        speedFactor = 2;
        supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
      }
      {
        hostName = "ssh://remote-build-user@sintra.fritz.box";
        system = "x86_64-linux";
        maxJobs = 24;
        speedFactor = 5;
        supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" ];
      }
      {
        hostName = "ssh://remote-build-user@berlin.infra.hormonal.party";
        system = "x86_64-linux";
        maxJobs = 12;
        speedFactor = 2;
        supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" ];
      }
    ];

    distributedBuilds = true;
  };
}
