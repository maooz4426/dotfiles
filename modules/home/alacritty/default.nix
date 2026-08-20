{ ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        startup_mode = "Maximized";
        decorations = "buttonless";
      };

      font = {
        normal = {
          family = "Hack Nerd Font Mono";
          style = "Regular";
        };
        size = 13.0;
      };

      cursor = {
        style = {
          shape = "Block";
          blinking = "Always";
        };
      };

      colors = import ./theme.nix;
    };
  };
}
