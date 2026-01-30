local Config = {}

Config.Folder = "OrbitalConfigs"

-- DEFINE collectState BEFORE Save
local function collectState(ctx)
    local State = ctx.State
    local UI    = ctx.UI

    return {
        Movement = {
            SpeedEnabled = State.SpeedEnabled,
            JumpEnabled  = State.JumpEnabled,
            SpeedValue   = UI and UI.Flags and UI.Flags.SpeedValue,
            JumpValue    = UI and UI.Flags and UI.Flags.JumpValue,
        },
        Misc = {
            AntiAFK = State.AntiAFK
        }
    }
end

function Config.Save(ctx, name)
    local FS = ctx.FS
    local Services = ctx.Services

    if not FS then
        warn("[Orbital][Config] FS not available")
        return false
    end

    if not Services or not Services.HttpService then
        warn("[Orbital][Config] HttpService unavailable")
        return false
    end

    local ok, err = FS.ensureFolder(Config.Folder)
    if not ok then
        warn("[Orbital][Config] Folder error:", err)
        return false
    end

    local data = collectState(ctx)
    local json = Services.HttpService:JSONEncode(data)

    local path = Config.Folder .. "/" .. name .. ".json"
    local ok2, err2 = FS.write(path, json)
    if not ok2 then
        warn("[Orbital][Config] Write error:", err2)
        return false
    end

    warn("[Orbital][Config] Saved:", path)
    return true
end

return Config
