local BUILD = {
    Branch  = "dev",      -- "dev" | "main"
    Version = "v0.2-dev",
    Status  = "In Development"
}


local BASE = "https://raw.githubusercontent.com/notseppuko/orbital-core/dev/"

local function load(path)
    local url = BASE .. path

    local ok, src = pcall(function()
        return game:HttpGet(url)
    end)

    if not ok or type(src) ~= "string" or #src == 0 then
        error("[Orbital] HttpGet failed: " .. url)
    end

    local fn, err = loadstring(src)
    if not fn then
        error("[Orbital] loadstring failed (" .. path .. "): " .. tostring(err))
    end

    return fn()
end

warn("[Orbital] Loader started")

-- Core
local FS       = load("core/fs.lua")
local Config   = load("core/config.lua")
local Services = load("core/services.lua")
local State    = load("core/state.lua")

-- UI
local WindowData = load("ui/window.lua")
if not WindowData or not WindowData.Window then
    error("[Orbital] WindowData invalid")
end

-- Shared context
local Context = {
    FS       = FS,
    Config   = Config,
    Services = Services,
    State    = State,
    Window   = WindowData.Window,
    UI       = WindowData.UI,
    UIScale  = WindowData.UIScale,
    Build    = BUILD
}

warn("[Orbital] Context ready")

-- FEATURES (DEBUG-FIRST)
local ok, err = pcall(function()
    load("features/aimbot.lua")(Context)
    load("features/visuals.lua")(Context)
    load("features/movement.lua")(Context)
    load("features/player.lua")(Context)
    load("features/misc.lua")(Context)
    load("ui/settings.lua")(Context)

end)

if not ok then
    error("[Orbital] Feature execution failed: " .. tostring(err))
end

warn("[Orbital] Loader finished successfully")
