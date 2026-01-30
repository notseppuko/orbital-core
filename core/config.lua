local HttpService = game:GetService("HttpService")

local Config = {}

Config.RootFolder = "Orbital"
Config.ConfigFolder = "Orbital/configs"

-- Folder Checker
local function ensureFolders()
    if not isFolder(Config.RootFolder) then
        makefolder(Config.RootFolder)
    end

    if not isfolder(Config.ConfigFolder) then
        makefolder(Config.ConfigFolder)
    end
end

-- Settings To Save
local function collectState(ctx)
    local State = ctx.State
    local UI    = ctx.UI

    return {
        Movement = {
            SpeedEnabled = State.SpeedEnabled,
            JumpEnabled  = State.JumpEnabled,
            SpeedValue   =  UI and UI.Flags and UI.Flags.SpeedValue,
            JumpValue    = UI and UI.Flags and UI.Flags.JumpValue
         },
        
         Misc = {
            AntiAFK = State.AntiAFK
         }
    }
end

function Config.Save(ctx, name)
    if type(writefile) ~= "function" then
        warn("[Orbital] Executor does not support file writing")
        return false
    end

    ensureFolders()

    local data = collectState(ctx)
    local json = HttpService:JSONEncode(data)

    local path = Config.ConfigFolder .. "/" .. name ".json"
    writefile(path,json)

    return true
end

return Config