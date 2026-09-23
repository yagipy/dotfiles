{ dotfilesDir, ... }:
{
  programs.zsh = {
    enable = true;
    initContent = ''
      for file in "${dotfilesDir}"/config/zsh/*.zsh; do
        source "$file"
      done
    '';
  };
}
