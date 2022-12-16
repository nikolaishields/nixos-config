{
  description = "Nikolai's Nixos Config";
  inputs.nixpkgs.url = "nixpkgs/nixos-22.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
    let 
      pkgs = nixpkgs.legacyPackages.${system};
    in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            age
            awscli2
            bashInteractive
            bats
            binutils
            curl
            drone-cli
            file
            gcc
            gh
            git
            git-bug
            gnumake
            go-tools
            go_1_18
            gopls
            gotools
            k9s
            kubectl
            kubernetes-helm
            nettools
            nixpkgs-fmt
            openssl
            shellcheck
            shfmt
            sops
            terraform
            terragrunt
            wget
            yq-go
          ];
        };
      });
}
