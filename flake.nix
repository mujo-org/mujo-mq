{
  description = "mujo-mq development shell";

  # nixos-23.11 ships GHC 9.6.3, the version upstream CI builds with.
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAll = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in {
      devShells = forAll (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            haskell.compiler.ghc963
            cabal-install
            pkg-config
            git
            curl
            openssl
            zlib
            gmp
            sqlite
            postgresql
            numactl
          ];
        };
      });
    };
}
