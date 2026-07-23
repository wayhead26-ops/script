if game.PlaceId == 4580204640 then
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
elseif game.PlaceId == 3623096087 then
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua", true))()
local Window = Luna:CreateWindow({
	Name = tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
	Subtitle = "AireszHub",
	LogoID = "82795327169782",
	LoadingEnabled = true,
	LoadingTitle = tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
	LoadingSubtitle = "AireszHub",

	ConfigSettings = {
		RootFolder = nil,
		ConfigFolder = "Airesz Hub"
	},

	KeySystem = false,
	KeySettings = {
		Title = "AireszHub",
		Subtitle = "Key System",
		Note = "",
		SaveInRoot = false,
		SaveKey = true,
		Key = {"12333333"},
		SecondAction = {
			Enabled = true,
			Type = "Link",
			Parameter = "https://direct-link.net/464933/wGO8yDYW4cQd"
		}
	}
})

Window:CreateHomeTab({
	SupportedExecutors = {
		"Synapse X",
		"Krnl",
		"ProtoSmasher",
		"Fluxus",
		"Script-Ware",
		"EasyExploits",
		"Electron",
		"JJSploit",
		"Calamari",
		"SirHurt",
		"Sentinel",
		"WEAREDEVS",
		"Comet",
		"Cellery",
		"Wave",
		"CODex",
		"Delta"
	},
	DiscordInvite = "5hazzAq7B",
	Icon = 1
})
---function
local part = Instance.new("Part")
part.Parent = game.Workspace
part.Name = "KIllAllPart"
part.Position = Vector3.new(0, 10000, 0)
part.Size = Vector3.new(1000, 10, 1000)
part.Anchored = true
--------------------------------
local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
ESP:Toggle(true)
ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false
ESP.Players = false
ESP.Color = Color3.fromRGB(255, 255, 255)
--------------------------------
function gettool()
    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end
--------------------------------
function getgui()
    for i, v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
        if v.Name == "machineGui" and v.Enabled == true then
            firesignal(v.interactButton.Activated)
        end
    end
end
function firetool()
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
end
--------------------------------
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
		wait(0.21) -- basic optimization
	end
	Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
end

function clip()
	if Noclip then Noclip:Disconnect() end
	Clip = true
end
-----------------------------------tab
local Tab = Window:CreateTab({
	Name = "Main",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true
})

Tab:CreateDropdown({
	Name = "Select Workout Tool",
	Description = nil,
	Options = {
		"Weight", "Situps", "Pushups", "Handstands"
	},
	CurrentOption = {"Weight"},
	MultipleOptions = false,
	SpecialType = nil,
	Callback = function(v)
		selectool = v
	end
})

Tab:CreateToggle({
	Name = "Toggle Workout",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().farm = v
        while getgenv().farm do
            wait()
            if selectool == "Weight" then
                repeat
                    wait()
                    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if v.Name == "Weight" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                        end
                    end
                    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                until selectool ~= "Weight" or not getgenv().farm
                if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                    game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                end
            elseif selectool == "Situps" then
                repeat
                    wait()
                    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if v.Name == "Situps" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                        end
                    end
                    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                until selectool ~= "Situps" or not getgenv().farm
                if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                    game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                end
            elseif selectool == "Pushups" then
                repeat
                    wait()
                    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if v.Name == "Pushups" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                        end
                    end
                    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                until selectool ~= "Pushups" or not getgenv().farm
                if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                    game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                end
            elseif selectool == "Handstands" then
                repeat
                    wait()
                    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if v.Name == "Handstands" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                        end
                    end
                    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                until selectool ~= "Handstands" or not getgenv().farm
                if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                    game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                end
            end
        end
        if not getgenv().farm then
            if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
            end
        end
	end
})

Tab:CreateToggle({
	Name = "Toggle Anti Disturb",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().safeplace = v
        while getgenv().safeplace do
            wait()
            if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                    CFrame.new(39.9269371, 10008.2969, 406.421783, 0.916920781, 7.09838588e-08, 0.39906922,
                        -5.21853707e-08, 1, -5.79699098e-08, -0.39906922, 3.23282414e-08, 0.916920781)
            end
            if not getgenv().safeplace then
                if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.seaPart.CFrame
                end
            end
        end
	end
})

Tab:CreateDivider()

Tab:CreateToggle({
	Name = "Toggle Rebirth",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().rebirth = v
        while getgenv().rebirth do
            wait()
            game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
        end
	end
})

Tab:CreateToggle({
	Name = "Toggle Brawl",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().joinbrawl = v
        while getgenv().joinbrawl do
            wait()
            game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer("joinBrawl")
        end
	end
})

Tab:CreateDivider()

