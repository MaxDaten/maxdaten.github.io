{ mkDerivation, base, hakyll, lib, time }:
mkDerivation {
  pname = "site-generator";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base hakyll time ];
  description = "hakyll generator for cv.maxdaten.io";
  license = "unknown";
  hydraPlatforms = lib.platforms.none;
}
