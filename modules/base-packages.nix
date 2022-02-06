{ config, pkgs, ... }: {
  environment.binsh = "${pkgs.dash}/bin/dash";

  environment.systemPackages = with pkgs; [
    parted
    bash
    nixfmt
    curl
    dash
    fwupd
    htop
    pass
    ripgrep
    usbutils
    vault
    vim
    wget
    zfs
  ];
}
