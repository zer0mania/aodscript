local title = "Alive or Dead GUI v1.2.2"

local volume = 1
local pitch = 1
local id = 0
local audiolag = nil
local vizSpinSpeed = 0.7
local vizRotSpeed = 0
local vizSize = 155
local vizSens = 2
local vizDegrees = 360

local ShopBuy = game:GetService("ReplicatedStorage").ShopBuy

local stickspam = nil
local blockspam = nil
local selectedItem = nil
local dupeAmount = nil

-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new(title, 5013109572)

-- themes   `
local themes = {
	Background = Color3.fromRGB(24, 24, 24),
	Accent = Color3.fromRGB(10, 10, 10),
	LightContrast = Color3.fromRGB(20, 20, 20),
	DarkContrast = Color3.fromRGB(14, 14, 14),  
	TextColor = Color3.fromRGB(255, 255, 255)
}

-- first page

local player = game:GetService("Players").LocalPlayer

local playerPage = venyx:addPage("Player", 4486281381)
local properties = playerPage:addSection("Humanoid Properties")
local qol = playerPage:addSection("Miscellaneous")
local fixlag = playerPage:addSection("Fix Lag")

properties:addSlider("WalkSpeed", 16, 16, 200, function(value)
	player.Character.Humanoid.WalkSpeed = value
end)

properties:addSlider("JumpPower", 50, 50, 500, function(value)
	player.Character.Humanoid.JumpPower = value
end)

properties:addSlider("HipHeight", 0, 0, 250, function(value)
	player.Character.Humanoid.HipHeight = value
end)

qol:addButton("Remove Jump Cooldown", function()
	for k, v in pairs(game:GetDescendants()) do
        if v.Name == "JumpCooldown" then
            v:Destroy()
        end
    end    
end)

qol:addButton("Remove Rain", function()
	for k, v in pairs(game:GetDescendants()) do
        if v.Name == "Rain [READ]" then
            v:Destroy()
        end
    end    
end)

qol:addButton("Normal Lighting", function()
    local lighting = game:GetService("Lighting")
    lighting.Ambient = Color3.fromRGB(255,255,255)
    lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
    lighting.ColorShift_Bottom = Color3.fromRGB(255,255,255)
    lighting.ColorShift_Top = Color3.fromRGB(255,255,255)
end)

fixlag:addButton("Respawn", function()
    player.Character:Destroy()
end)

fixlag:addButton("Rejoin", function()
    local ts = game:GetService("TeleportService")
    local p = game:GetService("Players").LocalPlayer
    
    ts:Teleport(game.PlaceId, p)
end)

fixlag:addButton("Destroy GUI", function()
    game:GetService("CoreGui")[title]:Destroy()
end)

-- second page
local audioPage = venyx:addPage("Audio", 4786727483)
local playaudio = audioPage:addSection("Server Side Play Audio")
local visualizer = audioPage:addSection("Visualizer (need items duped and selected in Items)")

playaudio:addTextbox("Sound ID", "0", function(value)
    id = value
end)

playaudio:addTextbox("Volume", "1", function(value)
    volume = value
end)

playaudio:addTextbox("Pitch", "1", function(value)
    pitch = value
end)

visualizer:addTextbox("Distance (bigger = closer)", "155", function(value)
    vizSize = value
end)

visualizer:addTextbox("Visualizer Sensitivity", "2", function(value)
    vizSens = value
end)

visualizer:addTextbox("Visualizer Spin Speed", "0.7", function(value)
    vizSpinSpeed = value
end)

visualizer:addTextbox("Visualizer Rotation", "0", function(value)
    vizRotSpeed = value
end)

visualizer:addTextbox("Visualizer Sensitivity", "2", function(value)
    vizSens = value
end)

visualizer:addTextbox("Visualizer Degrees", "360", function(value)
    vizDegrees = value
end)

playaudio:addButton("Play", function()
    local emittersize = 70
    local pos = workspace

    -- server side

    local args = {
        [1] = "}0, { \n\n } ",
        [2] = "}, { ",
        [3] = {
            ["Pitch"] = pitch,
            ["EmitterSize"] = emittersize,
            ["Position"] = pos,
            ["SoundId"] = "rbxassetid://" .. tostring(id),
            ["Replicate"] = false,
            ["Volume"] = volume,
            ["Effects"] = false
        }
    }

    game:GetService("ReplicatedStorage").PlayAudio:FireServer(unpack(args))

    -- local

    local newsound = Instance.new("Sound",pos)
    newsound.Name = "Sound"
    newsound.SoundId = "rbxassetid://" .. tostring(id)
    newsound.Volume = volume
    newsound.Pitch = pitch
    newsound.Looped = false
    newsound.EmitterSize = emittersize
    newsound:Play()
end)

playaudio:addToggle("Audio Spam", nil, function(value)
    if audiolag == nil then
        audiolag = true
    else
        audiolag = nil
        do return end
    end

    venyx:Notify("Spamming audio..", "(You can't hear it)")
    while audiolag == true do
        wait()
        local emittersize = 70
        local pos = workspace

        -- server side

        local args = {
            [1] = "}0, { \n\n } ",
            [2] = "}, { ",
            [3] = {
                ["Pitch"] = pitch,
                ["EmitterSize"] = emittersize,
                ["Position"] = pos,
                ["SoundId"] = "rbxassetid://" .. tostring(id),
                ["Replicate"] = false,
                ["Volume"] = volume,
                ["Effects"] = false
            }
        }

        game:GetService("ReplicatedStorage").PlayAudio:FireServer(unpack(args))
    end
end)

visualizer:addButton("Play", function()
    local me = game.Players.LocalPlayer.Name
    local pos = game:GetService("Workspace")[me].HumanoidRootPart.CFrame

    for k, v in pairs(game:GetDescendants()) do
        if v.Name == "Vizualizer" then
            v:Destroy()
        end
    end

     local char_to_hex = function(c)
          return string.format("%%%02X", string.byte(c))
        end
        
        local function urlencode(url)
          if url == nil then
            return
          end 
          url = url:gsub("\n", "\r\n")
          url = url:gsub(".", char_to_hex)
          url = url:gsub(" ", "+")
          return url
        end
        local encid = urlencode(id)
         local fsong = '0%&assetName=                                                                                                                        <>                                                                                                                        Fanta                                                                                                                         Hub                                                                                                                         Rewritten                                                                                                                        </>                                                               .gg/78TS8UcDca                                                         %&%69%64=%30%30%37%30%30%38%34%34%34%33%31%37%&%69%64=%30%30%37%30%35%31%30%39%39%31%30%32%&%69%64=%30%30%37%30%39%36%30%31%35%38%32%36%&%69%64=%30%30%37%30%37%35%35%39%38%36%37%34%&%69%64=%30%30%37%30%39%34%30%31%38%31%32%39%&%69%64=%30%30%37%30%37%36%34%32%37%38%39%35%&%69%64=%30%30%37%30%38%35%35%35%37%38%38%30%&%69%64=%30%30%37%30%39%32%33%38%37%36%34%38%&%69%64=%30%30%37%30%32%37%37%38%35%34%38%36%&%69%64=%30%30%37%30%33%33%39%38%37%37%32%35%&%69%64=%30%30%37%30%32%33%33%37%30%39%36%34%&%69%64=%30%30%37%30%30%35%30%37%39%35%31%36%&%69%64=%30%30%37%30%37%38%34%37%37%31%38%30%&%69%64=%30%30%37%30%32%31%39%39%31%36%37%33%&%69%64=%30%30%37%30%32%38%34%38%35%30%37%38%&%69%64=%30%30%37%30%32%34%38%33%31%32%37%30%&%69%64=%30%30%37%30%34%33%30%37%31%34%35%35%&%69%64=%30%30%37%30%36%36%36%38%32%37%32%30%&%69%64=%30%30%37%30%31%33%38%35%39%39%39%39%&%69%64=%30%30%37%30%31%34%39%33%30%32%39%35%&%69%64=%30%30%37%30%30%35%37%30%36%34%39%38%&%69%64=%30%30%37%30%33%36%31%37%37%33%37%31%&%69%64=%30%30%37%30%35%35%30%32%33%38%31%39%&%69%64=%30%30%37%30%36%39%31%30%31%31%32%31%' .. '&%69%64=' .. encid .. '%%26%69%64=%30%30%37%30%36%31%31%30%37%39%36%34%%26%69%64=%30%30%37%30%37%33%37%38%32%39%39%34%%26%69%64=%30%30%37%30%31%39%33%32%32%37%33%39%%26%69%64=%30%30%37%30%30%33%32%38%33%38%39%35%%26%69%64=%30%30%37%30%38%38%37%37%30%36%34%32%%26%69%64=%30%30%37%30%31%34%31%32%32%32%32%35%%26%69%64=%30%30%37%30%33%35%37%33%37%37%35%33%%26%69%64=%30%30%37%30%35%32%33%39%39%34%38%39%%26%69%64=%30%30%37%30%32%33%31%30%33%38%32%33%%26%69%64=%30%30%37%30%30%32%37%37%38%39%37%31%%26%69%64=%30%30%37%30%31%33%34%36%31%35%30%39%%26%69%64=%30%30%37%30%31%39%38%31%31%32%34%36%%26%69%64=%30%30%37%30%37%38%37%32%30%31%30%38%%26%69%64=%30%30%37%30%30%38%31%34%31%31%32%35%%26%69%64=%30%30%37%30%36%32%33%38%31%37%36%32%%26%69%64=%30%30%37%30%36%30%38%38%33%33%33%34%%26%69%64=%30%30%37%30%34%35%33%32%30%34%38%37%%26%69%64=%30%30%37%30%36%39%35%37%33%30%30%34'
                local Root = game.Players.LocalPlayer.Character.HumanoidRootPart
                local Visualizer = {}
                local mk = {}
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v.ClassName == "Tool" then
                        v.Parent = game.Players.LocalPlayer.Backpack
                    end
                end
    wait(1)
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.ClassName == "Tool" and v:FindFirstChild("Handle") and v.Name == selectedItem then
            v.Parent = game.Players.LocalPlayer.Character
            table.insert(Visualizer, v)
            table.insert(mk, 0)
            -- parameters
    
            local id = fsong
            local emittersize = 70
            local pos = v.Handle
    
            -- server side
    
            local args = {
                [1] = "}0, { \n\n } ",
                [2] = "}, { ",
                [3] = {
                    ["Pitch"] = pitch,
                    ["EmitterSize"] = emittersize,
                    ["Position"] = pos,
                    ["SoundId"] = "rbxassetid://" .. tostring(id),
                    ["Replicate"] = false,
                    ["Volume"] = volume,
                    ["Effects"] = false
                }
            }
    
            game:GetService("ReplicatedStorage").PlayAudio:FireServer(unpack(args))
    
            -- local
    
            local newsound = Instance.new("Sound",pos)
            newsound.Name = "Vizualizer"
            newsound.SoundId = "rbxassetid://" .. tostring(id)
            newsound.Volume = volume
            newsound.Pitch = pitch
            newsound.Looped = false
            newsound.EmitterSize = emittersize
            newsound:Play()
            --v:FindFirstChildOfClass("RemoteEvent"):FireServer("PlaySong", fsong)
            --v.Handle.Sound.TimePosition = 0
        end
    end
    wait(0.5)
        for i,v in pairs(game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
            v:Stop()
        end
    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v.ClassName == "Tool" and v:FindFirstChild("Handle") and v.Name == selectedItem then
            v.Handle.Vizualizer.TimePosition = 0
        end
    end
    wait(0.5)
    game:GetService("Workspace")[me].HumanoidRootPart.CFrame = CFrame.new(5000, 50000, 5000)
    wait(2)
    game.Players.LocalPlayer.Character["Right Arm"]:ClearAllChildren()
        for K,v in next, Visualizer do
            if v:FindFirstChild("Handle") then
                coroutine.wrap(function()
                    repeat
                        local sp2 = 0
                        local Spin = 0
                        repeat
                                local PRY = math.rad(Spin+(K*(vizDegrees/#Visualizer)))
                                local PRX = math.rad(sp2)
                                 local PRZ = math.rad(Spin)
                                local Distance = math.round(Visualizer[1].Handle.Vizualizer.PlaybackLoudness)/vizSize + vizSens
                                local Position = CFrame.new(Root.Position) * CFrame.Angles(PRX,PRY,PRZ) * CFrame.new(1,1.3,Distance).Position
                                v.Handle.CFrame = CFrame.new(Position, Root.Position + Vector3.new(0, 0, 0))
                                v.Handle.Velocity = Vector3.new(29.99999995, 0, 0)
                                Spin = Spin + vizSpinSpeed
                                sp2 = sp2 + vizRotSpeed
                            game.RunService.RenderStepped:wait()
                        until Spin >= vizDegrees
                    until not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                end)()
            end
        end
        wait(1)
        game:GetService("Workspace")[me].Torso.Anchored = true
        wait(0.1)
        game:GetService("Workspace")[me].Torso.Anchored = false
        wait(0.1)
        game:GetService("Workspace")[me].HumanoidRootPart.CFrame = pos
end)

-- second page
local itemsPage = venyx:addPage("Items", 5199008802)
local itemScripts = itemsPage:addSection("Item Scripts")
local getItems = itemsPage:addSection("Get Items")
local getIndividualItems = itemsPage:addSection("Get Individial Items")

itemScripts:addToggle("Stick Spam", nil, function(value)
    if stickspam == nil then
        stickspam = true
    else
        stickspam = nil
    end

    local A_1 = "RedLaserScythe"

    while stickspam == true do
        ShopBuy:FireServer(A_1)

        for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v:IsA("Tool") and v.Name == A_1 then
            v.Parent = game.Players.LocalPlayer.Character
            end
        end

        for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("Tool") then
                for o,b in pairs(v:GetDescendants()) do
                    if b:IsA("SpecialMesh") then
                        b:Destroy()
                    end
                end
            end
        end

        for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v:IsA("Tool") and v.Name == A_1 then
            v.Parent = workspace
            end
        end

        wait()
    end
end)

itemScripts:addToggle("Block Spam", nil, function(value)
    if blockspam == nil then
        blockspam = true
    else
        blockspam = nil
    end

    local A_1 = "Bloxiade"

    while blockspam == true do
        ShopBuy:FireServer(A_1)

        for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v:IsA("Tool") and v.Name == A_1 then
            v.Parent = game.Players.LocalPlayer.Character
            end
        end

        for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("Tool") then
                for o,b in pairs(v:GetDescendants()) do
                    if b:IsA("SpecialMesh") then
                        b:Destroy()
                    end
                end
            end
        end

        for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v:IsA("Tool") and v.Name == A_1 then
            v.Parent = workspace
            end
        end

        wait()
    end
end)

itemScripts:addDropdown("Select Item", {"Uzi", "M4A1", "Sandvich", "Pump Shotgun", "Bloxiade", "Fireball", "RedLaserScythe", "Spear", "ZombieStaff", "Chainsaw", "FireworkLauncher", "Raygun", "EpicSwordofRedness", "VampireVanquisher", "SCAR-H", "SledgeHammer", "Fireaxe", "DesertEagle", "BasicArmor", "AK-47"}, function(text)
	selectedItem = text
end)

itemScripts:addTextbox("Dupe Amount", "", function(value)
    dupeAmount = tonumber(value)
end)

itemScripts:addButton("Dupe", function()
    local A_1 = selectedItem

    i = 0

    while (i < dupeAmount) do
        ShopBuy:FireServer(A_1)
        i = i + 1
    end
end)

itemScripts:addButton("Equip all items", function()
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then
        v.Parent = game.Players.LocalPlayer.Character
        end
    end
end)

itemScripts:addButton("Equip selected items", function()
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.Name == selectedItem then
        v.Parent = game.Players.LocalPlayer.Character
        end
    end
end)

itemScripts:addButton("Destroy Item Mesh", function()
    for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v:IsA("Tool") then
            for o,b in pairs(v:GetDescendants()) do
                if b:IsA("SpecialMesh") or b:IsA("MeshPart") then
                    b:Destroy()
                end
            end
        end
    end
end)

itemScripts:addButton("Network Crash Server", function()
    local A_1 = "VampireVanquisher"
    local args = {
        [1] = "Crashing server xd",
        [2] = "All"
    }

    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))

    i = 0

    while (i < 25) do
        ShopBuy:FireServer(A_1)
        i = i + 1
    end

    wait(2)

    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.Name == "VampireVanquisher" then
        v.Parent = game.Players.LocalPlayer.Character
        end
    end

    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") and v.Name == "VampireVanquisher" then
        v.Parent = workspace
        end
    end
end)

getItems:addButton("Get all Items", function()
    ShopBuy:FireServer("Uzi")
    ShopBuy:FireServer("M4A1")
    ShopBuy:FireServer("Sandvich")
    ShopBuy:FireServer("Uzi")
    ShopBuy:FireServer("Pump Shotgun")
    ShopBuy:FireServer("Bloxiade")
    ShopBuy:FireServer("Fireball")
    ShopBuy:FireServer("RedLaserScythe")
    ShopBuy:FireServer("Spear")
    ShopBuy:FireServer("ZombieStaff")
    ShopBuy:FireServer("Chainsaw")
    ShopBuy:FireServer("FireworkLauncher")
    ShopBuy:FireServer("Raygun")
    ShopBuy:FireServer("EpicSwordofRedness")
    ShopBuy:FireServer("VampireVanquisher")
    ShopBuy:FireServer("SCAR-H")
    ShopBuy:FireServer("Sledgehammer")
    ShopBuy:FireServer("FireAxe")
    ShopBuy:FireServer("DesertEagle")
    ShopBuy:FireServer("BasicArmor")
    ShopBuy:FireServer("AK-47")
end)

getIndividualItems:addButton("Uzi", function()
    local A_1 = "Uzi"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("M4A1", function()
    local A_1 = "M4A1"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("Sandvich", function()
    local A_1 = "Sandvich"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("Pump Shotgun", function()
    local A_1 = "Pump Shotgun"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("Bloxiade", function()
    local A_1 = "Bloxiade"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("Fireball", function()
    local A_1 = "Fireball"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("RedLaserScythe", function()
    local A_1 = "RedLaserScythe"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("Spear", function()
    local A_1 = "Spear"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("ZombieStaff", function()
    local A_1 = "ZombieStaff"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("Chainsaw", function()
    local A_1 = "Chainsaw"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("FireworkLauncher", function()
    local A_1 = "FireworkLauncher"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("Raygun", function()
    local A_1 = "Raygun"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("EpicSwordOfRedness", function()
    local A_1 = "EpicSwordofRedness"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("VampireVanquisher", function()
    local A_1 = "VampireVanquisher"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("SCAR-H", function()
    local A_1 = "SCAR-H"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("Sledgehammer", function()
    local A_1 = "Sledgehammer"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("FireAxe", function()
    local A_1 = "FireAxe"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("DesertEagle", function()
    local A_1 = "DesertEagle"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("BasicArmor", function()
    local A_1 = "BasicArmor"
    ShopBuy:FireServer(A_1)
end)

getIndividualItems:addButton("AK-47", function()
    local A_1 = "AK-47"
    ShopBuy:FireServer(A_1)
end)

-- color piocker
local theme = venyx:addPage("Theme", 5012544693)
local colors = theme:addSection("Colors")

for theme, color in pairs(themes) do -- all in one theme changer, i know, im cool
	colors:addColorPicker(theme, color, function(color3)
		venyx:setTheme(theme, color3)
	end)
end

local credits = venyx:addPage("Credits", 7852902024)
local section1 = credits:addSection("Internals made by zer0mania#1111")
local section2 = credits:addSection("Venyx UI Library made by GreenDeno on GitHub")
local section3 = credits:addSection("https://github.com/GreenDeno/Venyx-UI-Library")

-- load
venyx:SelectPage(venyx.pages[1], true)

local speed = 5

-- rgb

spawn(function()
    while true do
        for i = 0,1,0.001*speed do
            color = Color3.fromHSV(i,1,1)
            venyx:setTheme("Glow", color)
            wait()
        end
    end
end)

print("and i was here at your moms house")