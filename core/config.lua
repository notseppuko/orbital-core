local HttpService = game:GetService("HttpService")

local Config = {}

Config.RootFolder = "Orbital"
Config.ConfigFolder = "Orbital/configs"

local _isfolder = isfolder or isfolder
local _makefolder = makefolder or makeFolder
local _writefile = writefile or writeFile

local function ensureFolders()

    if not _isfolder or not _makefolder then
        warn("[Orbital][Config] Folder APIs not supported by executor")
        return false
    end

    if not _isfolder(Config.RootFolder) then
        _makefolder(Config.RootFolder)
    end

    if not _isfolder(Config.ConfigFolder) then
        _makefolder(Config.ConfigFolder)
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
    if not _writefile then
        warn("[Orbital][Config] writefile not supported by executor")
        return false
    end

    if not ensureFolders() then
        warn("[Orbital][Config] Failed to ensure folders")
        return false
    end

    local data = collectState(ctx)
    local json = HttpService:JSONEncode(data)

    local path = Config.ConfigFolder .. "/" .. name .. ".json"
    _writefile(path, json)

    warn("[Orbital][Config] Saved config:", path)
    return true
end

return Config