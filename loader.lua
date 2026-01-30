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
local function safeLoad(path)
    load(path)(Context)
end

safeLoad("ui/settings.lua")
safeLoad("features/aimbot.lua")
safeLoad("features/visuals.lua")
safeLoad("features/movement.lua")
safeLoad("features/player.lua")
safeLoad("features/misc.lua")

warn("[Orbital] Loader finished successfully")