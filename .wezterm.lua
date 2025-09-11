-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- Preferred fonts
config.font = wezterm.font 'JetBrainsMonoNL Nerd Font'
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font = wezterm.font 'FiraCode Nerd Font'
config.font_size = 13
config.line_height = 1.1

-- UI tweaks
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = 'RESIZE'
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

-- Map OS appearance -> color scheme names
local function scheme_for_appearance(appearance)
    if appearance:find('Dark') then
        return 'One Dark (Gogh)'
    else
        return 'One Light (Gogh)'
    end
end

-- Initial scheme at launch
if wezterm.gui then
    local ok, appearance = pcall(wezterm.gui.get_appearance)
    if ok and appearance then
        config.color_scheme = scheme_for_appearance(appearance)
        -- Export appearance to shells started by WezTerm
        config.set_environment_variables = config.set_environment_variables or {}
        config.set_environment_variables.PROMPT_THEME_MODE = appearance:find('Dark') and 'dark' or 'light'
    end
end

-- Keep windows in sync with OS theme
wezterm.on('window-config-reloaded', function(window, _)
    local overrides = window:get_config_overrides() or {}
    local appearance = window:get_appearance()
    overrides.color_scheme = scheme_for_appearance(appearance)

    -- Increase contrast in dark mode by brightening foreground
    if appearance:find('Dark') then
        overrides.colors = overrides.colors or {}
        overrides.colors.foreground = '#D7DAE0' -- brighter than default One Dark fg
        overrides.set_environment_variables = overrides.set_environment_variables or {}
        overrides.set_environment_variables.PROMPT_THEME_MODE = 'dark'
    else
        -- Use the light scheme's defaults as-is
        overrides.colors = nil
        overrides.set_environment_variables = overrides.set_environment_variables or {}
        overrides.set_environment_variables.PROMPT_THEME_MODE = 'light'
    end

    window:set_config_overrides(overrides)
end)

-- Keybindings
config.keys = {
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
    {
        key = 'Enter',
        mods = 'ALT',
        action = wezterm.action.DisableDefaultAssignment,
    },
}

config.native_macos_fullscreen_mode = false

-- and finally, return the configuration to wezterm
return config
