{ config, pkgs, ... }:
{
    services = {
      shiori = {
        enable = true;
        package = pkgs.unstable.shiori;
        port = 4000;
        address = "127.0.0.1";
      };
   };
 }
