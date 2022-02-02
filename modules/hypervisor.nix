{ config, pkgs, ... }: {
  virtualisation = {
    libvirtd.enable = true;
    podman.enable = true;
    docker.enable = true;
  };
}

