local UI = loadstring(game:HttpGet("https://xan.bar/init.lua"))()

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

local uiScale = Instance.new("UIScale")
uiScale.Scale = 1
uiScale.Parent = Window.Frame

return {
    UI = UI,
    Window = Window,
    UIScale = uiScale
}
