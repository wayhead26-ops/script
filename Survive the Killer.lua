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

	KeySystem = true,
	KeySettings = {
		Title = "AireszHub",
		Subtitle = "Key System",
		Note = "",
		SaveInRoot = false,
		SaveKey = true,
		Key = {"12333333"},
		SecondAction = {
			Enabled = true,
			Type = "5hazzAq7B",
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

local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
ESP:Toggle(true)
ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false
ESP.Players = false
ESP.TeamColor = false
local setheal = false

local Tab = Window:CreateTab({
	Name = "Main",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true
})

Tab:CreateToggle({
	Name = "Toggle Escape",
	Description = "Auto Exit",
	CurrentValue = false,
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

Tab:CreateToggle({
	Name = "Toggle Collect Loot",
	Description = "Collect All Loot In Map",
	CurrentValue = false,
	Callback = function(v)
		getgenv().loot = v
        while getgenv().loot do
            wait()
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

Tab:CreateToggle({
	Name = "Toggle Remove Trap",
	Description = "Remove All Trap",
	CurrentValue = false,
	Callback = function(v)
		getgenv().removetrap = v
        while getgenv().removetrap do
			wait(1)
			for i,v in pairs(game.Workspace:GetDescendants()) do
				if v.Name == "Trap" or v.Name == "RatTraps" then
                    repeat wait()
					v:Destroy()
                    until v == nil or not getgenv().removetrap
				end
			end
		end
	end
})

Tab:CreateDivider()
Tab:CreateLabel({
	Text = "Survivor",
	Style = 2
})

Tab:CreateToggle({
	Name = "Toggle Heal",
	Description = "Heal Yourself When Get Caught",
	CurrentValue = false,
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

Tab:CreateDivider()

Tab:CreateSlider({
	Name = "Set Distance Other Player From Killer",
	Range = {0, 100},
	Increment = 1,
	CurrentValue = 26,
	Callback = function(v)
		setdistancerevive = tonumber(v)
	end
})
Tab:CreateToggle({
	Name = "Toggle Heal Player",
	Description = "Heal Others Players",
	CurrentValue = false,
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

Tab:CreateDivider()

Tab:CreateSlider({
	Name = "Set Distance From Killer",
	Range = {0, 100},
	Increment = 1,
	CurrentValue = 26,
	Callback = function(v)
		setdistance = tonumber(v)
	end
})

Tab:CreateToggle({
	Name = "Toggle Safe Place",
	Description = "Teleport To Safe Place When Killer Is Nearby",
	CurrentValue = false,
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

Tab:CreateDivider()
Tab:CreateLabel({
	Text = "Killer",
	Style = 2
})

Tab:CreateToggle({
	Name = "Toggle Kill All",
	Description = "Auto Kill All Player When Become A Killer",
	CurrentValue = false,
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

Tab:CreateDivider()

Tab:CreateSlider({
	Name = "Kill Aura Distance",
	Range = {0, 100},
	Increment = 1,
	CurrentValue = 26,
	Callback = function(v)
		setaura = tonumber(v)
	end
})

Tab:CreateToggle({
	Name = "Toggle Kill Aura",
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

Tab:CreateDivider()

Tab:CreateSlider({
	Name = "Slash Aura Distance",
	Range = {0, 100},
	Increment = 1,
	CurrentValue = 26,
	Callback = function(v)
		setstab = tonumber(v)
	end
})

Tab:CreateToggle({
	Name = "Toggle Slash Aura",
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

EspTab:CreateToggle({
	Name = "Toggle TeamColor",
	Description = nil,
	CurrentValue = false,
	Callback = function(v)
		ESP.TeamColor = v
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

local MiscTab = Window:CreateTab({
	Name = "Misc",
	Icon = "list_alt",
	ImageSource = "Material",
	ShowTitle = true
})

MiscTab:CreateLabel({
	Text = "Teleport",
	Style = 2
})

MiscTab:CreateButton({
	Name = "Teleport To Map",
	Description = nil,
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

MiscTab:CreateButton({
	Name = "Teleport To Cabin",
	Description = nil,
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

MiscTab:CreateButton({
	Name = "Teleport To Lobby",
	Description = nil,
	Callback = function()
		game.Players.LocalPlayer.Character.PrimaryPart.CFrame = game:GetService("Workspace")._Lobby.Spawns.SpawnLocation.CFrame
	end
})

MiscTab:CreateDivider()
MiscTab:CreateLabel({
	Text = "Local Player",
	Style = 2
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