Tab:CreateToggle({
	Name = "Toggle Kill All",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().killall = v
        while getgenv().killall do
            wait()
            for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                end
            end
            for i, v in pairs(game:GetService("Players"):GetPlayers()) do
                if v ~= game.Players.LocalPlayer then 
                    if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(39.9269371, 10008.2969, 406.421783, 0.916920781, 7.09838588e-08, 0.39906922,-5.21853707e-08, 1, -5.79699098e-08, -0.39906922, 3.23282414e-08, 0.916920781)
                        firetouchinterest(v.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.LeftHand,0)
                        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
                        firetouchinterest(v.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.LeftHand,1)
                        firetouchinterest(v.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.RightHand,0)
                        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
                        firetouchinterest(v.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.RightHand,1)
                        if not getgenv().killall then
                            game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                            CFrame.new(-0.413686246, 3.67686582, 194.919067, 0.976406693, -1.59392535e-08, -0.21593973,1.45404284e-08, 1, -8.06651812e-09, 0.21593973, 4.73634643e-09, 0.976406693)
                        end
                    end
                end
            end
        end
	end
})

Tab:CreateSlider({
	Name = "Kill Aura Range",
	Range = {0, 20000},
	Increment = 1,
	CurrentValue = 25,
	Callback = function(v)
		setaura = tonumber(v)
	end
})

Tab:CreateToggle({
	Name = "Toggle Kill Aura",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().killaura = v
        while getgenv().killaura do
            wait()
            for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                end
            end
            for i, v in pairs(game:GetService("Players"):GetPlayers()) do
                if v ~= game.Players.LocalPlayer then 
                    if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < setaura then
                        firetouchinterest(v.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.LeftHand,0)
                        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
                        firetouchinterest(v.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.LeftHand,1)
                        firetouchinterest(v.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.RightHand,0)
                        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
                        firetouchinterest(v.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.RightHand,1)
                        if not getgenv().killall then
                            game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                            end
                        end
                    end
                end
            end
        end
	end
})

local WorkoutTab = Window:CreateTab({
	Name = "Gym",
	Icon = "view_stream",
	ImageSource = "Material",
	ShowTitle = true
})

WorkoutTab:CreateDropdown({
	Name = "Select Rock",
	Description = nil,
	Options = {
		"Tiny Island Rock", "Punching Rock", "Large Rock", "Golden Rock", "Frost Rock", "Mystic Rock",
        "Inferno Rock", "Legend Rock", "Muscle King Rock", "Ancient Jungle Rock"
	},
	CurrentOption = {"Tiny Island Rock"},
	MultipleOptions = false,
	SpecialType = nil,
	Callback = function(v)
		selectrock = v
	end
})

WorkoutTab:CreateToggle({
	Name = "Toggle Rock",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().farmrock = v
        while getgenv().farmrock do
            wait()
            if selectrock == "Tiny Island Rock" and game:GetService("Players").LocalPlayer.Durability.Value >= 0 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 0 and
                        game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and
                        game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            1)
                        gettool()
                    end
                end
            elseif selectrock == "Punching Rock" and game:GetService("Players").LocalPlayer.Durability.Value >=
                10 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 10 and
                        game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and
                        game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            1)
                        gettool()
                    end
                end
            elseif selectrock == "Large Rock" and game:GetService("Players").LocalPlayer.Durability.Value >=
                100 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 100 and
                        game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and
                        game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            1)
                        gettool()
                    end
                end
            elseif selectrock == "Golden Rock" and game:GetService("Players").LocalPlayer.Durability.Value >=
                5000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 5000 and
                        game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and
                        game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            1)
                        gettool()
                    end
                end
            elseif selectrock == "Frost Rock" and game:GetService("Players").LocalPlayer.Durability.Value >=
                150000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 150000 and
                        game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and
                        game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            1)
                        gettool()
                    end
                end
            elseif selectrock == "Mystic Rock" and game:GetService("Players").LocalPlayer.Durability.Value >=
                400000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 400000 and
                        game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and
                        game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            1)
                        gettool()
                    end
                end
            elseif selectrock == "Inferno Rock" and game:GetService("Players").LocalPlayer.Durability.Value >=
                750000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 750000 and
                        game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and
                        game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            1)
                        gettool()
                    end
                end
            elseif selectrock == "Legend Rock" and game:GetService("Players").LocalPlayer.Durability.Value >=
                1000000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 1000000 and
                        game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and
                        game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            1)
                        gettool()
                    end
                end
            elseif selectrock == "Muscle King Rock" and game:GetService("Players").LocalPlayer.Durability.Value >=
                5000000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 5000000 and
                        game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and
                        game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            1)
                        gettool()
                    end
                end
            elseif selectrock == "Ancient Jungle Rock" and game:GetService("Players").LocalPlayer.Durability.Value >=
                10000000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 10000000 and
                        game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and
                        game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand,
                            1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand,
                            1)
                        gettool()
                    end
                end
            end
        end
        if not getgenv().farmrock then
            if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
            end
        end
	end
})

WorkoutTab:CreateDivider()

WorkoutTab:CreateDropdown({
	Name = "Select DeadLift",
	Description = nil,
	Options = {
		"Beach Deadlift", "Frost Lift", "Legend Lift", "Muscle King Lift" , "Jungle Bar Lift"
	},
	CurrentOption = {"Beach Deadlift"},
	MultipleOptions = false,
	SpecialType = nil,
	Callback = function(v)
		selectrocselectliftk = v
	end
})

