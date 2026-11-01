{ lib, stdenvNoCC, fetchurl, undmg }:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "orca-ide";
  version = "1.4.245";

  src = fetchurl {
    url = "https://github.com/stablyai/orca/releases/download/v${finalAttrs.version}/orca-macos-arm64.dmg";
    sha256 = "sha256-pBO2WZiSawpGVNa34MD3iaX3WK06d3o97GDI3nIrutg=";
  };

  nativeBuildInputs = [ undmg ];
  sourceRoot = ".";
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/Applications" "$out/bin"
    cp -R Orca.app "$out/Applications/"
    ln -s "$out/Applications/Orca.app/Contents/Resources/bin/orca" "$out/bin/orca"
    runHook postInstall
  '';

  meta = {
    description = "IDE for orchestrating AI coding agents";
    homepage = "https://www.onorca.dev/";
    license = lib.licenses.mit;
    platforms = [ "aarch64-darwin" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
})
