# TODO: generate access key?
# TODO:
{ config, pkgs, ... }:
{
  services = {
    minio = {
      enable = true;
      package = pkgs.unstable.minio;
      browser = true;
      region = "home";
      #dataDir = "/opt/appdata";
      #configDir = "/confi";
      #accessKey = "";
    };
  };
}
