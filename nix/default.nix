{ nixpkgs ? import (
  builtins.fetchGit (
    builtins.fromJSON (
      # Update via:
      # `nix-prefetch-git https://github.com/nixos/nixpkgs/ --rev refs/heads/master > nixpkgs-latest.json`
      builtins.readFile ./nixpkgs-latest.json
    )
  )) {}
}:
let
  inherit (nixpkgs) pkgs;

  gitignoreSrc = pkgs.fetchFromGitHub {
    owner = "hercules-ci";
    repo = "gitignore.nix";
    # put the latest commit sha of gitignore Nix library here:
    rev = "211907489e9f198594c0eb0ca9256a1949c9d412";
    sha256 = "sha256:06j7wpvj54khw0z10fjyi31kpafkr6hi1k0di13k1xp8kywvfyx8";
  };

  inherit (import gitignoreSrc { inherit (pkgs) lib; }) gitignoreSource;

  texlive = pkgs.texlive.combine {
    inherit (pkgs.texlive)
    scheme-small;
  };

  site-generator = pkgs.haskellPackages.callPackage ../site-generator/site-generator.nix { };

in with pkgs;
{
  inherit pkgs texlive;

  shellHook = ./setup-shell.sh;

  devTools = [
    stack
    shellcheck
    cabal-install
    cabal2nix
    ghc
  ];

  pages = stdenv.mkDerivation {
    src = gitignoreSource ./..;

    name = "cv.maxdaten.io";
    phases = [];
    buildInputs = [
      site-generator
      texlive
      pandoc
      watchexec
      sass
      dhall
    ];
  };
}