WorkoutTab:CreateToggle({
	Name = "Toggle DeadLift",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().lift = v
        while getgenv().lift do
            wait()
            if selectlift == "Beach Deadlift" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and
                game:GetService("Players").LocalPlayer.leaderstats.Strength.Value > 8000 then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(67.0421143, 26.5049896, -494.215057, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                    getgui()
                    firetool()
                until selectlift ~= "Beach Deadlift" or not getgenv().lift
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectlift == "Frost Lift" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and
                game:GetService("Players").LocalPlayer.leaderstats.Strength.Value > 5000 then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2917.47168, 30.3400383, -209.563873, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                    getgui()
                    firetool()
                until selectlift ~= "Frost Lift" or not getgenv().lift
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectlift == "Legend Lift" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4532.21777, 1012.49097, -4002.71216, 0.642763317, -0, -0.766064942, 0, 1, -0, 0.766064942, 0, 0.642763317)
                    getgui()
                    firetool()
                until selectlift ~= "Legend Lift" or not getgenv().lift
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectlift == "Muscle King Lift" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8772.9707, 39.1909523, -5663.5625, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                    getgui()
                    firetool()
                until selectlift ~= "Muscle King Lift" or not getgenv().lift
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectlift == "Jungle Bar Lift" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and
                game:GetService("Players").LocalPlayer.leaderstats.Strength.Value > 100000 and game:GetService("ReplicatedStorage").muscleKing.Value == game.Players.LocalPlayer then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8652.86719, 29.2667427, 2089.26172, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                    getgui()
                    firetool()
                until selectlift ~= "Jungle Bar Lift" or not getgenv().lift
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            end
        end
	end
})

WorkoutTab:CreateDivider()

WorkoutTab:CreateDropdown({
	Name = "Select SquatRack",
	Description = nil,
	Options = {
		"Beach Squat", "Frost Squat", "Legend Squat", "Muscle King Squat", "Jungle Squat"
	},
	CurrentOption = {"Beach Squat"},
	MultipleOptions = false,
	SpecialType = nil,
	Callback = function(v)
		selectsquat = v
	end
})

WorkoutTab:CreateToggle({
	Name = "Toggle SquatRack",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().squat = v
        while getgenv().squat do
            wait()
            if selectsquat == "Beach Squat" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and
                game:GetService("Players").LocalPlayer.leaderstats.Strength.Value > 10000 then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-203.108688, 12.5697708, -422.33844, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                    getgui()
                    firetool()
                until selectsquat ~= "Beach Squat" or not getgenv().squat
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectsquat == "Frost Squat" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and
                game:GetService("Players").LocalPlayer.leaderstats.Strength.Value > 10000 then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2720.05127, 18.845705, -591.259155, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                    getgui()
                    firetool()
                until selectsquat ~= "Frost Squat" or not getgenv().squat
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectsquat == "Legend Squat" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4439.77344, 1008.06622, -4058.48682, -0.906296611, 0, 0.422642082, 0, 1, 0, -0.422642082, 0, -0.906296611)
                    getgui()
                    firetool()
                until selectsquat ~= "Legend Squat" or not getgenv().squat
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectsquat == "Muscle King Squat" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game:GetService("ReplicatedStorage").muscleKing.Value == game.Players.LocalPlayer then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8758.44238, 32.8662109, -6043.06934, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                    getgui()
                    firetool()
                until selectsquat ~= "Muscle King Squat" or not getgenv().squat
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectsquat == "Jungle Squat" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8377.27734, 34.8562622, 2863.69653, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                    getgui()
                    firetool()
                until selectsquat ~= "Jungle Squat" or not getgenv().squat
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            end
        end
	end
})

WorkoutTab:CreateDivider()

WorkoutTab:CreateDropdown({
	Name = "Select BenchPress",
	Description = nil,
	Options = {
		"Beach Bench Press", "Eternal Bench Press", "Frost Bench Press", "Eternal Bench Press", "Legend Bench Press", "Muscle King Bench Press",
        "Jungle King Bench Press"
	},
	CurrentOption = {"Beach Bench Press"},
	MultipleOptions = false,
	SpecialType = nil,
	Callback = function(v)
		selectbench = v
	end
})

