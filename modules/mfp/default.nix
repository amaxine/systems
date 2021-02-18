{ pkgs, ... }:

{
  # Enable CUPS and relevant drivers
  services.printing = {
    enable = true;
    drivers = [ pkgs.cnijfilter2 ]; # Support for Canon Inkjet printers
  };

  # Wireless printing relies on discovery
  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  # Scanner support
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  # Discovery of network scanners doesn't work otherwise
  users.users.maxine.extraGroups = [ "scanner" ];
}
