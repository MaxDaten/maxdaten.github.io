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
    site-generator
    stack
    shellcheck
    cabal-install
    cabal2nix
    haskellPackages.shake
    ghc
  ];

  pages = stdenv.mkDerivation {
    src = gitignoreSource ./../src;

    name = "cv.maxdaten.io";

    phases = [
      "unpackPhase"
      "buildPhase"
      "installPhase"
      "distPhase"
    ];

    buildInputs = [
      site-generator
      haskellPackages.shake
      texlive
      pandoc
      watchexec
      sass
      dhall
    ];

    buildPhase = ''
      site-generator --help
      site-generator --verbose build
    '';

    installPhase = ''
      set -x
      mkdir -p $out
      cp -r _site/* $out
    '';
  };
}
