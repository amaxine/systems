{ config, pkgs, ... }:

{
  nix = {
    buildMachines = [
      {
        hostName = "ssh://remote-build-user@omnia.fritz.box";
        system = "x86_64-linux";
        maxJobs = 8;
        supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
        mandatoryFeatures = [ ];
      }
    ];

    distributedBuilds = true;
  };
}
