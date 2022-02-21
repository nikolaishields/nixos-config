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
  # zfs support
#    virtualisation.containerd.enable = true;
  ## TODO describe how to enable zfs snapshotter in containerd
  #services.k3s.extraFlags = toString [
    #"--container-runtime-endpoint unix:///run/containerd/containerd.sock"
  #];
}
