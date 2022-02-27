{ config, pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [ 6443 10250 ];
  environment.systemPackages = [ pkgs.k3s ];
  services = {
    k3s = {
      enable = true;
      role = "server";
    };
  };
}
