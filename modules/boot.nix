{ config, pkgs, ... }: {
  #TODO: variable-ize filesystems,kernel params, kernel modules, modeprobe config
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ext4" ];
  #  boot.zfs.enableUnstable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "kvm-intel" "v4l2loopback" ];
  boot.kernelParams = [ "mem_sleep_default=deep" "nohibernate" ];
  boot.initrd.supportedFilesystems = [ "ext4" ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" ];
  #  boot.initrd.postDeviceCommands = "zfs rollback -r rpool/local/root@blank";
  boot.extraModulePackages = [ pkgs.linuxPackages_latest.v4l2loopback ];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 video_nr=9 card_label="OBS"
  '';
}

