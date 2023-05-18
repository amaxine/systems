{ config, pkgs, ... }:

{
  nix = {
    buildMachines = [
      {
        hostName = "remote-build-user@tsort.infra.hormonal.party";
        system = "aarch64-linux";
        maxJobs = 4;
        speedFactor = 1;
        supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
      }
    ];

    distributedBuilds = true;
  };
}
