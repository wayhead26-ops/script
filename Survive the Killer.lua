local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.Minus
})

local Tabs = {
    Main = Window:AddTab({Title = "Main", Icon = "home"}),
    Esp = Window:AddTab({Title = "Esp", Icon = "person-standing"}),
    Teleport = Window:AddTab({Title = "Teleport", Icon = "venetian-mask"}),
    Misc = Window:AddTab({Title = "Misc", Icon = "more-horizontal"}),
    Settings = Window:AddTab({Title = "Settings", Icon = "settings"})}

----------------------------------function
local PlayerList = {}
for _, v in pairs(game.Teams.Survivor:GetPlayers()) do
    if v ~= game.Players.LocalPlayer then
        table.insert(PlayerList, v.Name)
    end
end
local plr = {}
for i, v in pairs(game.Players:GetPlayers()) do
    if v ~= game.Players.LocalPlayer then
        table.insert(plr, v.Name)
    end
end
-------------------------
local Noclip = nil
local Clip = nil

function noclip()
	Clip = false
	local function Nocl()
		if Clip == false and game.Players.LocalPlayer.Character ~= nil then
			for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
				if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
					v.CanCollide = false
				end
			end
		end
		wait(0.21)
	end
	Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
end

function clip()
	if Noclip then Noclip:Disconnect() end
	Clip = true
end
--------------------------
local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
ESP:Toggle(true)
ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false
ESP.Players = false
ESP.TeamColor = false
local setheal = false

--------------------------------------
Tabs.Main:AddToggle("Auto Escape", {
    Title = "Toggle Escape",
    Description = "Auto Exit",
    Default = false,
    Callback = function(v)
        getgenv().win = v
        while getgenv().win do
            wait(0.5)
            if game.Players.LocalPlayer.Team == game.Teams.Survivor then
                for i, v in pairs(game.Workspace:GetDescendants()) do
                    if v:FindFirstChild("ExitIcon") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                        for i, c in pairs(game.Workspace:GetDescendants()) do
                            if c.ClassName == "Folder" and c.Name == "Exits" then
                                for i, b in pairs(c:GetDescendants()) do
                                    if b.Name == "Trigger" then
                                        game.Players.LocalPlayer.Character.Humanoid.Sit = false
                                        game.Players.LocalPlayer.Character.HumanoidRootPart:PivotTo(CFrame.new(b:GetPivot().Position)*CFrame.new(0,0,0))
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
})

Tabs.Main:AddToggle("Auto Collect Loot", {
    Title = "Toggle Collect Loot",
	Description = "Collect All Loot In Map",
    Default = false,
    Callback = function(v)
        getgenv().loot = v
        while getgenv().loot do
            wait(0.2)
            if not setheal then
                for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
                    if v.Name == "LootSpawns" then
                        for i,b in pairs(v:GetDescendants()) do
                            if b:IsA('MeshPart') or b:IsA("Part") then
                                if b.Transparency ~= 1 and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Team == game:GetService('Teams').Survivor then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart:PivotTo(CFrame.new(b:GetPivot().Position)*CFrame.new(0,4,0))
                                end
                            end
                        end
                    end
                end
                for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
                    if v.Name == "LootSpawns" and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
    	                for i,b in pairs(v:GetDescendants()) do
			                if b.Name == "TouchInterest" and b.Parent then
				                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - b.Parent.Position).Magnitude < 7 then
				                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, b.Parent, 0)
				                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, b.Parent, 1)
				                end
			                end
		                end 
                    end
                end
            end
        end
    end
})

Tabs.Main:AddToggle("Auto Remove Trap", {
    Title = "Toggle Remove Trap",
	Description = "Remove All Killer Trap",
    Default = false,
    Callback = function(v)
        getgenv().removetrap = v
        while getgenv().removetrap do
			wait(0.7)
			for i,v in pairs(game.Workspace:GetDescendants()) do
				if v.Name == "Trap" or v.Name == "RatTraps" then
					v:Destroy()
				end
			end
		end
    end
})

