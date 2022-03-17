{
  network = {
    description = "";
  };

  "nas" = { config, pkgs, lib, ... }: {
    imports = [
      ../../modules/services/minio.nix
      ../../modules/base
    ];

    deployment.targetUser = "root";
    deployment.targetHost = "nas.nikolaishields.com";
  };
}