WorkoutTab:CreateToggle({
	Name = "Toggle BenchPress",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().bench = v
        while getgenv().bench do
            wait()
            if selectbench == "Beach Bench Press" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and
                game:GetService("Players").LocalPlayer.leaderstats.Strength.Value > 15000 then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(466.041656, 16.0367546, -328.803345, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                    getgui()
                    firetool()
                until selectbench ~= "Beach Bench Press" or not getgenv().bench
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectbench == "Eternal Bench Press" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and
                game:GetService("Players").LocalPlayer.leaderstats.Strength.Value > 15000 then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7173.3418, 35.783802, -1105.02759, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                    getgui()
                    firetool()
                until selectbench ~= "Eternal Bench Press" or not getgenv().bench
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectbench == "Frost Bench Press" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and
                game:GetService("Players").LocalPlayer.leaderstats.Strength.Value > 15000 then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3008.67017, 30.5114555, -337.746918, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                    getgui()
                    firetool()
                until selectbench ~= "Frost Bench Press" or not getgenv().bench
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectbench == "Eternal Bench Press" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and
                game:GetService("Players").LocalPlayer.leaderstats.Strength.Value > 15000 then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7173.3418, 35.783802, -1105.02759, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                    getgui()
                    firetool()
                until selectbench ~= "Eternal Bench Press" or not getgenv().bench
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectbench == "Legend Bench Press" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4109.91309, 1012.20935, -3802.15332, 0.173624337, -0, -0.984811902, 0, 1, -0, 0.984811902, 0, 0.173624337)
                    getgui()
                    firetool()
                until selectbench ~= "Legend Bench Press" or not getgenv().bench
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectbench == "Muscle King Bench Press" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game:GetService("ReplicatedStorage").muscleKing.Value == game.Players.LocalPlayer then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8590.23535, 37.7591934, -6044.59521, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                    getgui()
                    firetool()
                until selectbench ~= "Muscle King Bench Press" or not getgenv().bench
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectbench == "Jungle King Bench Press" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8174.88184, 47.72789, 1912.96667, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                    getgui()
                    firetool()
                until selectbench ~= "Jungle King Bench Press" or not getgenv().bench
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            end
        end
	end
})

WorkoutTab:CreateDivider()

WorkoutTab:CreateDropdown({
	Name = "Select PullUp",
	Description = nil,
	Options = {
		"Beach PullUp", "Mythical PullUp", "Legend PullUp"
	},
	CurrentOption = {"Beach PullUp"},
	MultipleOptions = false,
	SpecialType = nil,
	Callback = function(v)
		selectpullup = v
	end
})

WorkoutTab:CreateToggle({
	Name = "Toggle PullUp",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().pullup = v
        while getgenv().pullup do
            wait()
            if selectpullup == "Beach PullUp" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and
                game:GetService("Players").LocalPlayer.leaderstats.Strength.Value > 1000 then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-185.000092, 7.68962765, 137.263672, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                    getgui()
                    firetool()
                until selectpullup ~= "Beach PullUp" or not getgenv().pullup
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectpullup == "Mythical PullUp" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and
                game:GetService("Players").LocalPlayer.leaderstats.Strength.Value > 8000 then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2487.12085, 29.1177711, 848.289124, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                    getgui()
                    firetool()
                until selectpullup ~= "Mythical PullUp" or not getgenv().pullup
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectpullup == "Legend PullUp" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4304.02393, 1018.72943, -4122.27734, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                    getgui()
                    firetool()
                until selectpullup ~= "Legend PullUp" or not getgenv().pullup
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            end
        end
	end
})

WorkoutTab:CreateDivider()

WorkoutTab:CreateDropdown({
	Name = "Select BoulderThrow",
	Description = nil,
	Options = {
		"Beach Boulder Throw", "Mythical Boulder Throw", "Legend Boulder Throw", "Muscle King Boulder Throw", "Jungle Boulder Throw"
	},
	CurrentOption = {"Beach Boulder Throw"},
	MultipleOptions = false,
	SpecialType = nil,
	Callback = function(v)
		selectthrow = v
	end
})

WorkoutTab:CreateToggle({
	Name = "Toggle BoulderThrow",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().throw = v
        while getgenv().throw do
            wait()
            if selectthrow == "Beach Boulder Throw" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and
                game:GetService("Players").LocalPlayer.leaderstats.Strength.Value > 25000 then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(36.9295998, 27.8716888, -411.535248, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                    getgui()
                    firetool()
                until selectthrow ~= "Beach Boulder Throw" or not getgenv().throw
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectthrow == "Mythical Boulder Throw" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and
                game:GetService("Players").LocalPlayer.leaderstats.Strength.Value > 25000 then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2667.74072, 39.5355453, 1203.33374, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                    getgui()
                    firetool()
                until selectthrow ~= "Mythical Boulder Throw" or not getgenv().throw
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectthrow == "Legend Boulder Throw" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4189.96143, 1004.37848, -3903.0166, 0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, 0.422592998)
                    getgui()
                    firetool()
                until selectthrow ~= "Legend Boulder Throw" or not getgenv().throw
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectthrow == "Muscle King Boulder Throw" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game:GetService("ReplicatedStorage").muscleKing.Value == game.Players.LocalPlayer then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8942.12891, 43.7784653, -5691.63623, -0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, -0.707134247)
                    getgui()
                    firetool()
                until selectthrow ~= "Muscle King Boulder Throw" or not getgenv().throw
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            elseif selectthrow == "Jungle Boulder Throw" and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and
                game:GetService("Players").LocalPlayer.leaderstats.Strength.Value > 75000 then
                repeat
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8616.5918, 31.8064384, 2677.15479, -0.207885981, 0, 0.97815311, 0, 1, 0, -0.97815311, 0, -0.207885981)
                    getgui()
                    firetool()
                until selectthrow ~= "Jungle Boulder Throw" or not getgenv().throw
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            end
        end
	end
})

