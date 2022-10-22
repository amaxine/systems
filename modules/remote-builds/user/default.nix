{ config, pkgs, ... }:

{
  nix = {
    buildMachines = [
      {
        hostName = "remote-build-user@berlin.infra.hormonal.party";
        system = "x86_64-linux";
        maxJobs = 12;
        speedFactor = 2;
        supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" ];
      }
    ];

    distributedBuilds = true;
  };
}