Tabs.Main:AddParagraph({
    Title = "Survivor Section",
})
Tabs.Main:AddToggle("AUto Heal", {
    Title = "Toggle Heal",
	Description = "Heal Yourself When Get Caught",
    Default = false,
    Callback = function(v)
        getgenv().revivelocalplayer = v
        while getgenv().revivelocalplayer do
            wait()
            if game.Players.LocalPlayer.Team == game:GetService('Teams').Survivor then
                for i, v in pairs(game.Players:GetPlayers()) do
                    if v.Team == game:GetService('Teams').Survivor and v ~= game.Players.LocalPlayer and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        if game:GetService('Workspace')[game.Players.LocalPlayer.Name].HumanoidRootPart.BleedOutHealth.Enabled == true and not v.Character.HumanoidRootPart.BleedOutHealth.Enabled == true and game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart') then
                            game.Players.LocalPlayer.Character.HumanoidRootPart:PivotTo(CFrame.new(v.Character.HumanoidRootPart:GetPivot().Position)*CFrame.new(0,3,0))
                        end
                    end
                end
            end
        end
    end
})

Tabs.Main:AddSlider("Distance Player", {
    Title = "Set Distance Other Player From Killer",
    Default = 26,
    Min = 15,
    Max = 100,
    Rounding = 1,
    Callback = function(v)
        setdistancerevive = tonumber(v)
    end
})

Tabs.Main:AddToggle("Auto Revive Player Toggle", {
    Title = "Toggle Heal Player",
	Description = "Heal Others Players",
    Default = false,
    Callback = function(v)
        getgenv().reviveplayer = v
        while getgenv().reviveplayer do
            wait()
            if game.Players.LocalPlayer.Team == game.Teams.Survivor then
                for i, v in pairs(game.Teams.Survivor:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                            if v.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth").Enabled == true and v.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth").BleedProgress.KillerTooClose.Visible == false then
                                setheal = true
                                for i, b in pairs(game.Teams.Killer:GetPlayers()) do
                                    if b ~= game.Players.LocalPlayer then
                                        if b.Character and b.Character:FindFirstChild("HumanoidRootPart") then
                                            if (v.Character.HumanoidRootPart.Position - b.Character.HumanoidRootPart.Position).Magnitude >= setdistancerevive then
                                                game.Players.LocalPlayer.Character.Humanoid.Sit = false
                                                game.Players.LocalPlayer.Character.HumanoidRootPart:PivotTo(CFrame.new(v.Character.HumanoidRootPart:GetPivot().Position)*CFrame.new(0,2,0))
                                            end
                                        end
                                    end
                                end
                            elseif v.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth").Enabled == false then
                                    setheal = false
                            end
                        end
                    end
                end
            end
        end
    end
})

Tabs.Main:AddSlider("Safe Teleport", {
    Title = "Set Distance From Killer",
    Default = 26,
    Min = 15,
    Max = 100,
    Rounding = 1,
    Callback = function(v)
        setdistance = tonumber(v)
    end
})

Tabs.Main:AddToggle("Auto Safe Teleport Toggle", {
    Title = "Toggle Safe Place",
	Description = "Teleport To Safe Place When Killer Is Nearby",
    Default = false,
    Callback = function(v)
        getgenv().safetp = v
        while getgenv().safetp do
            wait()
            if game.Players.LocalPlayer.Team == game.Teams.Survivor then
                for i, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer and v.Team == game.Teams.Killer and
                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart') then
                        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                            if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= setdistance then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5.3338666, 260.340942, -10.7234116, -0.156752154, 2.6554325e-08, 0.987637997, 8.19734609e-08, 1, -1.38763481e-08, -0.987637997, 7.87849572e-08, -0.156752154)
                            end
                        end
                    end
                end
            end
        end
    end
})

Tabs.Main:AddParagraph({
    Title = "Killer Section",
})

local Killone = Tabs.Main:AddDropdown("Killselectedplayer", {
    Title = "Kill Selected Player",
    Description = "Select Player To Kill",
    Values = PlayerList,
    Multi = false,
    Default = nil,
    Callback = function(selectkillplr)
        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Name == selectkillplr and game.Players.LocalPlayer.Team == game.Teams.Killer and v.Team == game.Teams.Survivor and game.Players.LocalPlayer.Character:FindFirstChild("Knife") and game.Players.LocalPlayer.Character.Knife:FindFirstChild("KnifeAttachment") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    firetouchinterest(v.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.Knife.KnifeAttachment, 0)
                    firetouchinterest(v.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.Knife.KnifeAttachment, 1)
                end
            end
        end
    end
})

