{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs.unstable; [
    chromium
    discord
    firefox
    fprintd
    google-chrome
    gparted
    greetd.greetd
    gsettings-desktop-schemas
    gtk-engine-murrine
    gtk_engines
    inkscape
    keybase-gui
    libfprint
    libreoffice
    lxappearance
    mpv
    obs-studio
    paperkey
    pavucontrol
    pinentry-qt
    polkit_gnome
    slack
    spotify
    steam
    steam-run-native
    eidolon
    swayidle
    swaylock
    tilix
    wdisplays
    wl-clipboard
    xwayland
  ];

  programs = {
    light.enable =true;
    steam.enable = true;
    xwayland.enable = true;
  };

  # Screensharing for wayland
  xdg.portal = {
    wlr.enable = true;
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
    gtkUsePortal = true;
  };

  services = {
    dbus.enable = true;
    udev.packages = [ pkgs.gnome.gnome-settings-daemon pkgs.unstable.yubikey-personalization ];
    fprintd.enable = false;
    openssh.enable = true;
    fwupd.enable = true;
    printing.enable = true;

    greetd = {
      enable = true;
      restart = true;
      vt = 2;
      settings = {
        default_session= {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";
        };
      };
    };

    gnome = {
      core-os-services.enable = true;
      core-shell.enable = true;
      core-utilities.enable = true;
      glib-networking.enable = true;
      gnome-keyring.enable = true;
      gnome-settings-daemon.enable = true;
    };

    xserver = {
      enable = true;
      videoDrivers = [ 
        "amdgpu"
        "radeon"
        "nouveau"
        "modesetting"
        "fbdev"
      ];
      layout = "us";
      xkbOptions = "ctrl:swapcaps";
      desktopManager = {
        xterm.enable = false;
      };

      libinput.enable = true;
      displayManager.lightdm.enable = false;
    };

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

