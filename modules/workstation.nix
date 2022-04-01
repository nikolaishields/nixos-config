{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs.unstable; [
    chromium
    discord
    firefox
    fprintd
    pinentry-gnome
    keybase-gui
    google-chrome
    gparted
    gsettings-desktop-schemas
    gtk-engine-murrine
    gtk_engines
    inkscape
    libfprint
    libreoffice
    mpv
    obs-studio
    pavucontrol
    slack
    spotify
    steam
#    steamPackages.steam
#    steamPackages.steamcmd
#    steamPackages.steam-runtime-wrapped
    tilix
    xdg-desktop-portal
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    paperkey
    pinentry-qt
  ];

  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbOptions = "ctrl:swapcaps";
      desktopManager = {
        xterm.enable = false;
      };

      displayManager = {
        defaultSession = "none+i3";
        gdm = {
          enable = true;
          wayland = true;
        };
      };

      windowManager = {
        i3.enable = true;
      };

      libinput.enable = true;
    };


    dbus.packages = [ pkgs.gnome.dconf ];

    udev.packages = [ pkgs.gnome.gnome-settings-daemon pkgs.unstable.yubikey-personalization ];

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
}

