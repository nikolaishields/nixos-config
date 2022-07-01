{ lib, inputs, system, ... }:

{
  framework = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/configuration.nix
      ../system/machine/framework
    ];
  };
}

