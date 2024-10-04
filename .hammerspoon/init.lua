hyper = { "ctrl", "alt", "shift" }
hyperExtra = { "ctrl", "alt", "shift", "cmd" }

-- hyper +
-- "a" is autofill
-- "w" is close project
-- "o" is open project
-- "q' is lock screen

hs.hotkey.bind(hyper, "c", function() hs.application.launchOrFocus("Calendar") end)
hs.hotkey.bind(hyper, "o", function() hs.application.launchOrFocus("Arc") end)
hs.hotkey.bind(hyper, "g", function() hs.application.launchOrFocus("Google Chrome") end)
hs.hotkey.bind(hyper, "e", function() hs.application.launchOrFocus("Messages") end)
hs.hotkey.bind(hyper, "i", function() hs.application.launchOrFocus("IntelliJ IDEA") end)
hs.hotkey.bind(hyper, "k", function() hs.application.launchOrFocus("KeePassXC") end)
hs.hotkey.bind(hyper, "m", function() hs.application.launchOrFocus("Mail") end)
hs.hotkey.bind(hyper, "l", function() hs.application.launchOrFocus("Signal") end)
hs.hotkey.bind(hyper, "p", function() hs.application.launchOrFocus("NotePlan") end)
hs.hotkey.bind(hyper, "s", function() hs.application.launchOrFocus("Slack") end)
hs.hotkey.bind(hyper, "t", function() hs.application.launchOrFocus("TablePlus") end)
hs.hotkey.bind(hyper, "y", function() hs.application.launchOrFocus("Spotify") end)
hs.hotkey.bind(hyper, "return", function() hs.application.launchOrFocus("WezTerm") end)

function moveWindow(where)
    if hs.window.focusedWindow() then
        local w = hs.window.frontmostWindow()
        local s = hs.screen.mainScreen()
        if (where == "east") then
            s = s:toEast()
        elseif (where == "west") then
            s = s:toWest()
        elseif (where == "south") then
            s = s:toSouth()
        elseif (where == "north") then
            s = s:toNorth()
        end
        w:moveToScreen(s)
    end
end

function move(key, where)
    hs.hotkey.bind(hyperExtra, key, function() moveWindow(where) end)
end

-- The following functions bind hyper+{yuio} to move active window
-- to an adjacent screen
move("h", "west")
move("j", "south")
move("k", "north")
move("l", "east")

hs.hotkey.bind(hyperExtra, "m", function()
    local w = hs.window.frontmostWindow()
    w:minimize()
end)

hs.loadSpoon("MiroWindowsManager")

hs.window.animationDuration = 0.0
spoon.MiroWindowsManager.sizes = { 4, 2, 4 / 3 }
spoon.MiroWindowsManager:bindHotkeys({
    up = { hyperExtra, "up" },
    right = { hyperExtra, "right" },
    down = { hyperExtra, "down" },
    left = { hyperExtra, "left" },
    fullscreen = { hyperExtra, "f" }
})

hs.loadSpoon("WindowHalfsAndThirds")
spoon.WindowHalfsAndThirds:bindHotkeys({
    center = { hyperExtra, "c" },
    -- up = {hyperExtra, "up"},
    -- right = {hyperExtra, "right"},
    -- down = {hyperExtra, "down"},
    -- left = {hyperExtra, "left"},
    -- fullscreen = {hyperExtra, "f"}
})
-- hs.hotkey.bind(hyperExtra, "c", function() spoon.WindowHalfsAndThirds:center(hs.window.focusedWindow()) end)

function reloadConfig(files)
    doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
