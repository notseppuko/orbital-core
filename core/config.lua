local Config = {}
Config.Folder = "OrbitalConfigs"

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
    local FS = ctx.FS
    local HttpService = ctx.Services.HttpService
    if not FS then
        warn("[Orbital][Config] FS not available in context")
        return false
    end

    local ok, err = FS.ensureFolder(Config.Folder)
    if not ok then
        warn("[Orbital][Config] Folder error:", err)
        return false
    end

    local data = collectState(ctx)
    local json = HttpService:JSONEncode(data)

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