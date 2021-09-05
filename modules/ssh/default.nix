{ ... }:

{
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
    extraConfig = "StreamLocalBindUnlink yes";
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

  users.users.maxine = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKDmex7rvB7BFd9OxQHfgqKogiN69kHvixCzWWEGh5oY maxine@chirm"
    ];
  };
}
