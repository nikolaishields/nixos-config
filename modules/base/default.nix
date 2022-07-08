{ config, pkgs, ... }: 
{
  boot.cleanTmpDir = true;

  nix.autoOptimiseStore = true;

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
    exodus
    pass
    ripgrep
    usbutils
    vault
    vim
    wget
    zfs
  ];
}
