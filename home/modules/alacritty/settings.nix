{
  window = {
    decorations = "None";
    opacity = 0.8;
    blur = true;
    title = "Alacritty";
    dynamic_title = true; # Default
    resize_increments = true;
  };
  scrolling = {
    # Max history
    history = 100000;
  };
  font = {
    # Roboto Mono
    normal = { family = "RobotoMono Nerd Font"; style = "Regular"; };
    bold = { style = "Bold"; }; # Default
    italic = { style = "Italic"; }; # Default
    bold_italic = { style = "Bold Italic"; }; # Default
    size = 12;
    builtin_box_drawing = false; # TODO Experiment
  };
}
