{ project ? import ./nix { }
}:

project.pkgs.mkShell {
  buildInputs = project.devTools;
  shellHook = ''${project.shellHook}'';
}
