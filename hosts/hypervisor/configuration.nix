{ config, lib, pkgs, ... }:
let
  unstableTarball = fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
in {

  imports = 
  [
    ../../modules/base
    ../../modules/networking
    ../../modules/services/libvirt
    ../../modules/services/podman
    ../../users/nikolai
  ];

  boot = {
    supportedFilesystems = [ "ext4" "zfs" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      supportedFilesystems = [ "ext4" "zfs" ];
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
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
  };

  networking = {
    hostName = "hv";
    hostId = "007f0200";
  };

  powerManagement = {
    powertop.enable = true;
  };

  system.stateVersion = "22.05";

}