Tabs.Main:AddToggle("Kill All Toggle", {
    Title = "Toggle Kill All",
	Description = "Auto Kill All Player When Become A Killer",
    Default = false,
    Callback = function(v)
        getgenv().kill = v
        while getgenv().kill do
            wait()
            for i, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and game.Players.LocalPlayer.Team == game.Teams.Killer and v.Team == game.Teams.Survivor and game.Players.LocalPlayer.Character:FindFirstChild("Knife") and game.Players.LocalPlayer.Character.Knife:FindFirstChild("KnifeAttachment") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        firetouchinterest(v.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.Knife.KnifeAttachment, 0)
                        firetouchinterest(v.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.Knife.KnifeAttachment, 1)
                    end
                end
            end
        end
    end
})

Tabs.Main:AddSlider("Slash Aura Distances", {
    Title = "Slash Aura Distance",
    Default = 20,
    Min = 5,
    Max = 100,
    Rounding = 1,
    Callback = function(v)
        setstab = tonumber(v)
    end
})

Tabs.Main:AddToggle("Slash Aura Toggle", {
    Title = "Toggle Slash Aura",
	Description = "Slash When Player Is Near You",
	CurrentValue = false,
	Callback = function(v)
		getgenv().stab = v
        while getgenv().stab do
            wait()
            for i, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and game.Players.LocalPlayer.Team == game.Teams.Killer and v.Team == game.Teams.Survivor and game.Players.LocalPlayer.Character:FindFirstChild("Knife") and game.Players.LocalPlayer.Character.Knife:FindFirstChild("KnifeAttachment") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    if game.Players.LocalPlayer.Character.Knife.KnifeAttachment:FindFirstChild("Slash") then
                        if game.Players.LocalPlayer.Character.Knife.KnifeAttachment.Slash.Playing == true then
                            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                                if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < setstab then
                                    firetouchinterest(v.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.Knife.KnifeAttachment, 0)
                                    firetouchinterest(v.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.Knife.KnifeAttachment, 1)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
})
Tabs.Main:AddSlider("Slash Distance", {
    Title = "Kill Aura Distance",
    Default = 20,
    Min = 5,
    Max = 100,
    Rounding = 1,
    Callback = function(v)
        setaura = tonumber(v)
    end
})
Tabs.Main:AddToggle("Kill Aura Toggle", {
    Title = "Toggle Kill Aura",
	Description = "Kill When Player Is Near You",
	CurrentValue = false,
	Callback = function(v)
		getgenv().killaura = v
        while getgenv().killaura do
            wait()
            for i, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and game.Players.LocalPlayer.Team == game.Teams.Killer and v.Team == game.Teams.Survivor and game.Players.LocalPlayer.Character:FindFirstChild("Knife") and game.Players.LocalPlayer.Character.Knife:FindFirstChild("KnifeAttachment") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < setaura then
                            firetouchinterest(v.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.Knife.KnifeAttachment, 0)
                            firetouchinterest(v.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.Knife.KnifeAttachment, 1)
                        end
                    end
                end
            end
        end
    end
})

Tabs.Esp:AddToggle("Esp Players", {
    Title = "Enable Esp",
    Default = false,
    Callback = function(v)
        ESP.Players = v
    end
})

Tabs.Esp:AddToggle("Esp Name", {
    Title = "Player Name",
    Default = false,
    Callback = function(v)
        ESP.Names = v
    end
})

Tabs.Esp:AddToggle("Esp Tracer", {
    Title = "Player Tracer",
    Default = false,
    Callback = function(v)
        ESP.Tracers = v
    end
})

Tabs.Esp:AddToggle("Esp Boxes", {
    Title = "Player Box",
    Default = false,
    Callback = function(v)
        ESP.Boxes = v
    end
})

Tabs.Esp:AddToggle("Esp Teamcolor", {
    Title = "Player TeamColor",
    Default = false,
    Callback = function(v)
        ESP.TeamColor = v
    end
})

Tabs.Esp:AddColorpicker("Esp ColorPick", {
    Title = "Esp Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(v)
        ESP.Color = v
    end
})

