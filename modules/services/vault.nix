{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs.unstable; [
    vault
  ];

  users.users.vault = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "vault" ];
  };

  services = {
    vault = {
      enable = true;
      storagePath = "/opt/appdata/vault";
      storageBackend = "file";
    };
  };
}
