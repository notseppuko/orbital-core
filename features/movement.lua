return function(ctx)
    warn("[Orbital] Movement module executing")

    task.wait(0.2)

    local Window = ctx.Window
    local UI     = ctx.UI

    local Tab = Window:AddTab("DEBUG", UI.Icons.World)
    Tab:AddLabel("If you see this, features are loading")
end
