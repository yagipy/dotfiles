{ lib, stdenvNoCC, fetchurl, unzip }:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "dia-browser";
  version = "1.55.1";

  src = fetchurl {
    url = "https://releases.diabrowser.com/release/Dia-${finalAttrs.version}-89833.zip";
    sha256 = "sha256-L+VKY0ObwpxeAsCdBjpdyL9y6wwHRiz5TCFz6hcklsM=";
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
