{ config, pkgs, ... }: {


  environment.systemPackages = with pkgs.unstable; [
    chromium
    discord
    firefox
    fprintd
    google-chrome
    gparted
    gsettings-desktop-schemas
    gtk-engine-murrine
    gtk_engines
    inkscape
    keybase-gui
    libfprint
    libreoffice
    mpv
    obs-studio
    paperkey
    pavucontrol
    pinentry-gnome
    pinentry-qt
    slack
    spotify
    steam
    tilix
    xdg-desktop-portal
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs.unstable; [
      kanshi
      mako
      rofi
      swayidle
      swaylock
      waybar
      wdisplays
      wl-clipboard
      wofi
    ];
  };

  # Screensharing for wayland
  xdg.portal.wlr.enable = true;

  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbOptions = "ctrl:swapcaps";
      desktopManager = {
        xterm.enable = false;
      };

      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      desktopManager.gnome.enable = true;
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

