{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    libfprint
    fprintd
    xdg-desktop-portal
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    pavucontrol
    gnome.gnome-shell
    gnome.gnome-tweaks
    gnome.pomodoro
    gnomeExtensions.appindicator
    gnomeExtensions.gtile
    gnomeExtensions.spotify-tray
    gnomeExtensions.vitals
    gnomeExtensions.sound-output-device-chooser
    gsettings-desktop-schemas
    gtk-engine-murrine
    gtk_engines
  ];

  services = {
    xserver = {
      enable = true;
      layout = "us";
      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = false;
      desktopManager.gnome.enable = true;
    };

    dbus.packages = [ pkgs.gnome.dconf ];

    udev.packages = [ pkgs.gnome.gnome-settings-daemon ];

    # Swap Caps Lock to CTRL/ESC
    interception-tools.enable = true;

    fprintd.enable = true;

    openssh.enable = true;

    fwupd.enable = true;

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      socketActivation = true;
    };
  };

  programs = {
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}

