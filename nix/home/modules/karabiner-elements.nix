{ ... }:
{
  xdg.configFile."karabiner/karabiner.json".force = true;
  xdg.configFile."karabiner/karabiner.json".text = builtins.toJSON {
    profiles = [
      {
        name = "Default";
        selected = true;
        virtual_hid_keyboard.keyboard_type_v2 = "ansi";
        complex_modifications.rules = [
          {
            description = "Tap left Command for Eisu, right Command for Kana";
            manipulators = map
              ({ command, input }: {
                type = "basic";
                from.key_code = command;
                to = [ { key_code = command; } ];
                to_if_alone = [ { key_code = input; } ];
              })
              [
                { command = "left_command"; input = "japanese_eisuu"; }
                { command = "right_command"; input = "japanese_kana"; }
              ];
          }
        ];
      }
    ];
  };
}
