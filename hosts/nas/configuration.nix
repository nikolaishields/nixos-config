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
    ../../modules/users/nikolai.nix
    ./hardware-configuration.nix
  ];

  boot = {
    # TODO: ephemeral root
    #  boot.initrd.postDeviceCommands = "zfs rollback -r rpool/local/root@blank";
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
    hostName = "nas";
    hostId = "";
  };

  powerManagement = {
    powertop.enable = true;
  };

  system.stateVersion = "21.11";

}