Tabs.Teleport:AddButton({
    Title = "Teleport Cabin",
    Callback = function()
        for i, v in pairs(game:GetService("Workspace")._Lobby.Cabins:GetChildren()) do
            if v.Name == game.Players.LocalPlayer.Name then
                for i, b in pairs(v:GetChildren()) do
                    if b.Name == "Spawn" then
                        game.Players.LocalPlayer.Character.PrimaryPart.CFrame = b.CFrame
                    end
                end
            end
        end
    end
})

Tabs.Teleport:AddButton({
    Title = "Teleport Lobby",
    Callback = function()
        game.Players.LocalPlayer.Character.PrimaryPart.CFrame = game:GetService("Workspace")._Lobby.Spawns.SpawnLocation.CFrame
    end
})

Tabs.Teleport:AddButton({
    Title = "Teleport Map",
    Callback = function()
        for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("Folder") and v.Name == "SurvivorSpawns" then
                for i, c in pairs(v:GetChildren()) do
                    if c.Name == "Spawn" then
                        game.Players.LocalPlayer.Character.PrimaryPart.CFrame = c.CFrame
                    end
                end
            end
        end
    end
})

Tabs.Teleport:AddButton({
    Title = "Teleport Killer",
    Callback = function()
        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Team == game.Teams.Killer then
                game.Players.LocalPlayer.Character.PrimaryPart.CFrame = v.Character.HumanoidRootPart.CFrame
            end
        end
    end
})

local Playerlist = Tabs.Teleport:AddDropdown("Player Dropdown Teleport", {
    Title = "Teleport Selected Player",
    Values = plr,
    Multi = false,
    Default = nil,
    Callback = function(v)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[v].Character.HumanoidRootPart.CFrame
    end
})

Tabs.Misc:AddToggle("Noclip Toggle", {
    Title = "Toggle Noclip",
    Default = false,
    Callback = function(v)
        getgenv().noclip = v
        game:GetService("RunService").RenderStepped:Connect(function()
            if getgenv().noclip then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide == true and v.Name ~= floatName then
                        v.CanCollide = false
                        if not getgenv().noclip then
                            v.CanCollide = true
                        end
                    end
                end
            end
        end)
    end
})
Tabs.Misc:AddToggle("xray toggle", {
    Title = "Toggle Xray",
    Default = false,
    Callback = function(v)
        if v then
            for _, i in pairs(workspace:GetDescendants()) do
                if i:IsA("BasePart") and not i.Parent:FindFirstChildOfClass('Humanoid') and
                    not i.Parent.Parent:FindFirstChildOfClass('Humanoid') then
                    i.LocalTransparencyModifier = 0.5
                end
            end
        else
            for _, i in pairs(workspace:GetDescendants()) do
                if i:IsA("BasePart") and not i.Parent:FindFirstChildOfClass('Humanoid') and
                    not i.Parent.Parent:FindFirstChildOfClass('Humanoid') then
                    i.LocalTransparencyModifier = 0
                end
            end
        end
    end
})

Tabs.Misc:AddToggle("spec killer", {
    Title = "Spectate Killer",
    Default = false,
    Callback = function(v)
        getgenv().spec = v
        while getgenv().spec do
            wait()
            for i, v in pairs(game.Players:GetPlayers()) do
                if v.Team == game.Teams.Killer then
                    repeat wait()
                        workspace.Camera.CameraSubject = v.Character
                    until v.Team == game.Teams.Lobby or not getgenv().spec
                    workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character
                end
            end
        end
    end
})

Tabs.Misc:AddSlider("Slider", {
    Title = "Set WalkSpeed",
    Default = 16,
    Min = 16,
    Max = 500,
    Rounding = 1,
    Callback = function(v)
        walkspeed = tonumber(v)
    end
})

Tabs.Misc:AddToggle("ws toggle", {
    Title = "Toggle Walkspeed",
    Default = false,
    Callback = function(v)
        getgenv().ws = v
        while getgenv().ws do
            wait()
            if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkspeed
                if not getgenv().ws then
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
                end
            end
        end
    end
})

