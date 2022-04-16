{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs.unstable; [
    firecracker
    ignite
    firectl
  ];
}
