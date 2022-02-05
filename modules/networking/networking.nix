{ config, pkgs, ... }: {
  #TODO: variable-ize host, domain, and hostid
  networking.domain = "vpn.nikolaishields.com";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  #TODO: add wireguard configuration here

}

