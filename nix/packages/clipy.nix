{ lib, stdenvNoCC, fetchurl, undmg }:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "clipy";
  version = "1.4.0";

  src = fetchurl {
    url = "https://github.com/Clipy/Clipy/releases/download/${finalAttrs.version}/Clipy_${finalAttrs.version}.dmg";
    sha256 = "69630237ec929c11414775aeff20804359f9e3a7aa8a6d09178d41d4b7bd10ab";
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
