{ dotfilesDir, ... }:
{
  programs.git = {
    enable = true;
    includes = [ { path = "${dotfilesDir}/config/git/identity.gitconfig"; } ];
  };
}