WorkoutTab:CreateDivider()

WorkoutTab:CreateDropdown({
	Name = "Select TreadMill",
	Description = nil,
	Options = {
		"Tiny Treadmill", "Beach Treadmill", "Big Treadmill", "Frost Treadmill", "Mythical Treadmill", "Eternal Treadmill",
        "Legend Treadmill", "Jungle Treadmill"
	},
	CurrentOption = {"Tiny Treadmill"},
	MultipleOptions = false,
	SpecialType = nil,
	Callback = function(v)
		selecttreadmill = v
	end
})

WorkoutTab:CreateToggle({
	Name = "Toggle TreadMill",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().tread = v
        game:GetService("RunService").RenderStepped:Connect(function()
            if getgenv().tread and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                if selecttreadmill == "Tiny Treadmill" and game:GetService("Players").LocalPlayer.Agility.Value > 0 then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.Humanoid:Move(Vector3.new(0, 0, 100))
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-31.8626194,
                            6.0588026, 2087.88672, -0.999396682, -9.72631931e-09, 0.034730725, -6.63278898e-09, 1,
                            8.91870684e-08, -0.034730725, 8.8902901e-08, -0.999396682)
                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
                    until selecttreadmill ~= "Tiny Treadmill" or not getgenv().tread
                elseif selecttreadmill == "Beach Treadmill" and game:GetService("Players").LocalPlayer.Agility.Value >
                    600 then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.Humanoid:Move(Vector3.new(0, 0, 100))
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(226.252472,
                            8.1526947, 219.366516, -0.00880406145, 3.58277887e-08, -0.999961257, -4.41204939e-08, 1,
                            3.62176351e-08, 0.999961257, 4.44376482e-08, -0.00880406145)
                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
                    until selecttreadmill ~= "Beach Treadmill" or not getgenv().tread
                elseif selecttreadmill == "Big Treadmill" and game:GetService("Players").LocalPlayer.Agility.Value >
                    3000 then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.Humanoid:Move(Vector3.new(0, 0, 100))
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-365.798309,
                            44.5082932, -501.618591, 0.00878552441, -6.19950713e-09, 0.999961436, -4.37451603e-10,
                            1, 6.20358964e-09, -0.999961436, -4.91936492e-10, 0.00878552441)
                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
                    until selecttreadmill ~= "Big Treadmill" or not getgenv().tread
                elseif selecttreadmill == "Frost Gym" and game:GetService("Players").LocalPlayer.Agility.Value >
                    3000 then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.Humanoid:Move(Vector3.new(0, 0, 100))
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2933.47998,
                            29.6399612, -579.946045, 0.0345239155, -1.03010173e-07, 0.999403894, 1.03015294e-08, 1,
                            1.02715752e-07, -0.999403894, 6.74923806e-09, 0.0345239155)
                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
                    until selecttreadmill ~= "Frost Gym" or not getgenv().tread
                elseif selecttreadmill == "Mythical Treadmill" and game:GetService("Players").LocalPlayer.Agility.Value >
                    3000 then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.Humanoid:Move(Vector3.new(0, 0, 100))
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2659.50635,
                            21.6095238, 934.690613, 0.999999881, 4.98906161e-08, 0.000502891606, -4.98585742e-08, 1,
                            -6.37288338e-08, -0.000502891606, 6.37037516e-08, 0.999999881)
                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
                    until selecttreadmill ~= "Mythical Treadmill" or not getgenv().tread
                elseif selecttreadmill == "Eternal Treadmill" and game:GetService("Players").LocalPlayer.Agility.Value >
                    3500 then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.Humanoid:Move(Vector3.new(0, 0, 100))
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7057.39355,
                            29.6399612, -1456.59265, 0.0212769434, 4.61128629e-08, 0.999773622, 9.77062982e-08, 1,
                            -4.8202665e-08, -0.999773622, 9.87097835e-08, 0.0212769434)
                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
                    until selecttreadmill ~= "Eternal Treadmill" or not getgenv().tread
                elseif selecttreadmill == "Legend Treadmill" and game:GetService("Players").LocalPlayer.Agility.Value >
                    3000 then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.Humanoid:Move(Vector3.new(0, 0, 100))
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4370.42285,
                            999.328613, -3640.82129, -0.994707346, 5.84267781e-08, -0.102748737, 4.9968218e-08, 1,
                            8.48966693e-08, 0.102748737, 7.93131676e-08, -0.994707346)
                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
                    until selecttreadmill ~= "Legend Treadmill" or not getgenv().tread
                elseif selecttreadmill == "Jungle Treadmill" and game:GetService("Players").LocalPlayer.Agility.Value >
                    20000 then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.Humanoid:Move(Vector3.new(0, 0, 100))
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8129.3374, 27.9754486, 2795.12646, -0.997559965, 3.72901852e-08, 0.0698151588, 3.51429392e-08, 1, -3.19844027e-08, -0.0698151588, -2.9452849e-08, -0.997559965)
                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
                    until selecttreadmill ~= "Jungle Treadmill" or not getgenv().tread
                end
            end
        end)
	end
})

