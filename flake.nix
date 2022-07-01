{
  description = "Nixos configurations and dotfiles";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nurpkgs = {
      url = github:nix-community/NUR;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nurpkgs, home-manager }:
    let
      system = "x86_64-linux";
    in
    {
      nixos-configurations = (
        import ./outputs/nixos-config.nix {
          inherit (nixpkgs) lib;
          inherit inputs system;
        }
      );

      devShell.${system} = (
        import ./outputs/install.nix {
          inherit system nixpkgs;
        }
      );
    };
}

