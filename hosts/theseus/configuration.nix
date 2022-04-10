{ config, lib, pkgs, ... }: 
let 
  unstableTarball = fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  impermanence = builtins.fetchGit { 
    url = "https://github.com/nix-community/impermanence.git";
    ref = "master";
  };

in {
  imports = [
    (import "${impermanence}/nixos.nix")
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

  boot = {
    # TODO: ephemeral root
    #  boot.initrd.postDeviceCommands = "zfs rollback -r rpool/local/root@blank";

    supportedFilesystems = [ "ext4" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" "v4l2loopback" ];
    kernelParams = [ "mem_sleep_default=deep" "nohibernate" ];

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
      availableKernelModules = [ "xhci_pci" "nvme" ];
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
      allowUnfreePredicate = true;
      autoOptimiseStore = true;
      packageOverrides = pkgs: rec{
        unstable = import unstableTarball { config = config.nixpkgs.config; };
      };
    };

    overlays = [
      (self: super: {
        keybase = pkgs.unstable.keybase;
        keybase-gui = pkgs.unstable.keybase;
        kbfs = pkgs.unstable.kbfs;
      })
    ];
  };

  time = {
    timeZone = "US/Central";
    hardwareClockInLocalTime = true;
  };

  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = false;
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
    logitech.wireless.enable = true;
    logitech.wireless.enableGraphical = true;
    video.hidpi.enable = lib.mkDefault true;
  };

  networking = {
    hostName = "theseus";
    hostId = "e7d11eb2";
  };

  powerManagement = {
    powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "powersave";
  };

  system.stateVersion = "22.05";
}

