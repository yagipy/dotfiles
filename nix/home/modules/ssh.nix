{ config, dotfilesDir, ... }:
{
  home.file.".ssh/id_ed25519.yagipy.pub".source =
    config.lib.file.mkOutOfStoreSymlink
      "${dotfilesDir}/config/ssh/id_ed25519.yagipy.pub";
}
