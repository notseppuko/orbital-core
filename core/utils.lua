return function(ctx)
    local Services = ctx.Services
    local State    = ctx.State
    local UI       = ctx.UI

    Services.LocalPlayer.CharacterAdded:Connect(function(char)
        local hum = char:WaitForChild("Humanoid")
        task.wait()

        if State.SpeedEnabled then
            hum.WalkSpeed = UI.Get("SpeedValue") or 50
        end
        if State.JumpEnabled then
            local jp = UI.Get("JumpValue") or 100
            hum.JumpPower = jp
            hum.JumpHeight = jp / 2
        end
    end)
end
