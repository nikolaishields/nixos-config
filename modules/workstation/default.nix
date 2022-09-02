{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs.unstable; [
    age
    age-plugin-yubikey
    blueberry
    chromium
    discord
    eidolon
    firefox
    fprintd
    google-chrome
    gparted
    greetd.greetd
    gsettings-desktop-schemas
    gtk-engine-murrine
    gtk_engines
    opensc
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
    rage
    slack
    spotify
    swayidle
    swaylock
    tilix
    tree
    wdisplays
    wl-clipboard
    xwayland
    yubikey-manager
    yubikey-personalization
    yubikey-personalization-gui
  ];

  security.pam.services.nikolai.gnupg.enable = true;

  programs = {
    light.enable =true;
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
    udev.packages = [ pkgs.gnome.gnome-settings-daemon pkgs.yubikey-personalization ];
    fprintd.enable = false;
    openssh.enable = true;
    fwupd.enable = true;
    printing.enable = true;
    yubikey-agent.enable = true;
    pcscd.enable = true;

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

