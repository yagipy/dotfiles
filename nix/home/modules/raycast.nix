{ pkgs, ... }:
{
  launchd.agents.raycast = {
    enable = true;
    config = {
      ProgramArguments = [ "${pkgs.raycast}/Applications/Raycast.app/Contents/MacOS/Raycast" ];
      RunAtLoad = true;
      ProcessType = "Interactive";
    };
  };
}
