return function(ctx)
    local Players     = game:GetService("Players")
    local VirtualUser = game:GetService("VirtualUser")
    local LocalPlayer = Players.LocalPlayer
    local State       = ctx.State

    local afkConnection

    local function enable()
        if afkConnection then return end
        afkConnection = LocalPlayer.Idled:Connect(function()
            VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(0.1)
            VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    end

    local function disable()
        if afkConnection then
            afkConnection:Disconnect()
            afkConnection = nil
        end
    end

    -- UI FIRST (SAFE)
    local Tab = ctx.Window:AddTab("Misc", ctx.UI.Icons.Misc)
    Tab:AddSection("Utility")

    Tab:AddToggle("Anti-AFK", { Default = true }, function(v)
        State.AntiAFK = v
        if v then
            enable()
        else
            disable()
        end
    end)

    -- 🔑 DEFER EVENT CONNECTION (CRITICAL)
    State.AntiAFK = true
    task.defer(enable)
end
