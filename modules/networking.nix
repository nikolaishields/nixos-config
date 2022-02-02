{ config, pkgs, ... }: {
  #TODO: variable-ize host, domain, and hostid
  networking.hostName = "theseus";
  networking.domain = "vpn.nikolaishields.com";
  networking.hostId = "e7d11eb2";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  #TODO: add wireguard configuration here

}

