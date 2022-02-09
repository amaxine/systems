{ pkgs, ... }:

{
  services.udev.packages = with pkgs; [ 
    yubikey-personalization
    libu2f-host
  ];

  security.pam = {
    u2f = {
      authFile = "/etc/u2f_mappings";
      control = "sufficient";
      cue = true;
    };

    services.sudo = {
      u2fAuth = true;
    };
  };

  services.pcscd.enable = true;
}
