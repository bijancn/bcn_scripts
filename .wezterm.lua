-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.font = wezterm.font 'JetBrainsMonoNL Nerd Font'
-- config.font = wezterm.font 'Monaspace Neon'
config.font = wezterm.font 'Fira Code'
config.font_size = 14
config.line_height = 1.3
config.color_scheme = 'Azu (Gogh)'
config.color_scheme = 'Hacktober'
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

config.keys = {
    -- This will create a new split and run your default program inside it
    {
        key = 's',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'h',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'Enter',
        mods = 'SHIFT|CTRL',
        action = wezterm.action.ToggleFullScreen,
    },
}


-- and finally, return the configuration to wezterm
return config
