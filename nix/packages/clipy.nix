{ lib, stdenvNoCC, fetchurl, undmg }:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "clipy";
  version = "1.4.1";

  src = fetchurl {
    url = "https://github.com/Clipy/Clipy/releases/download/${finalAttrs.version}/Clipy_${finalAttrs.version}.dmg";
    sha256 = "sha256-FMBnSCqx608gflsiyids4/sZlo4CFCI45Njhl8WUvOM=";
  };

  nativeBuildInputs = [ undmg ];
  sourceRoot = ".";
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/Applications"
    cp -R Clipy.app "$out/Applications/"
    runHook postInstall
  '';

  meta = {
    description = "Clipboard extension app for macOS";
    homepage = "https://clipy-app.com/";
    license = lib.licenses.mit;
    platforms = lib.platforms.darwin;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
})
