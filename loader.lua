local BASE = "https://raw.githubusercontent.com/notseppuko/orbital-core/refs/heads/main/"

local function load(path)
    return loadstring(game:HttpGet(BASE .. path))()
end

-- Core
local Services = load("core/services.lua")
local State    = load("core/state.lua")

-- UI
local WindowData = load("ui/window.lua")
if not WindowData then
    warn("[Orbital] UI failed to initialize, aborting")
    return
end

local Context = {
    Services = Services,
    State    = State,
    Window   = WindowData.Window,
    UI       = WindowData.UI,
    UIScale  = WindowData.UIScale
}

-- Features / Tabs
load("features/aimbot.lua")(Context)
load("features/visuals.lua")(Context)
load("features/movement.lua")(Context)
load("features/player.lua")(Context)
load("features/misc.lua")(Context)

-- UI
load("ui/settings.lua")(Context)

-- Hooks
load("core/utils.lua")(Context)
