{ ... }:
{
  imports = [
    ../users
    ../networking
  ];

  boot.cleanTmpDir = true;

  nix.autoOptimiseStore = true;

  services.journald.extraConfig = ''
    SystemMaxUse=100M
    MaxFileSec=7day
  '';

  services.resolved = {
    enable = true;
    dnssec = "false";
  };
}
