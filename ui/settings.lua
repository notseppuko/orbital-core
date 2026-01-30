return function(ctx)
    task.wait()

    local Window  = ctx.Window
    local UI      = ctx.UI
    local UIScale = ctx.UIScale

    local Settings = Window:AddTab("Settings", UI.Icons.Settings)

    Settings:AddDropdown("UI Scale", {
        Options = {"50%", "100%", "150%", "200%"},
        Default = "100%",
    }, function(v)
        UIScale.Scale = ({
            ["50%"]  = 0.5,
            ["100%"] = 1,
            ["150%"] = 1.5,
            ["200%"] = 2
        })[v]
    end)

    Settings:AddKeybind("Toggle Menu",
        { Default = Enum.KeyCode.RightShift },
        function() Window:Toggle() end
    )

    Settings:AddDangerButton({
        Name = "Unload Orbital",
        Callback = UI.Unload
    })
end
