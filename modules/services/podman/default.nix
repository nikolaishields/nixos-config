{ config, pkgs, ... }: {
  virtualisation = {
    podman  = {
      enable = true;
      dockerCompat = false;
    };
  };
}
