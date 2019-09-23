hyper = {"ctrl", "cmd"}
hyperExtra = {"ctrl", "cmd", "shift"}

-- hyper +
-- "a" is autofill
-- "w" is close project
-- "o" is open project
-- "q' is lock screen

-- git H ub
hs.hotkey.bind(hyper, "h", function() hs.application.launchOrFocus("Github") end)
-- G oogle chrome
hs.hotkey.bind(hyper, "g", function() hs.application.launchOrFocus("Google Chrome") end)
-- I ntellij
hs.hotkey.bind(hyper, "i", function() hs.application.launchOrFocus("IntelliJ IDEA CE") end)
-- enter the terminal
hs.hotkey.bind(hyper, "return", function() hs.application.launchOrFocus("iTerm") end)
-- je N kins
hs.hotkey.bind(hyper, "n", function() hs.application.launchOrFocus("Jenkins") end)
-- J ira
hs.hotkey.bind(hyper, "j", function() hs.application.launchOrFocus("JIRA") end)
-- K eepassx
hs.hotkey.bind(hyper, "k", function() hs.application.launchOrFocus("KeepassXC") end)
-- P ostico
hs.hotkey.bind(hyper, "p", function() hs.application.launchOrFocus("Postico") end)
-- safa R i
-- hs.hotkey.bind(hyper, "r", function() hs.application.launchOrFocus("Safari") end)
-- S lack
hs.hotkey.bind(hyper, "s", function() hs.application.launchOrFocus("Slack") end)
-- M ail
hs.hotkey.bind(hyper, "m", function() hs.application.launchOrFocus("Spark") end)
-- spotif Y
hs.hotkey.bind(hyper, "y", function() hs.application.launchOrFocus("Spotify") end)
-- t E legram
hs.hotkey.bind(hyper, "e", function() hs.application.launchOrFocus("Telegram") end)
-- V isual studio code
hs.hotkey.bind(hyper, "v", function() hs.application.launchOrFocus("Visual Studio Code") end)
-- wha T sapp
hs.hotkey.bind(hyper, "t", function() hs.application.launchOrFocus("WhatsApp") end)
-- directions
hs.hotkey.bind(hyperExtra, "up", function()
  hs.window.focusedWindow():moveOneScreenNorth()
end)
hs.hotkey.bind(hyperExtra, "down", function()
  hs.window.focusedWindow():moveOneScreenSouth()
end)
hs.hotkey.bind(hyperExtra, "left", function()
  hs.window.focusedWindow():moveOneScreenWest()
end)
hs.hotkey.bind(hyperExtra, "right", function()
  hs.window.focusedWindow():moveOneScreenEast()
end)

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