Tabs.Misc:AddToggle("inf jump", {
    Title = "Toggle Inf Jump",
    Default = false,
    Callback = function(v)
        getgenv().infjump = v
        game:GetService("UserInputService").JumpRequest:connect(function()
            if getgenv().infjump then
                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(
                    "Jumping")
            end
        end)
    end
})

Tabs.Misc:AddButton({
    Title = "Rejoin",
    Callback = function()
        local ts = game:GetService("TeleportService")
        local p = game:GetService("Players").LocalPlayer
        ts:Teleport(game.PlaceId, p)
    end
})

Tabs.Misc:AddToggle("autorj", {
    Title = "Auto Rejoin",
    Default = true,
    Callback = function(v)
        getgenv().aj = v
        game:GetService("GuiService").ErrorMessageChanged:Connect(function()
            if getgenv().aj then
                wait()
                game:GetService("TeleportService"):Teleport(game.PlaceId)
            end
        end)
    end
})
Tabs.Misc:AddButton({
    Title = "ServerHop",
    Callback = function()
        HttpService = game:GetService("HttpService")
        TeleportService = game:GetService("TeleportService")
        httprequest = (syn and syn.request) or (http and http.request) or http_request or
            (fluxus and fluxus.request) or request
        PlaceId, JobId = game.PlaceId, game.JobId
        if httprequest then
            local servers = {}
            local body = HttpService:JSONDecode(httprequest({
                Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100",
                    game.PlaceId)
            }).Body)
            if body and body.data then
                for i, v in next, body.data do
                    if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing <
                        v.maxPlayers and v.id ~= JobId then
                        table.insert(servers, 1, v.id)
                    end
                end
            end
            if #servers > 0 then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)],
                    game.Players.LocalPlayer)
            end
        end
    end
})

Tabs.Misc:AddButton({
    Title = "Teleport To Small Server",
    Description = "Server Hop Small Server",
    Callback = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/"
        local _place = game.PlaceId
        local _servers = Api .. _place .. "/servers/Public?sortOrder=Asc&limit=100"
        function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor=" .. cursor) or ""))
            return Http:JSONDecode(Raw)
        end
        local Server, Next;
        repeat
            local Servers = ListServers(Next)
            Server = Servers.data[6]
            Next = Servers.nextPageCursor
        until Server
        TPS:TeleportToPlaceInstance(_place, Server.id, game.Players.LocalPlayer)
    end
})

