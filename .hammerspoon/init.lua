hyper = {"ctrl", "alt", "shift"}
hyperExtra = {"ctrl", "alt", "shift", "cmd"}

-- hyper +
-- "a" is autofill
-- "w" is close project
-- "o" is open project
-- "q' is lock screen

hs.hotkey.bind(hyper, "c", function() hs.application.launchOrFocus("Calendar") end)
hs.hotkey.bind(hyper, "d", function() hs.application.launchOrFocus("Discord") end)
-- hs.hotkey.bind(hyper, "e", function() hs.application.launchOrFocus("Telegram") end)
hs.hotkey.bind(hyper, "g", function() hs.application.launchOrFocus("Firefox") end)
-- hs.hotkey.bind(hyper, "h", function() hs.application.launchOrFocus("Github") end)
hs.hotkey.bind(hyper, "i", function() hs.application.launchOrFocus("IntelliJ IDEA CE") end)
-- hs.hotkey.bind(hyper, "j", function() hs.application.launchOrFocus("JIRA") end)
hs.hotkey.bind(hyper, "k", function() hs.application.launchOrFocus("KeepassXC") end)
hs.hotkey.bind(hyper, "m", function() hs.application.launchOrFocus("Mail") end)
hs.hotkey.bind(hyper, "n", function() hs.application.launchOrFocus("Notion") end)
-- hs.hotkey.bind(hyper, "p", function() hs.application.launchOrFocus("Postico") end)
hs.hotkey.bind(hyper, "s", function() hs.application.launchOrFocus("Slack") end)
hs.hotkey.bind(hyper, "t", function() hs.application.launchOrFocus("WhatsApp") end)
hs.hotkey.bind(hyper, "v", function() hs.application.launchOrFocus("Visual Studio Code") end)
hs.hotkey.bind(hyper, "y", function() hs.application.launchOrFocus("Spotify") end)
hs.hotkey.bind(hyper, "z", function() hs.application.launchOrFocus("zoom.us") end)
hs.hotkey.bind(hyper, "return", function() hs.application.launchOrFocus("iTerm") end)

function moveWindow(where)
  if hs.window.focusedWindow() then
    local w = hs.window.frontmostWindow()
    local s = hs.screen.mainScreen()
    if (where == "east") then s = s:toEast()
    elseif (where == "west") then s = s:toWest()
    elseif (where == "south") then s = s:toSouth()
    elseif (where == "north") then s = s:toNorth()
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

hs.loadSpoon("MiroWindowsManager")

hs.window.animationDuration = 0.0
spoon.MiroWindowsManager:bindHotkeys({
  up = {hyper, "up"},
  right = {hyper, "right"},
  down = {hyper, "down"},
  left = {hyper, "left"},
  fullscreen = {hyper, "f"}
})

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
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
