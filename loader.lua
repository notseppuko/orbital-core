local BASE = "https://raw.githubusercontent.com/notseppuko/orbital-core/refs/heads/main/"

local function load(path)
    return loadstring(game:HttpGet(BASE .. path))()
end

-- Core
local Services = load("core/services.lua")
local State    = load("core/state.lua")

-- UI
local WindowData = load("ui/window.lua")

-- Shared context
local Context = {
    Services = Services,
    State    = State,
    Window   = WindowData.Window,
    UI       = WindowData.UI,
    UIScale  = WindowData.UIScale
}

-- Features
load("features/movement.lua")(Context)

-- Utils / hooks
load("core/utils.lua")(Context)
