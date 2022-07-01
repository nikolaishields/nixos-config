{ lib, inputs, system, ... }:

{
  workstation = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/configuration.nix
      ../system/machine/framework
    ];
  };

  base-server = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/machine/base
      ../system/configuration.nix
    ];
  };
}

