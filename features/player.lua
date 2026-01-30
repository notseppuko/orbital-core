return function(ctx)
    task.wait()

    local Tab = ctx.Window:AddTab("Player", ctx.UI.Icons.Player)
    Tab:AddLabel("Player tools coming soon")
end
