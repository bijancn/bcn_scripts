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

-- macOS keyboard behavior
-- By default, WezTerm treats the LEFT Option key as Alt (Meta),
-- which prevents macOS dead-key composition like Option+u (¨).
-- Explicitly enable sending composed keys for both Option keys
-- so Option+u + letter yields umlauts (ä/ö/ü) instead of Alt-u.
config.send_composed_key_when_right_alt_is_pressed = true
-- we don't want to send composed keys for the left alt key as its used for buffer navigation in NVIM
config.send_composed_key_when_left_alt_is_pressed = false

-- Map OS appearance -> color scheme names
local function scheme_for_appearance(appearance)
    if appearance:find('Dark') then
        return 'One Dark (Gogh)'
    else
        return 'One Light (Gogh)'
    end
end

-- Derive tab bar colors from the active scheme so it adapts
-- across light/dark themes, even if the scheme lacks tab_bar.
local function _hex_to_rgb(hex)
    hex = (hex or "#000000"):gsub('#', '')
    return tonumber('0x' .. hex:sub(1, 2)) or 0,
        tonumber('0x' .. hex:sub(3, 4)) or 0,
        tonumber('0x' .. hex:sub(5, 6)) or 0
end

local function _rgb_to_hex(r, g, b)
    return string.format('#%02x%02x%02x', r, g, b)
end

local function _blend(a, b, t)
    local ar, ag, ab = _hex_to_rgb(a)
    local br, bg, bb = _hex_to_rgb(b)
    local r = math.floor(ar + (br - ar) * t + 0.5)
    local g = math.floor(ag + (bg - ag) * t + 0.5)
    local bl = math.floor(ab + (bb - ab) * t + 0.5)
    return _rgb_to_hex(r, g, bl)
end

local function tab_bar_from_scheme(s)
    local bg = s.background or '#1e1e1e'
    local fg = s.foreground or '#c0c0c0'
    local tbg = _blend(bg, fg, 0.06)
    local ibg = _blend(bg, fg, 0.10)
    local hbg = _blend(bg, fg, 0.16)
    local abg = _blend(bg, fg, 0.22)
    return {
        background = tbg,
        active_tab = {
            bg_color = abg,
            fg_color = fg,
            intensity = 'Normal',
            underline = 'None',
            italic = false,
            strikethrough = false,
        },
        inactive_tab = { bg_color = ibg, fg_color = _blend(fg, bg, 0.35) },
        inactive_tab_hover = { bg_color = hbg, fg_color = fg, italic = true },
        new_tab = { bg_color = ibg, fg_color = _blend(fg, bg, 0.35) },
        new_tab_hover = { bg_color = hbg, fg_color = fg, italic = true },
    }
end

-- Initial scheme at launch
if wezterm.gui then
    local ok, appearance = pcall(wezterm.gui.get_appearance)
    if ok and appearance then
        config.color_scheme = scheme_for_appearance(appearance)
        -- Derive tab bar colors to match the current scheme
        local schemes = wezterm.color.get_builtin_schemes()
        local s = schemes[config.color_scheme] or {}
        config.colors = config.colors or {}
        config.colors.tab_bar = s.tab_bar or tab_bar_from_scheme(s)
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

    -- Compute tab bar colors from the active scheme
    local schemes = wezterm.color.get_builtin_schemes()
    local s = schemes[overrides.color_scheme] or {}
    overrides.colors = overrides.colors or {}
    overrides.colors.tab_bar = s.tab_bar or tab_bar_from_scheme(s)

    -- Increase contrast in dark mode by brightening foreground
    if appearance:find('Dark') then
        overrides.colors.foreground = '#D7DAE0' -- brighter than default One Dark fg
        overrides.set_environment_variables = overrides.set_environment_variables or {}
        overrides.set_environment_variables.PROMPT_THEME_MODE = 'dark'
    else
        -- Light mode: use scheme defaults for foreground
        overrides.colors.foreground = nil
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
