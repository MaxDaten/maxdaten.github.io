{ project ? import ./nix { }
}:

project.pkgs.mkShell {
  buildInputs = project.devTools;
  shellHook = ''${project.shellHook}'';
  SITE_SOURCE_DIRECTORY = ./src;
}
