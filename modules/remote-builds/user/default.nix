{ config, pkgs, ... }:

{
  nix = {
    buildMachines = [
    ];

    distributedBuilds = true;
  };
}
