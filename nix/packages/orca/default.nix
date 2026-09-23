{
  lib,
  stdenvNoCC,
  fetchurl,
  unzip,
}:
let
  source = lib.importJSON ./source.json;
in
stdenvNoCC.mkDerivation {
  pname = "orca";
  inherit (source) version;

  src = fetchurl { inherit (source) url hash; };

  nativeBuildInputs = [ unzip ];
  sourceRoot = ".";

  # 署名済みの.appを書き換えないようにfixupを無効化
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications $out/bin
    cp -R Orca.app $out/Applications/
    ln -s $out/Applications/Orca.app/Contents/Resources/bin/orca $out/bin/orca
    runHook postInstall
  '';

  meta = {
    description = "IDE for orchestrating AI coding agents across terminals and worktrees";
    homepage = "https://onorca.dev/";
    license = lib.licenses.mit;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "aarch64-darwin" ];
    mainProgram = "orca";
  };
}
