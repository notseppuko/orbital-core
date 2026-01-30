local function loadXan()
    local urls = {
        "https://xan.bar/init.lua",
        -- fallback mirrors (add more if needed)
        "https://raw.githubusercontent.com/xan-ui/xan/main/init.lua"
    }

    for _, url in ipairs(urls) do
        for i = 1, 3 do
            local ok, result = pcall(function()
                return loadstring(game:HttpGet(url))()
            end)

            if ok and type(result) == "table" and result.New then
                return result
            end

            task.wait(0.5)
        end
    end

    return nil
end

local UI = loadXan()
if not UI then
    warn("[Orbital] Failed to load Xan UI after retries")
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
