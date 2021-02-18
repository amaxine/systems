{ config, pkgs, ... }:

let
  maxine = import <nixpkgs-maxine> { };
in
{
  boot.plymouth.enable = true;

  services.tlp.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.keyboard.zsa.enable = true;

  services.xserver = {
    enable = true;
    xkbOptions = "euroesign:e, caps:ctrl_modifier";
  };

  console.useXkbConfig = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnome3.gnome-tweaks
    yaru-theme
    maxine.gnomeExtensions.no-title-bar
    wally-cli
  ];

  services.xserver.libinput.enable = true;
  services.xserver.desktopManager.gnome3.extraGSettingsOverrides = ''
    [org.gnome.desktop.peripherals.touchpad]
    tap-to-click=true
    two-finger-scrolling-enabled=true

    [org.gnome.shell]
    enabled-extensions=['dash-to-dock@micxgx.gmail.com', 'no-title-bar@jonaspoehler.de', 'appindicatorsupport@rgcjonas.gmail.com]

    [org.gnome.desktop.interface]
    clock-show-weekday=true
    show-battery-percentage=true
    cursor-theme='Yaru'
    gtk-theme='Yaru'
    icon-theme='Yaru'

    [org.gnome.desktop.wm.preferences]
    button-layout='close,minimize,maximize:appmenu'

    [org.gnome.shell.extensions.dash-to-dock]
    animate-show-apps=false
    apply-custom-theme=false
    click-action='previews'
    custom-background-color=false
    custom-theme-customize-running-dots=true
    custom-theme-running-dots-border-color='#f57900'
    custom-theme-running-dots-color='#fcaf3e'
    custom-theme-shrink=true
    dash-max-icon-size=32
    dock-fixed=true
    extend-height=true
    running-indicator-style='DASHES'
    show-mounts=false
    show-trash=false
    transparency-mode='DYNAMIC'

    [org.gnome.desktop.input-sources]
    xkb-options=['caps:ctrl_modifier']
  '';

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;

  services.gnome3.tracker-miners.enable = false;
  services.gnome3.tracker.enable = false;

  environment.gnome3.excludePackages = with pkgs.gnome3; [
    cheese epiphany geary gnome-weather gnome-music gnome-photos
    gnome-software yelp rygel sushi gnome-online-miners
    gnome-remote-desktop gnome-contacts evolution-data-server
    gnome-maps
  ];
}
