{ config, lib, pkgs, ... }: 
{
  imports = [
    ../../modules/base
    ../../modules/monitoring
    ../../modules/networking
    ../../modules/workstation
    ../../users/nikolai
    ../../modules/services/docker
    ../../modules/services/libvirt
    ../../modules/services/yubikey
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "theseus";
    hostId = "e7d11eb2";
    dhcpcd.wait = "background";
    dhcpcd.extraConfig = "noarp";
  };

  boot = {
    supportedFilesystems = [ "ext4" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" "v4l2loopback" ];
    kernelParams = [ "mem_sleep_default=deep" "nohibernate" "console=tty1" ];

    extraModulePackages = [ pkgs.linuxPackages_latest.v4l2loopback ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 video_nr=9 card_label="OBS"\n
      options snd-hda-intel model=dell-headset-multi
    '';

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      supportedFilesystems = [ "ext4" ];
      availableKernelModules = [ "xhci_pci" "nvme" "thunderbolt"];
      kernelModules = [ "i915" ];
    };
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      autoOptimiseStore = true;
  };

  time = {
    timeZone = "US/Central";
    hardwareClockInLocalTime = true;
  };

  environment.variables = {
    VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
  };

  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = false;
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
    logitech.wireless.enable = true;
    logitech.wireless.enableGraphical = true;
    video.hidpi.enable = lib.mkDefault true;
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  services = {
    tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_BATTERY = "powersave";
        START_CHARGE_THRESH_BAT0 = 90;
        STOP_CHARGE_THRESH_BAT0 = 97;
        RUNTIME_PM_ON_BAT = "auto";
      };
    };
    
    power-profiles-daemon.enable = false;

  };

  systemd.services.NetworkManager-wait-online.enable = false;

  powerManagement = {
    powertop.enable = true;
  };

  system.stateVersion = "22.05";
}

