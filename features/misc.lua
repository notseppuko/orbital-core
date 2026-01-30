return function(ctx)

    local Services    = ctx.Services
    local Players     = Services.Players
    local VirtualUser = Services.VirtualUser
    local LocalPlayer = Services.LocalPlayer

    local State = ctx.State
    local afkConnection

    local function enable()
        if afkConnection then return end
        afkConnection = LocalPlayer.Idled:Connect(function()
            VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end

    local function disable()
        if afkConnection then
            afkConnection:Disconnect()
            afkConnection = nil
        end
    end

    State.AntiAFK = true
    enable()

    local Tab = ctx.Window:AddTab("Misc", ctx.UI.Icons.Misc)
    Tab:AddSection("Utility")

    Tab:AddToggle("Anti-AFK", { Default = true }, function(v)
        State.AntiAFK = v
        if v then enable() else disable() end
    end)
end