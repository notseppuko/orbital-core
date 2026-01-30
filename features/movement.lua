return function(ctx)
    task.wait()

    local Window   = ctx.Window
    local UI       = ctx.UI
    local Services = ctx.Services
    local State    = ctx.State

    local speedValue = 16
    local jumpValue  = 100

    local Movement = Window:AddTab("Movement", UI.Icons.World)

    -- SPEED
    Movement:AddSection("Speed")

    Movement:AddToggle("Enable Speed", {
        Flag = "SpeedEnabled",
        Default = false
    }, function(v)
        State.SpeedEnabled = v
        local hum = Services.LocalPlayer.Character
            and Services.LocalPlayer.Character:FindFirstChild("Humanoid")

        if hum then
            hum.WalkSpeed = v and speedValue or 16
        end
    end)

    Movement:AddSlider("Walk Speed", {
        Flag = "SpeedValue",
        Min = 16,
        Max = 300,
        Default = 16
    }, function(v)
        speedValue = v
        if State.SpeedEnabled then
            local hum = Services.LocalPlayer.Character
                and Services.LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum then hum.WalkSpeed = v end
        end
    end)

    -- JUMP
    Movement:AddDivider()
    Movement:AddSection("Jump")

    Movement:AddToggle("Enable Jump Power", {
        Flag = "JumpEnabled",
        Default = false
    }, function(v)
        State.JumpEnabled = v
        local hum = Services.LocalPlayer.Character
            and Services.LocalPlayer.Character:FindFirstChild("Humanoid")

        if hum then
            hum.JumpPower  = v and jumpValue or 50
            hum.JumpHeight = v and (jumpValue / 2) or 7.2
        end
    end)

    Movement:AddSlider("Jump Power", {
        Flag = "JumpValue",
        Min = 50,
        Max = 500,
        Default = 100
    }, function(v)
        jumpValue = v
        if State.JumpEnabled then
            local hum = Services.LocalPlayer.Character
                and Services.LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum then
                hum.JumpPower  = v
                hum.JumpHeight = v / 2
            end
        end
    end)
end
