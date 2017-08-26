-- Standard awesome library
local revelation = require("revelation")
local gears = require("gears")
local awful = require("awful")
local common = require("awful.widget.common")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
-- local lain      = require("lain")

-- Custom libraries
-- local helpers = require("helpers")

-- Custom widgets
-- local myvolume = require("volume")

-- local mybattery = require("battery")
-- local mywifi = require("wifi")

-- Load Debian menu entries
require("debian.menu")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end
-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true
        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

naughty.config.presets.normal.opacity = 0.6
naughty.config.presets.low.opacity = 0.6
naughty.config.presets.critical.opacity = 0.8

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init("~/.config/awesome/themes/current/theme.lua")
revelation.init()

-- This is used later as the default terminal and editor to run.
terminal = "konsole"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"
altkey     = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
  awful.layout.suit.floating,
  awful.layout.suit.tile,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.tile.left,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.max.fullscreen
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
   names = {" 1 ", " 2 ", " 3 ", " 4 ", " 5 ",
            " vim ", " mail ", " web ", " spotify "},
   layout = {layouts[5], layouts[5], layouts[5], layouts[5], layouts[5],
              layouts[5], layouts[5], layouts[5], layouts[5]}
}
for s = 1, screen.count() do
   tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- Use with user_keys + key
-- key = {executable, class name (get it with xprop), tag to open on}
user_combination = {modkey}

first = 1
second = math.max(screen.count()-1,1)
third = screen.count()

user_keys =
{
  -- m = {"terminator -e 'source ~/.commonrc ; mutt'", "Terminator", tags[1][7]},
  -- e = {"mendeleydesktop", "Mendeley Desktop", tags[1][9]}
  -- i = {"inkscape", "Inkscape"},
  n = {"nautilus", "Nautilus"},
  x = {"xournal", "Xournal"},
  k = {"keepassx", "Keepassx"},
  y = {"skype", "Skype"},

  v = {"gvim", "Gvim", tags[first][6]},
  i = {"/home/bijan/Downloads/idea-IU-172.3544.35/bin/idea.sh", "jetbrains-idea", tags[first][6]},

  m = {"evolution", "Evolution", tags[second][7]},
  s = {"spotify --force-device-scale-factor=1.7", "Spotify", tags[second][9]},

  Return = {"konsole", "konsole", tags[third][1]},
  g = {"firefox", "Firefox", tags[third][8]}
}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

-- {{{ Menu
-- mymainmenu = awful.menu.new({ items = require("menugen").build_menu(),
--                               theme = { height = 40, width = 300 }})

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "Debian", debian.menu.Debian_menu.Debian },
                                    { "open terminal", terminal }
                                  }
                        })
-- }}}


mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Define custom tasklist updater
function tasklistupdate(w, buttons, labelfunc, data, objects)
    w:reset()

    -- Main container
    local l = wibox.layout.fixed.horizontal()
    l:fill_space(true)

    -- Text widget for displaying the name of the focused client
    local activeclient = nil;

    -- The inactive icons container
    local inactiveclients = wibox.layout.fixed.horizontal()

    -- Loop through all clients
    for i, o in ipairs(objects) do
        -- Init widget cache
        local cache = data[o]

        -- Get client informaion
        local text, bg, bg_image, icon = labelfunc(o)

        -- If cache is defined, use cache
        if cache then
            icon = cache.icon
            label = cache.label
            background = cache.background

        -- Else start from scratch
        else
            -- Inactive icon widgets
            icon = wibox.widget.imagebox()
            background = wibox.widget.background()
            background:set_widget(icon)

            -- Active label widget
            label = wibox.widget.textbox()

            -- Cache widgets
            data[o] = {
                icon = icon,
                label = label,
                background = background
            }

            -- Make icon clickable
            icon:buttons(common.create_buttons(buttons, o))

            -- Use custom drawing method for drawing icons
            -- helpers:set_draw_method(icon)
        end

        -- Use a fallback for clients without icons
        local iconsrc = o.icon

        if iconsrc == nil or iconsrc == "" then
            iconsrc = "/usr/share/icons/gnome/scalable/emblems/emblem-system-symbolic.svg"
        end

        -- Update background
        background:set_bg(bg)

        -- Update icon image
        icon:set_image(iconsrc)

        -- Always add the background and icon
        inactiveclients:add(background)

        -- If client is focused, add text and set as active client
        -- if bg == theme.tasklist_bg_focus then
        --     local labeltext = text
        --
        --     -- Append (F) if client is floating
        --     if awful.client.floating.get(o) then
        --         labeltext = labeltext .. " (F)"
        --     end
        --
        --     label:set_markup("   " .. labeltext .. "   ")
        --
        --     activeclient = label
        -- end
    end

    -- Add the inactive clients as icons first
    l:add(inactiveclients)

    -- Then add the active client as a text widget
    if activeclient then
        l:add(activeclient)
    end

    -- Add the main container to the parent widget
    w:add(l)
