{ config, lib, ... }:

{
  nix = {
    settings = {
      sandbox = true;
      trusted-users = [ "@wheel" ];
      auto-optimise-store = true;

      experimental-features = [
        "nix-command"
      ];

      substituters = [
        "https://nixcache.infra.terrible.systems/"
      ];
      trusted-substituters = [
        "https://nixcache.infra.terrible.systems/"
      ];
      trusted-public-keys = [
        "nixcache.infra.terrible.systems:BXjTXh35v6pyOf6kjkhd2T2Z1hXrCa4j/64HCwbZ5Mw="
      ];
    };

    nixPath = [
      "nixos-config=/run/current-system/systems/hosts/${config.networking.hostName}/configuration.nix"
      "/var/run/current-system/systems"
    ];
  };

  system.extraSystemBuilderCmds = ''
    ln -s ${lib.cleanSource ../..} $out/systems
  '';
}
