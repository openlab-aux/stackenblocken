{ mkDerivation, base, containers, irc-client, protolude, stdenv }:
mkDerivation {
  pname = "stackenblocken";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base containers irc-client protolude
  ];
  license = stdenv.lib.licenses.gpl3;
}
