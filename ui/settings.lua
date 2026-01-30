return function(ctx)
    task.wait(0.15)
    
    if not ctx or not ctx.Window or not ctx.UI then
        return
    end

    local Window  = ctx.Window
    local UI      = ctx.UI
    local UIScale = ctx.UIScale
    local Build   = ctx.Build

    local Settings = Window:AddTab("Settings", UI.Icons.Settings)
    if not Settings then return end
    
    -- SECTION: INFO 
    Settings:AddSection("Build Info")

    Settings:AddLabel("Version: " .. (Build.Version or "unknown"))
    Settings:AddLabel("Branch: " .. (Build.Branch or "unknown"))
    Settings:AddLabel("Status: " .. (Build.Status or "unknown"))

    -- SECTION: UI
    Settings:AddDivider()
    Settings:AddSection("UI")

    Settings:AddDropdown("UI Scale", {
        Options = {"50%", "100%", "150%", "200%"},
        Default = "100%",
    }, function(v)
        UIScale.Scale = ({
            ["50%"]=0.5, ["100%"]=1, ["150%"]=1.5, ["200%"]=2
        })[v]
    end)
    

-- SECTION: CONFIG
Settings:AddDivider()
Settings:AddSection("Config")

Settings:AddButton("Save Config", function()
    local success = ctx.Config:Save(ctx, "default")

    if success then
        warn("[Orbital] Config saved")
    else
        warn("[Orbital] Failed to save config")
    end
end)

-- SECTION: CONTROLS
Settings:AddDivider()
Settings:AddSection("Controls")

    Settings:AddKeybind("Toggle Menu",
        { Default = Enum.KeyCode.RightShift },
        function() Window:Toggle() end
    )

    Settings:AddDangerButton({
        Name = "Unload Orbital",
        Callback = UI.Unload
    })
end


