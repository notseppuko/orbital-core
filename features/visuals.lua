return function(ctx)
    task.wait()

    local Tab = ctx.Window:AddTab("Visuals", ctx.UI.Icons.ESP)
    Tab:AddLabel("Visuals coming soon")
end