end

-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
awful.button({ }, 1, awful.tag.viewonly),
awful.button({ modkey }, 1, awful.client.movetotag),
awful.button({ }, 3, awful.tag.viewtoggle),
awful.button({ modkey }, 3, awful.client.toggletag),
awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
awful.button({ }, 1, function (c)
  if c == client.focus then
    c.minimized = true
  else
    -- Without this, the following
    -- :isvisible() makes no sense
    c.minimized = false
    if not c:isvisible() then
      awful.tag.viewonly(c:tags()[1])
    end
    -- This will also un-minimize
    -- the client, if needed
    client.focus = c
    c:raise()
  end
end),
awful.button({ }, 3, function ()
  if instance then
    instance:hide()
    instance = nil
  else
    instance = awful.menu.clients({
      theme = { width = 250 }
    })
  end
end),
awful.button({ }, 4, function ()
  awful.client.focus.byidx(1)
  if client.focus then client.focus:raise() end
end),
awful.button({ }, 5, function ()
  awful.client.focus.byidx(-1)
  if client.focus then client.focus:raise() end
end))


for s = 1, screen.count() do
    -- Widgets
    local separator = wibox.widget.imagebox()
    separator:set_image(beautiful.get().spr2px)

    local separatorbig = wibox.widget.imagebox()
    separatorbig:set_image(beautiful.get().spr5px)

    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons, nil, tasklistupdate)

    -- Create a systray widget
    local mysystray = wibox.widget.systray()
    local mysystraymargin = wibox.layout.margin()
    mysystraymargin:set_margins(6)
    mysystraymargin:set_widget(mysystray)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", height = 32, screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])
    left_layout:add(separator)

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()

    if s == 1 then
        right_layout:add(mysystraymargin)
        -- right_layout:add(myvolume.icon)
        -- right_layout:add(myvolume.text)

        -- if mybattery.hasbattery then
        --     right_layout:add(separator)
        --     right_layout:add(mybattery.icon)
        --     right_layout:add(mybattery.text)
        -- end

-- Battery
baticon = wibox.widget.imagebox(beautiful.widget_battery)
-- batwidget = lain.widgets.bat({
--     settings = function()
--         if bat_now.perc == "N/A" then
--             widget:set_markup(" AC ")
--             baticon:set_image(beautiful.widget_ac)
--             return
--         elseif tonumber(bat_now.perc) <= 5 then
--             baticon:set_image(beautiful.widget_battery_empty)
--         elseif tonumber(bat_now.perc) <= 15 then
--             baticon:set_image(beautiful.widget_battery_low)
--         else
--             baticon:set_image(beautiful.widget_battery)
--         end
--         widget:set_markup("Bat " .. bat_now.perc .. "% ")
--     end
-- })
--     --right_layout_add(baticon, batwidget)
--     right_layout:add(baticon, batwidget)

        -- if mywifi.haswifi then
        --     right_layout:add(separator)
        --     right_layout:add(mywifi.icon)
        --     right_layout:add(mywifi.text)
        -- end

        right_layout:add(separatorbig)
        right_layout:add(mytextclock)
        right_layout:add(mylayoutbox[s])
    end

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)

    layout:set_middle(mytasklist[s])

    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key binding functions
function raisevolume()
    awful.util.spawn("amixer set Master 2%+", false)
    -- helpers:delay(myvolume.update, 0.1)
end

function lowervolume()
    awful.util.spawn("amixer set Master 9%-", false)
    -- helpers:delay(myvolume.update, 0.1)
end

