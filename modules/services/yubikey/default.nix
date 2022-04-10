{ config, lib, pkgs, ... }:
{
  services = {
    pcscd.enable = true;
    udev.packages = [ pkgs.unstable.yubikey-personalization ];
  };
}
