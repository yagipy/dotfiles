{
  stateVersion = 7;

  defaults.NSGlobalDomain = {
    AppleInterfaceStyle = "Dark";
    AppleInterfaceStyleSwitchesAutomatically = false;
    "com.apple.trackpad.scaling" = 3.0;
    KeyRepeat = 2;
    InitialKeyRepeat = 15;
  };
  defaults.trackpad.Clicking = true;
  defaults.controlcenter = {
    Display = true;
    Sound = true;
  };
  defaults.dock = import ./dock.nix;
  defaults.CustomUserPreferences.NSGlobalDomain.TISRomanSwitchState = 1;
}
