return function(ctx)
    local Services = ctx.Services
    local State    = ctx.State

    local speedFallback = 16
    local jumpFallback  = 100

    Services.LocalPlayer.CharacterAdded:Connect(function(char)
        local hum = char:WaitForChild("Humanoid")

        if State.SpeedEnabled then
            hum.WalkSpeed = speedFallback
        end

        if State.JumpEnabled then
            hum.JumpPower  = jumpFallback
            hum.JumpHeight = jumpFallback / 2
        end
    end)
end
