-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- config.color_scheme = 'AdventureTime'

config.font = wezterm.font {
  family = 'FiraCode Nerd Font',
  -- weight = 'Regular',
  harfbuzz_features = {"cv02", "cv05", "ss01", "zero", "ss05", "ss03", "ss02", "cv19", "cv23", "ss08"},
}

-- and finally, return the configuration to wezterm
return config
