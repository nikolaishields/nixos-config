{ config, pkgs, ... }:
{
  services = {
    k3s = {
      role = "server";
    };
  };
}
