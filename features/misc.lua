return function(ctx)
    task.wait()

    local Window = ctx.Window
    local UI     = ctx.UI
    local State  = ctx.State

    local Players       = game:GetService("Players")
    local VirtualUser   = game:GetService("VirtualUser")
    local LocalPlayer   = Players.LocalPlayer

    local afkConnection = nil

    local function enableAntiAFK()
        if afkConnection then return end

        afkConnection = LocalPlayer.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(0.1)
        VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    end

    local function disableAntiAFK()
        if afkConnection then
            afkConnection:Disconnect()
            afkConnection = nil
        end
    end

    -- Default State
    State.AntiAFK = true
    enableAntiAFK()

    local Tab = ctx.Window:AddTab("Misc", ctx.UI.Icons.Misc)
    Misc:AddSection("Utility")
    
    Tab:AddToggle("Anti-AFK", {
        Default = true 
    }, function(enabled)
        ctx.State.AntiAFK = enabled

        if enabled then
            enableAntiAFK()
        else
            disableAntiAFK()
        end
    end)
end
