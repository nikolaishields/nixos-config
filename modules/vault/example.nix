self: super: {
  consul-bin = self.callPackage ./hashicorp-generic.nix {
    name = "vault";
    version = "1.9.3";
    sha256 = "0fc6a8d5jm17sk7ppqs8adhw5adbcvm218vbzq02ipxlbwj9y18n";
  };
}
