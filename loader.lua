local BASE = "https://raw.githubusercontent.com/notseppuko/orbital-core/refs/heads/main/"

local function load(path)
    local src = game:HttpGet(BASE .. path)
    return loadstring(src)()
end

warn("[Orbital] Loader started")

-- Core
local Services = load("core/services.lua")
local State    = load("core/state.lua")

-- UI
local WindowData = load("ui/window.lua")
if not WindowData then
    warn("[Orbital] WindowData nil, aborting")
    return
end

local Context = {
    Services = Services,
    State    = State,
    Window   = WindowData.Window,
    UI       = WindowData.UI,
    UIScale  = WindowData.UIScale
}

warn("[Orbital] Context ready, loading features")

-- FEATURES (THESE LINES MUST EXECUTE)
local ok, err = pcall(function()
    load("features/movement.lua")(Context)
    load("ui/settings.lua")(Context)
end)

if not ok then
    warn("[Orbital] Feature load error:", err)
end

warn("[Orbital] Loader finished")
