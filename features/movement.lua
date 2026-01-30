local Services = require(path.core.services)
local State    = require(path.core.state)

return function(Window, UI)
    local Movement = Window:AddTab("Movement", UI.Icons.World)
    Movement:AddSection("Speed")

    Movement:AddToggle("Enable Speed", {
        Flag = "SpeedEnabled",
        Default = false
    }, function(value)
        State.SpeedEnabled = value
        local char = Services.LocalPlayer.Character
        local hum = char and char:FindFirstChild("Humanoid")
        if hum then
            hum.WalkSpeed = value and (UI.Get("SpeedValue") or 50) or 16
        end
    end)

    Movement:AddSlider("Walk Speed", {
        Flag = "SpeedValue",
        Min = 16, Max = 300, Default = 16
    }, function(value)
        if State.SpeedEnabled then
            local hum = Services.LocalPlayer.Character
                and Services.LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum then hum.WalkSpeed = value end
        end
    end)
end
