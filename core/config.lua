local HttpService = game:GetService("HttpService")
local FS = require(path.to.fs) -- OR load via loader context (recommended)

local Config = {}

Config.Folder = "OrbitalConfigs"

local function ensureFolders()
    local ok, err = FS.ensureFolder(Config.Folder)
    if not ok then
        warn("[Orbital][Config] Folder error:", err)
        return false
    end
    return true
end

local function collectState(ctx)
    local State = ctx.State
    local UI    = ctx.UI

    return {
        Movement = {
            SpeedEnabled = State.SpeedEnabled,
            JumpEnabled  = State.JumpEnabled,
            SpeedValue   = UI and UI.Flags and UI.Flags.SpeedValue,
            JumpValue    = UI and UI.Flags and UI.Flags.JumpValue
        },
        Misc = {
            AntiAFK = State.AntiAFK
        }
    }
end

function Config.Save(ctx, name)
    if not ensureFolders() then return false end

    local data = collectState(ctx)
    local json = HttpService:JSONEncode(data)

    local path = Config.Folder .. "/" .. name .. ".json"

    local ok, err = FS.write(path, json)
    if not ok then
        warn("[Orbital][Config] Write failed:", err)
        return false
    end

    warn("[Orbital][Config] Saved:", path)
    return true
end

return Config