local TeleportTab = Window:CreateTab({
	Name = "Teleport",
	Icon = "add_location",
	ImageSource = "Material",
	ShowTitle = true
})

TeleportTab:CreateDropdown({
	Name = "Select Island",
	Description = nil,
	Options = {
		"Tiny Island", "Beach Island", "Legend Beach", "Frost Gym", "Mythical Gym", "Eternal Gym",
        "Legend Gym", "Muscle King Gym", "Jungle Gym"
	},
	CurrentOption = {"Tiny Island"},
	MultipleOptions = false,
	SpecialType = nil,
	Callback = function(v)
		selectteleport = v
	end
})

TeleportTab:CreateButton({
	Name = "Teleport Selected Island",
	Description = nil,
	Callback = function()
		if selectteleport == "Tiny Island" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(-34.0176353, 3.83001828, 1892.74426, -0.833524704, -4.3567784e-08, 0.552482188,
                    -2.70744476e-08, 1, 3.80112972e-08, -0.552482188, 1.67252061e-08, -0.833524704)
        elseif selectteleport == "Beach Island" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(-0.413686246, 3.67686582, 194.919067, 0.976406693, -1.59392535e-08, -0.21593973,
                    1.45404284e-08, 1, -8.06651812e-09, 0.21593973, 4.73634643e-09, 0.976406693)
        elseif selectteleport == "Legend Beach" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(5.06417751, 3.67686653, -398.123108, 0.963392079, 7.3031452e-09, 0.268096358,
                    -1.00300623e-09, 1, -2.36364901e-08, -0.268096358, 2.25023058e-08, 0.963392079)
        elseif selectteleport == "Frost Gym" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(-2600.00244, 3.67686558, -403.884369, 0.0873617008, 1.0482899e-09, 0.99617666,
                    3.07204253e-08, 1, -3.7464023e-09, -0.99617666, 3.09302628e-08, 0.0873617008)
        elseif selectteleport == "Mythical Gym" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(2229.9314, 3.67686605, 1077.60461, 0.994309962, 2.92280689e-08, 0.106525563,
                    -3.3292693e-08, 1, 3.63780011e-08, -0.106525563, -3.97175342e-08, 0.994309962)
        elseif selectteleport == "Eternal Gym" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(-6747.81738, 3.67687941, -1290.07397, 0.410090953, -8.78033433e-08, 0.912044644,
                    4.37941914e-08, 1, 7.65792976e-08, -0.912044644, 8.53778115e-09, 0.410090953)
        elseif selectteleport == "Legend Gym" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(4635.04541, 987.789795, -3900.51221, -0.373274773, -9.53036547e-08, 0.927720845,
                    2.81077686e-08, 1, 1.14038158e-07, -0.927720845, 6.86437289e-08, -0.373274773)
        elseif selectteleport == "Muscle King Gym" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(-8586.0459, 13.5268955, -5675.80762, 0.991283059, -5.76512598e-08, 0.131749332,
                    5.42790843e-08, 1, 2.91866726e-08, -0.131749332, -2.17810214e-08, 0.991283059)
        elseif selectteleport == "Jungle Gym" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8685.62109, 3.13961267, 2392.32666, -3.64038938e-14, -3.5240113e-08, -1, -5.56182922e-09, 1, -3.5240113e-08, 1, 5.56182922e-09, -3.65998939e-14)
        end
	end
})

local EspTab = Window:CreateTab({
	Name = "Esp",
	Icon = "account_tree",
	ImageSource = "Material",
	ShowTitle = true
})

EspTab:CreateToggle({
	Name = "Toggle Esp",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		ESP.Players = v
	end
})

EspTab:CreateToggle({
	Name = "Toggle Name",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		ESP.Names = v
	end
})

EspTab:CreateToggle({
	Name = "Toggle Tracer",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		ESP.Tracers = v
	end
})

EspTab:CreateToggle({
	Name = "Toggle Boxes",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		ESP.Boxes = v
	end
})

EspTab:CreateColorPicker({
	Name = "Color Picker",
	Color = Color3.fromRGB(255, 255, 255),
	Flag = "ColorPicker1",
	Callback = function(v)
		ESP.Color = v
	end
})

local ShopTab = Window:CreateTab({
	Name = "Crystal",
	Icon = "add_shopping_cart",
	ImageSource = "Material",
	ShowTitle = true
})
ShopTab:CreateDropdown({
	Name = "Select Crystal",
	Description = nil,
	Options = {
        "Blue Crystal", "Frost Crystal", "Galaxy Oracle Crystal", "Green Crystal", "Inferno Crystal", "Jungle Crystal", "Legends Crystal", "Muscle Elite Crystal", "Mythical Crystal"
    },
	CurrentOption = "Blue Crystal",
	MultipleOptions = false,
	SpecialType = nil,
	Callback = function(v)
		selectcrystal = v
	end
})

ShopTab:CreateToggle({
	Name = "Toggle Crystal",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().crystal = v
        while getgenv().crystal do
            wait()
            game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", selectcrystal)
        end
	end
})

