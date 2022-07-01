{
  description = "Nixos configurations and dotfiles";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nurpkgs = {
      url = github:nix-community/NUR;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nurpkgs, home-manager, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
    let 
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixos-configurations = (
        import ./outputs/nixos-config.nix {
          inherit (nixpkgs) lib;
          inherit inputs system;
        }
      );

      devShell = pkgs.mkShell {
        name = "installation-shell";
        buildInputs = with pkgs; [ 
          curl
          git
          ripgrep
          wget
        ];
      };
   });
}

