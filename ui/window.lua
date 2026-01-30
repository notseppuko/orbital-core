local success, UI = pcall(function()
    return loadstring(game:HttpGet("https://xan.bar/init.lua"))()
end)

if not success or type(UI) ~= "table" or not UI.New then
    warn("[Orbital] Failed to load Xan UI")
    return nil
end

local Window = UI.New({
    Title = "ORBITAL CORE",
    Subtitle = "v0.1",
    Theme = "Midnight",
    Layout = "Default",
    Logo = "rbxassetid://139493874616030",
    ShowLogo = true,
    ShowUserInfo = true,
    ShowActiveList = false,
    ShowSettings = false,
    ConfigName = "orbital_defaultConfig",
})

local scale = Instance.new("UIScale")
scale.Scale = 1
scale.Parent = Window.Frame

return {
    UI = UI,
    Window = Window,
    UIScale = scale
}