local MiscTab = Window:CreateTab({
	Name = "Misc",
	Icon = "list_alt",
	ImageSource = "Material",
	ShowTitle = true
})

MiscTab:CreateButton({
	Name = "Claim Code",
	Description = nil,
	Callback = function()
		game.ReplicatedStorage.rEvents.codeRemote:InvokeServer("junglegym500")
        game.ReplicatedStorage.rEvents.codeRemote:InvokeServer("epicmuscle20")
        game.ReplicatedStorage.rEvents.codeRemote:InvokeServer("ultimate250")
        game.ReplicatedStorage.rEvents.codeRemote:InvokeServer("mightygems2500")
        game.ReplicatedStorage.rEvents.codeRemote:InvokeServer("megalift50")
        game.ReplicatedStorage.rEvents.codeRemote:InvokeServer("spacegems50")
        game.ReplicatedStorage.rEvents.codeRemote:InvokeServer("EpicReward500")
        game.ReplicatedStorage.rEvents.codeRemote:InvokeServer("MillionWarriors")
        game.ReplicatedStorage.rEvents.codeRemote:InvokeServer("FrostGems10")
        game.ReplicatedStorage.rEvents.codeRemote:InvokeServer("Musclestorm50")
        game.ReplicatedStorage.rEvents.codeRemote:InvokeServer("speedy50")
        game.ReplicatedStorage.rEvents.codeRemote:InvokeServer("SkyAgility50")
        game.ReplicatedStorage.rEvents.codeRemote:InvokeServer("GalaxyCrystal50")
        game.ReplicatedStorage.rEvents.codeRemote:InvokeServer("SuperMuscle100")
        game.ReplicatedStorage.rEvents.codeRemote:InvokeServer("SuperPunch100")
        game.ReplicatedStorage.rEvents.codeRemote:InvokeServer("Launch250")
	end
})
MiscTab:CreateButton({
	Name = "Claim Chest",
	Description = nil,
	Callback = function()
		firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").mythicalChest.circleInner, 0)
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").mythicalChest.circleInner, 1)
        wait()
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").jungleChest.circleInner, 0)
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").jungleChest.circleInner, 1)
        wait()
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").groupRewardsCircle.circleInner, 0)
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").groupRewardsCircle.circleInner, 1)
        wait()
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").goldenChest.circleInner, 0)
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").goldenChest.circleInner, 1)
        wait()
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").enchantedChest.circleInner, 0)
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").enchantedChest.circleInner, 1)
        wait()
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").legendsChest.circleInner, 0)
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").legendsChest.circleInner, 1)
	end
})

MiscTab:CreateDivider()

MiscTab:CreateLabel({
	Text = "Visual",
	Style = 2
})

MiscTab:CreateToggle({
	Name = "Toggle Fast Attack",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().punch = v
        while getgenv().punch do
            wait()
            if game.Players.LocalPlayer.Character:FindFirstChild("Punch") then
                game.Players.LocalPlayer.Character.Punch.attackTime.Value = 0
            else
                if game.Players.LocalPlayer.Backpack:FindFirstChild("Punch") then
                    game.Players.LocalPlayer.Backpack.Punch.attackTime.Value = 0
                end
            end
            if not getgenv().punch then
                if game.Players.LocalPlayer.Character:FindFirstChild("Punch") then
                game.Players.LocalPlayer.Character.Punch.attackTime.Value = 0.35
            else
                if game.Players.LocalPlayer.Backpack:FindFirstChild("Punch") then
                    game.Players.LocalPlayer.Backpack.Punch.attackTime.Value = 0.35
                end
            end
            end
        end
	end
})

MiscTab:CreateToggle({
	Name = "Toggle Anti Rebirth",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().antirebirth = v
        local rebirth = nil
        rebirth = hookmetamethod(game, "__namecall", function(self, ...)
        local args = {...}
        if tostring(self) == "rebirthRemote" and args[1] == "rebirthRequest" and getgenv().antirebirth then
            return
            end
            return rebirth(self, unpack(args))
        end)
	end
})

MiscTab:CreateToggle({
	Name = "Toggle Anti Brawl",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().antibrawl = v
        local brawl = nil
        brawl = hookmetamethod(game, "__namecall", function(self, ...)
        local args = {...}
        if tostring(self) == "brawlEvent" and args[1] == "joinBrawl" or args[1] == "sendTradeRequest" and getgenv().antibrawl then
            return
            end
            return brawl(self, unpack(args))
        end)
	end
})

MiscTab:CreateDivider()

MiscTab:CreateLabel({
	Text = "LocalPlayer",
	Style = 2
})

MiscTab:CreateButton({
	Name = "Small Size Player",
	Description = nil,
	Callback = function()
		game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 0)
	end
})

MiscTab:CreateButton({
	Name = "Max Size Player",
	Description = nil,
	Callback = function()
		firesignal(game:GetService("Players").LocalPlayer.PlayerGui.gameGui.settingsMenu.maxSizeButton.Activated)
	end
})

MiscTab:CreateToggle({
	Name = "Toggle Small Size Player",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().small = v
        while getgenv().small do
            wait()
            game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 0)
        end
	end
})

