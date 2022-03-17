{ config, pkgs, ... }: {
  environment.binsh = "${pkgs.dash}/bin/dash";

  environment.systemPackages = [
    pkgs.unstable.parted
    pkgs.unstable.bash
    pkgs.unstable.nixfmt
    pkgs.unstable.curl
    pkgs.unstable.dash
    pkgs.unstable.fwupd
    pkgs.unstable.htop
    pkgs.exodus
    pkgs.unstable.pass
    pkgs.unstable.ripgrep
    pkgs.unstable.usbutils
    pkgs.unstable.vault
    pkgs.unstable.vim
    pkgs.unstable.wget
    pkgs.unstable.zfs
  ];
}
