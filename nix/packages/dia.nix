{ lib, stdenvNoCC, fetchurl, unzip }:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "dia-browser";
  version = "1.54.2";

  src = fetchurl {
    url = "https://releases.diabrowser.com/release/Dia-${finalAttrs.version}-89247.zip";
    sha256 = "825133fc5e684a41f7411596dd76bbacf10120876b5d88b841c126001400df82";
  };

  nativeBuildInputs = [ unzip ];
  sourceRoot = ".";
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/Applications"
    cp -R Dia.app "$out/Applications/"
    runHook postInstall
  '';

  meta = {
    description = "Dia web browser";
    homepage = "https://www.diabrowser.com/";
    license = lib.licenses.unfree;
    platforms = [ "aarch64-darwin" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
})