MiscTab:CreateToggle({
	Name = "Toggle Max Size Player",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().small = v
        while getgenv().small do
            wait()
            firesignal(game:GetService("Players").LocalPlayer.PlayerGui.gameGui.settingsMenu.maxSizeButton.Activated)
        end
	end
})

MiscTab:CreateSlider({
	Name = "WalkSpeed",
	Range = {0, 1000},
	Increment = 1,
	CurrentValue = 16,
	Callback = function(v)
		setws = v
	end
})

MiscTab:CreateToggle({
	Name = "Toggle WalkSpeed",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().ws = v
        while getgenv().ws do
            wait()
            if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = setws
            end
            if not getgenv().jp then
                if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
                end
            end
        end
	end
})

MiscTab:CreateSlider({
	Name = "JumpPower",
	Range = {0, 2000},
	Increment = 1,
	CurrentValue = 50,
	Callback = function(v)
		setws = v
	end
})

MiscTab:CreateToggle({
	Name = "Toggle JumpPower",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		getgenv().jp = v
        while getgenv().jp do
            wait()
            if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = setjp
            end
            if not getgenv().jp then
                if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
                end
            end
        end
	end
})

MiscTab:CreateToggle({
	Name = "Toggle Noclip",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
        getgenv().noclip = v
        if getgenv().noclip then
            noclip()
        else
            clip()
        end
	end
})

MiscTab:CreateDivider()

MiscTab:CreateLabel({
	Text = "Server",
	Style = 2
})

MiscTab:CreateButton({
	Name = "Rejoin",
	Description = nil,
	Callback = function()
		local tpservice = game:GetService("TeleportService")
        local plr = game.Players.LocalPlayer
        tpservice:Teleport(game.PlaceId, plr)
	end
})
MiscTab:CreateButton({
	Name = "ServerHop",
	Description = nil,
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
MiscTab:CreateButton({
	Name = "Small Server",
	Description = nil,
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
            Server = Servers.data[16]
            Next = Servers.nextPageCursor
        until Server
        TPS:TeleportToPlaceInstance(_place, Server.id, game.Players.LocalPlayer)
	end
})
MiscTab:CreateButton({
	Name = "Less Lagging",
	Description = nil,
	Callback = function()
		mx = game.Debris
        mx3 = game.Debris.MaxItems
        if (mx.MaxItems > 9999999999) then
            mx.MaxItems = mx2 * .9999999999
        end
        wait()
        setfpscap(1000)
	end
})

local ConfigTab = Window:CreateTab({
	Name = "Config Tab",
	Icon = "settings",
	ImageSource = "Material",
	ShowTitle = true
})
ConfigTab:BuildConfigSection()
elseif game.PlaceId == 115681808123944 then
    local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/memejames/elerium-v2-ui-library//main/Library", true))()
local window = library:AddWindow(tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name), {
	main_color = Color3.fromRGB(41, 74, 122),
	min_size = Vector2.new(250, 346),
	can_resize = false,
})

local Main = window:AddTab("Main")

Main:AddSwitch("Toggle Throw",
function(v)
	getgenv().throw = v
	while getgenv().throw do
    wait()
    if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1193.21814, 4.30752087, -169.29364, -0.0174531117, 8.06352745e-08, -0.99984771, 1.03676658e-10, 1, 8.06457479e-08, 0.99984771, 1.30385835e-09, -0.0174531117)
    end
    local args = {
	        2,
	        vector.create(-1160.94580078125, 0.7260000109672546, -160.92034912109375),
	        tostring(game:GetService("Players").LocalPlayer.PlayerGui.UiFolder.Main.HUD.Coin.Main.CoinName.Text)
        }
    game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Events"):WaitForChild("CoinLanded"):FireServer(unpack(args))
    end
end)

Main:AddSwitch("Toggle Sell",
function(v)
	getgenv().sell = v
    while getgenv().sell do
        wait()
        game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Events"):WaitForChild("SellAll"):FireServer()
    end
end)

local Upgrade = window:AddTab("Upgrade")

Upgrade:AddSwitch("Toggle Upgrade Luck",
function(v)
    getgenv().luck = v
    while getgenv().luck do
        wait()
        local args = {
	        "Luck Multiplier"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Events"):WaitForChild("RequestUpgrade"):FireServer(unpack(args))
    end
end)

Upgrade:AddSwitch("Toggle Upgrade Value",
function(v)
getgenv().value = v
while getgenv().value do
    wait()
    local args = {
	    "Value Multiplier"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Events"):WaitForChild("RequestUpgrade"):FireServer(unpack(args))
	end
end)

local Shop = window:AddTab("Shop")


Shop:AddSwitch("Toggle Buy Coin",
function(v)
	getgenv().buycoin = v
    while getgenv().buycoin do
        wait()
        for i,v in pairs(game:GetService("ReplicatedStorage").Assets.Assets.Coins:GetChildren()) do
            local args = {
	            tostring(v)
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Events"):WaitForChild("BuyCoin"):FireServer(unpack(args))
        end
    end
end)
Main:Show()
end
