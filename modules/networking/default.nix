{ config, pkgs, ... }:
{
  imports = 
  [
    ./networking.nix
    ./tailscale.nix
  ];
}
