{ config, lib, pkgs, ... }:
let
  unstableTarball = fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
in {
  imports = 
  [
    ../../modules/base-packages.nix
    ../../modules/monitoring/default.nix
    ../../modules/networking/default.nix
    ../../modules/services/firecracker.nix
    ../../modules/services/libvirt.nix
    ../../modules/services/podman.nix
    ../../modules/services/k3s.nix
    ../../modules/users/nikolai.nix
    ../../modules/workstation.nix
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

  nixpkgs.config = {
    allowUnfree = true;
    autoOptimiseStore = true;
    packageOverrides = pkgs: {
      unstable = import unstableTarball { config = config.nixpkgs.config; };
    };
  };

  time = {
    timeZone = "America/Chicago";
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

  system.stateVersion = "21.11";

}

