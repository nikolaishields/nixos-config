{ config, pkgs, ... }: 
{
  boot.cleanTmpDir = true;

  services.journald.extraConfig = ''
    SystemMaxUse=100M
    MaxFileSec=7day
  '';

  services.resolved = {
    enable = true;
    dnssec = "false";
  };

  environment.binsh = "${pkgs.dash}/bin/dash";

  environment.systemPackages = with pkgs; [
    pciutils
    parted
    bash
    busybox
    nixfmt
    curl
    dash
    fwupd
    lshw
    htop
    ripgrep
    usbutils
    vim
    wget
    zfs
  ];
}
