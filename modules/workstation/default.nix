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
    pinentry-qt
    slack
    spotify
    steam
    tilix
    greetd.greetd
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs.unstable; [
      swayidle
      swaylock
      wdisplays
      wl-clipboard
    ];
  };

  # Screensharing for wayland
  xdg.portal = {
    wlr.enable = true;
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
    gtkUsePortal = true;
  };

   services = {
     greetd = {
      enable = true;
      settings = {
        default_session= {
          command = "${pkgs.unstable.greetd.greetd}/bin/agreety --cmd sway";
        };
      };
    };

    gnome = {
      gnome-keyring.enable = true;
      core-utilities.enable = true;
      core-shell.enable = true;
      core-os-services.enable = true;
      glib-networking.enable = true;
      gnome-settings-daemon.enable = true;
    };

    xserver = {
      enable = true;
      layout = "us";
      xkbOptions = "ctrl:swapcaps";
      desktopManager = {
        xterm.enable = false;
      };

      libinput.enable = true;
    };

    dbus.enable = true;

    udev.packages = [ pkgs.gnome.gnome-settings-daemon pkgs.unstable.yubikey-personalization ];

    fprintd.enable = false;

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

