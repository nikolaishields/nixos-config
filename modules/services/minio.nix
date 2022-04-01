{ config, pkgs, ... }:
{
  minio = {
    image = "minio/minio:latest";
    autostart = true;
    ports = [ "127.0.0.1:9001" ];
    volumes = [ 
      "/opt/app-data/minio:/opt/data"
    ];
    extraConfig = [
      "-l=traefik.enable=true"
      "-l=traefik.http.routers.minio.rule=Host(`s3.nikolaishields.com`)"
      "-l=traefik.http.routers.minio.tls.certresolver=pdns"
      "-l=traefik.http.services.minio.loadbalancer.server.port=9001"
    ];
  };
}
