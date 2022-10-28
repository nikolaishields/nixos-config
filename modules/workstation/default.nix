{ config, pkgs, ... }:
let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts  
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
      name = "configure-gtk";
      destination = "/bin/configure-gtk";
      executable = true;
      text = let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Dracula'
        '';
  };

in
{
  environment.systemPackages = with pkgs.unstable; [
    age
    age-plugin-yubikey
    blueberry
    chromium
    cinnamon.nemo
    discord
    eidolon
    firefox
    fprintd
    gparted
    greetd.greetd
    gsettings-desktop-schemas
    gtk-engine-murrine
    gtk_engines
    opensc
    inkscape
    libfprint
    libreoffice
    lxappearance
    mpv
    obs-studio
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
    xdg-desktop-portal-wlr
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
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
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