function mutevolume()
    awful.util.spawn("amixer -D pulse set Master 1+ toggle", false)
    -- helpers:delay(myvolume.update, 0.1)
end
-- -- }}}
--
---- Get active outputs
local function outputs()
   local outputs = {}
   local xrandr = io.popen("xrandr -q")
   if xrandr then
      for line in xrandr:lines() do
   output = line:match("^([%w-]+) connected ")
   if output then
      outputs[#outputs + 1] = output
   end
      end
      xrandr:close()
   end
   return outputs
end

local function arrange(out)
   -- We need to enumerate all the way to combinate output. We assume
   -- we want only an horizontal layout.
   local choices  = {}
   local previous = { {} }
   for i = 1, #out do
      -- Find all permutation of length `i`: we take the permutation
      -- of length `i-1` and for each of them, we create new
      -- permutations by adding each output at the end of it if it is
      -- not already present.
      local new = {}
      for _, p in pairs(previous) do
   for _, o in pairs(out) do
      if not awful.util.table.hasitem(p, o) then
         new[#new + 1] = awful.util.table.join(p, {o})
      end
   end
      end
      choices = awful.util.table.join(choices, new)
      previous = new
   end
   return choices
end

-- Build available choices
local function menu()
   local menu = {}
   local out = outputs()
   local choices = arrange(out)
   for _, choice in pairs(choices) do
      local cmd = "xrandr"
      -- Enabled outputs
      for i, o in pairs(choice) do
         cmd = cmd .. " --output " .. o .. " --auto"
         if i > 1 then
            cmd = cmd .. " --right-of " .. choice[i-1]
         end
      end
      -- Disabled outputs
      for _, o in pairs(out) do
         if not awful.util.table.hasitem(choice, o) then
            cmd = cmd .. " --output " .. o .. " --off"
         end
      end
      local label = ""
      if #choice == 1 then
         label = 'Only <span weight="bold">' .. choice[1] .. '</span>'
      else
         for i, o in pairs(choice) do
            if i > 1 then label = label .. " + " end
            label = label .. '<span weight="bold">' .. o .. '</span>'
         end
      end
      menu[#menu + 1] = { label, cmd,
                          "/usr/share/icons/Tango/32x32/devices/display.png"}
   end
   return menu
end

-- Display xrandr notifications from choices
local state = { iterator = nil,
    timer = nil,
    cid = nil }
local function xrandr()
   -- Stop any previous timer
   if state.timer then
      state.timer:stop()
      state.timer = nil
   end
   -- Build the list of choices
   if not state.iterator then
      state.iterator = awful.util.table.iterate(menu(),
          function() return true end)
   end
   -- Select one and display the appropriate notification
   local next  = state.iterator()
   local label, action, icon
   if not next then
      label, icon = "Keep the current configuration", "/usr/share/icons/Tango/32x32/devices/display.png"
      state.iterator = nil
   else
      label, action, icon = unpack(next)
   end
   state.cid = naughty.notify({ text = label,
        icon = icon,
        timeout = 4,
        screen = mouse.screen, -- Important, not all screens may be visible
        font = "Free Sans 20",
        replaces_id = state.cid }).id
   -- Setup the timer
   state.timer = timer { timeout = 4 }
   state.timer:connect_signal("timeout",
        function()
           state.timer:stop()
           state.timer = nil
           state.iterator = nil
           if action then
        awful.util.spawn(action, false)
           end
        end)
   state.timer:start()
end

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey, "Control"          }, "y", xrandr),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ modkey, "Control" }, "v",      revelation),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    -- Non-empty tag browsing
    -- awful.key({ modkey, "Control" }, "Left", function ()
    --   lain.util.tag_view_nonempty(-1) end),
    -- awful.key({ modkey, "Control" }, "Right", function ()
    --   lain.util.tag_view_nonempty(1) end),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({ keygrabber = true }) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    -- move focus to next/last screen (monitor)
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    -- awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey, "Control" }, "l",     function () awful.util.spawn("i3lock -c 000000") end),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    -- awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    -- awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- System volume
    awful.key({                   }, "XF86AudioRaiseVolume", raisevolume),
    awful.key({                   }, "XF86AudioLowerVolume", lowervolume),
    awful.key({                   }, "XF86AudioMute", mutevolume),

    awful.key({ modkey, "Shift"   }, "Up", raisevolume),
    awful.key({ modkey, "Shift"   }, "Down", lowervolume),

    -- System power
    awful.key({ modkey, "Control"   }, "q", function () awful.util.spawn("gksudo poweroff", false) end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey, "Shift", "Control" }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end),

    -- Brightness
    awful.key({ }, "XF86MonBrightnessDown", function ()
        awful.util.spawn("xbacklight -dec 5") end),
    awful.key({ }, "XF86MonBrightnessUp", function ()
        awful.util.spawn("xbacklight -inc 5") end),

    -- ALSA volume control
    --awful.key({ }, "XF86AudioRaiseVolume", function ()
        --os.execute(string.format("amixer set %s 1%%+", volumewidget.channel))
        --volumewidget.update()
    --end),
    --awful.key({ }, "XF86AudioLowerVolume", function ()
        --os.execute(string.format("amixer set %s 1%%-", volumewidget.channel))
        --volumewidget.update()
    --end),
    --awful.key({ }, "XF86AudioMute", function ()
        ----os.execute(string.format("amixer set %s toggle", volumewidget.channel))
        --awful.util.spawn("amixer set Master toggle")
        --awful.util.spawn("amixer set Headphone toggle")
        --awful.util.spawn("amixer set Speaker toggle")
        --volumewidget.update()
    --end),
    awful.key({ }, "XF86AudioMicMute", function ()
        awful.util.spawn("amixer set Capture toggle") end)

)