Tabs.Misc:AddToggle("Fullbright", {
    Title = "Toggle FullBright",
	Description = "Make Map Bright",
	CurrentValue = false,
	Callback = function(v)
		if not _G.FullBrightExecuted then

	_G.FullBrightEnabled = false

	_G.NormalLightingSettings = {
		Brightness = game:GetService("Lighting").Brightness,
		ClockTime = game:GetService("Lighting").ClockTime,
		FogEnd = game:GetService("Lighting").FogEnd,
		GlobalShadows = game:GetService("Lighting").GlobalShadows,
		Ambient = game:GetService("Lighting").Ambient
	}

	game:GetService("Lighting"):GetPropertyChangedSignal("Brightness"):Connect(function()
		if game:GetService("Lighting").Brightness ~= 1 and game:GetService("Lighting").Brightness ~= _G.NormalLightingSettings.Brightness then
			_G.NormalLightingSettings.Brightness = game:GetService("Lighting").Brightness
			if not _G.FullBrightEnabled then
				repeat
					wait()
				until _G.FullBrightEnabled
			end
			game:GetService("Lighting").Brightness = 1
		end
	end)

	game:GetService("Lighting"):GetPropertyChangedSignal("ClockTime"):Connect(function()
		if game:GetService("Lighting").ClockTime ~= 12 and game:GetService("Lighting").ClockTime ~= _G.NormalLightingSettings.ClockTime then
			_G.NormalLightingSettings.ClockTime = game:GetService("Lighting").ClockTime
			if not _G.FullBrightEnabled then
				repeat
					wait()
				until _G.FullBrightEnabled
			end
			game:GetService("Lighting").ClockTime = 12
		end
	end)

	game:GetService("Lighting"):GetPropertyChangedSignal("FogEnd"):Connect(function()
		if game:GetService("Lighting").FogEnd ~= 786543 and game:GetService("Lighting").FogEnd ~= _G.NormalLightingSettings.FogEnd then
			_G.NormalLightingSettings.FogEnd = game:GetService("Lighting").FogEnd
			if not _G.FullBrightEnabled then
				repeat
					wait()
				until _G.FullBrightEnabled
			end
			game:GetService("Lighting").FogEnd = 786543
		end
	end)

	game:GetService("Lighting"):GetPropertyChangedSignal("GlobalShadows"):Connect(function()
		if game:GetService("Lighting").GlobalShadows ~= false and game:GetService("Lighting").GlobalShadows ~= _G.NormalLightingSettings.GlobalShadows then
			_G.NormalLightingSettings.GlobalShadows = game:GetService("Lighting").GlobalShadows
			if not _G.FullBrightEnabled then
				repeat
					wait()
				until _G.FullBrightEnabled
			end
			game:GetService("Lighting").GlobalShadows = false
		end
	end)

	game:GetService("Lighting"):GetPropertyChangedSignal("Ambient"):Connect(function()
		if game:GetService("Lighting").Ambient ~= Color3.fromRGB(178, 178, 178) and game:GetService("Lighting").Ambient ~= _G.NormalLightingSettings.Ambient then
			_G.NormalLightingSettings.Ambient = game:GetService("Lighting").Ambient
			if not _G.FullBrightEnabled then
				repeat
					wait()
				until _G.FullBrightEnabled
			end
			game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
		end
	end)

	game:GetService("Lighting").Brightness = 1
	game:GetService("Lighting").ClockTime = 12
	game:GetService("Lighting").FogEnd = 786543
	game:GetService("Lighting").GlobalShadows = false
	game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)

	local LatestValue = true
	spawn(function()
		repeat
			wait()
		until _G.FullBrightEnabled
		while wait() do
			if _G.FullBrightEnabled ~= LatestValue then
				if not _G.FullBrightEnabled then
					game:GetService("Lighting").Brightness = _G.NormalLightingSettings.Brightness
					game:GetService("Lighting").ClockTime = _G.NormalLightingSettings.ClockTime
					game:GetService("Lighting").FogEnd = _G.NormalLightingSettings.FogEnd
					game:GetService("Lighting").GlobalShadows = _G.NormalLightingSettings.GlobalShadows
					game:GetService("Lighting").Ambient = _G.NormalLightingSettings.Ambient
				else
					game:GetService("Lighting").Brightness = 1
					game:GetService("Lighting").ClockTime = 12
					game:GetService("Lighting").FogEnd = 786543
					game:GetService("Lighting").GlobalShadows = false
					game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
				end
				LatestValue = not LatestValue
			end
		end
	end)
end

_G.FullBrightExecuted = v
_G.FullBrightEnabled = not _G.FullBrightEnabled
    end
})

Tabs.Misc:AddButton({
    Title = "Less Lagging",
    Callback = function()
        local mx = game.Debris
        local mx3 = game.Debris.MaxItems
        if (mx.MaxItems > 9999999999) then
            mx.MaxItems = mx3 * .9999999999
        end
        wait()
        setfpscap(1000)
    end
})

--plr update
game.Players.PlayerAdded:Connect(function(PlayerAdd)
    if PlayerAdd ~= game.Players.LocalPlayer then
        table.insert(plr, PlayerAdd.Name)
        Playerlist:SetValues()
    end
end)

game.Players.PlayerRemoving:Connect(function(PlayerRem)
    for index, playerName in pairs(plr) do
        if playerName == PlayerRem.Name then
            table.remove(plr, index)
        end
    end
    Playerlist:SetValues()
end)

--survivorupdatekill
game.Teams.Survivor.PlayerAdded:Connect(function(PlayerAdded)
    if PlayerAdded ~= game.Players.LocalPlayer then
        table.insert(PlayerList, PlayerAdded.Name)
        Killone:SetValues()
    end
end)

game.Teams.Survivor.PlayerRemoved:Connect(function(PlayerRemoving)
    for index, playerName in pairs(PlayerList) do
        if playerName == PlayerRemoving.Name then
            table.remove(PlayerList, index)
        end
    end
    Killone:SetValues()
end)
-- config
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
InterfaceManager:SetFolder("Folder")
SaveManager:SetFolder("Folder/GameFolder")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
SaveManager:LoadAutoloadConfig()
