{ config, pkgs, ... }:

{
  boot.plymouth.enable = true;

  sound.enable = false;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  networking.useDHCP = false;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  hardware.keyboard.zsa.enable = true;

  services.xserver = {
    enable = true;
    xkbOptions = "euroesign:e, caps:ctrl_modifier";
  };

  security.rtkit.enable = true;

  console.useXkbConfig = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnome.gnome-tweaks
    gnome.gnome-terminal
    yaru-theme
    wally-cli
  ];

  services.xserver.libinput.enable = true;
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.peripherals.touchpad]
    tap-to-click=true
    two-finger-scrolling-enabled=true

    [org.gnome.desktop.interface]
    clock-show-weekday=true
    show-battery-percentage=true
    cursor-theme='Yaru'
    gtk-theme='Yaru'
    icon-theme='Yaru'

    [org.gnome.desktop.input-sources]
    xkb-options=['caps:ctrl_modifier']
  '';

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs.gnome; [
    cheese epiphany geary gnome-weather gnome-music
    gnome-software yelp rygel sushi gnome-online-miners
    gnome-remote-desktop gnome-contacts evolution-data-server
    gnome-maps
  ];

  qt5 = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita";
  };

  environment.variables.QT_QPA_PLATFORM = "wayland";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs._1password = {
    enable = true;
  };

  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "maxine" ];
    package = pkgs._1password-gui-beta;
  };
}
