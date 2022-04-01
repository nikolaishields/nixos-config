{ config, pkgs, ... }: {
  virtualisation = {
    podman  = {
      enable = false;
      dockerCompat = true;
    };
  };
}
