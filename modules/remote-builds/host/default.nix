{ ... }:

{
  users.users.remote-build-user = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHUSa0uFUgoaes/Z95LoijexaKfU9XeMB8GdQkvojWCj root@chirm"
    ];
  };

  nix.trustedUsers = [ "remote-build-user" ];
}
