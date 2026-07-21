local Players = game:GetService("Players")
local vu = game:GetService("VirtualUser")
local player = Players.LocalPlayer
player.Idled:Connect(function()
	vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	task.wait(1)
	vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
local games = {
    [3623096087] = "https://raw.githubusercontent.com/wayhead26-ops/script/refs/heads/main/Muscle%20Legend.lua",
    [4580204640] = "https://raw.githubusercontent.com/wayhead26-ops/script/refs/heads/main/Survive%20The%20Killer.lua"
}
if games[game.PlaceId] then
    return loadstring(game:HttpGet(games[game.PlaceId]))()
end