-- User programs
for k, v in pairs(user_keys) do
  globalkeys = awful.util.table.join(globalkeys,
    awful.key(user_combination, k, function ()
      local matcher = function (c)
        return awful.rules.match(c, {class = v[2]})
      end
      awful.client.run_or_raise(v[1], matcher)
    end))
end

clientkeys = awful.util.table.join(
  awful.key({ modkey, }, "f", function (c) c.fullscreen = not c.fullscreen end),
  awful.key({ modkey }, "q", function (c) c:kill() end),
  awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle),
  awful.key({ modkey, "Control" }, "Return",
    function (c) c:swap(awful.client.getmaster())  end),  -- ?
  -- Move window to next screen (monitor)
  awful.key({ modkey, }, "o", awful.client.movetoscreen ),
  awful.key({ modkey, }, "t", function (c) c.ontop = not c.ontop end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = {
                     keys = clientkeys,
                     buttons = clientbuttons } },
                     --border_width = beautiful.border_width,
                     --border_color = beautiful.border_normal,
                     --focus = awful.client.focus.filter,
                     --raise = true,

    { rule = { class = "Gnome-terminal" },
          properties = { opacity = 0.90 } },
}
for k, v in pairs(user_keys) do
  table.insert(awful.rules.rules,
      { rule = { class = v[2] },
        properties = { tag = v[3] } }
  )
end
---- }}}


-- No border for maximized clients
-- client.connect_signal("focus",
--   function(c)
--     if c.maximized_horizontal == true and c.maximized_vertical == true then
--       c.border_color = beautiful.border_normal
--     else
--       c.border_color = beautiful.border_focus
--     end
--   end)
-- client.connect_signal("unfocus", function(c)
--   c.border_color = beautiful.border_normal
-- end)
-- }}}


-- This causes full screen not to work
---- {{{ Arrange signal handler
--for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
    --local clients = awful.client.visible(s)
    --local layout  = awful.layout.getname(awful.layout.get(s))
    --if #clients > 0 then -- Fine grained borders and floaters control
      --for _, c in pairs(clients) do -- Floaters always have borders
        --if awful.client.floating.get(c) or layout == "floating" then
            --c.border_width = beautiful.border_width
        ---- No borders with only one visible client
        --elseif #clients == 1 or layout == "max" then
            --c.border_width = 0
        --else
            --c.border_width = beautiful.border_width
        --end
      --end
    --end
  --end)
--end
---- }}}


-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

--client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
--client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Autostart applications
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end
run_once("unclutter -root")
run_once("synclient touchpadoff=1")
run_once("nm-applet")
run_once("fluxgui")
run_once("owncloud")
run_once("eval `dbus-launch`")
awful.util.spawn_with_shell("xcompmgr &")
-- }}}
