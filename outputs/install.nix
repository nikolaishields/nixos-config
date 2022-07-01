{ system, nixpkgs }:

let
  pkgs = nixpkgs.legacyPackages.${system};
in
pkgs.mkShell {
  name = "installation-shell";
  buildInputs = with pkgs; [ 
    awk
    curl
    git
    rg
    sed
    tar
    wget
  ];
}

