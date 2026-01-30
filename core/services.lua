local Players     = game:GetService("Players")
local RunService  = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")

return {
    Players     = Players,
    RunService  = RunService,
    HttpService = HttpService,
    VirtualUser = VirtualUser,
    LocalPlayer = Players.LocalPlayer
}
