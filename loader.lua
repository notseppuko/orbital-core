local function loadModule(path)
    local base = "https://raw.githubusercontent.com/notseppuko/orbital-core/refs/heads/main/"
    return loadstring(game:HttpGet(base .. path))()
end

local Services = loadModule("core/services.lua")
local State    = loadModule("core/state.lua")
local WindowData = loadModule("ui/window.lua")

local Context = {
    Services = Services,
    State    = State,
    Window   = WindowData.Window,
    UI       = WindowData.UI,
    UIScale  = WindowData.UIScale
}

loadModule("features/movement.lua")(Context)
