return function(ctx)
    task.wait()

    local Tab = ctx.Window:AddTab("Misc", ctx.UI.Icons.Misc)
    Tab:AddToggle("Anti-AFK", { Default = false }, function(v)
        ctx.State.AntiAFK = v
    end)
end
