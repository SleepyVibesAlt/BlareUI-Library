local BlareLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SleepyVibesAlt/BlareUI-Library/refs/heads/main/BlareUI.lua"))()
assert(BlareLib, "Failed to load BlareLib")

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local PlayerName = Player.Name
local Health = Humanoid.Health
local MaxHealth = Humanoid.MaxHealth
local TweenService = game:GetService("TweenService")

local win = BlareLib:Create({
    Name = "Islands Script",
    UseKey = false,
    Key = "123456",
    StartupSound = {
        Toggle = true,
        SoundID = "rbxassetid://6958727243",
        TimePosition = 1
    },
    Discord = "https://discord.gg/yourserver", 
    KeyLink = "https://linkvertise.com/yourkey"
})

local FileName = "UpdatedNekoHub"
local GameName = "Islands"

local NotificationIcon = "rbxassetid://1234567890"

function SendNotification(Title, Text)
	game:GetService("StarterGui"):SetCore("SendNotification",{
		Title = Title, -- Required
		Text = Text, -- Required
		Icon = NotificationIcon -- Optional
	})
end	

SendNotification("Welcome!", "Welcome to "..FileName .. " " .. ScriptVersion.."!")

function Remotes()
	DebugCheck(0,"HASH AUTO UPDATE 4")

	function UpdateRemote(RemoteName, Value)
		if game:FindFirstChild("_REMOTES_NEKO_") == nil then
			local REMOTES = Instance.new("Folder")
			REMOTES.Name = "_REMOTES_NEKO_"
			REMOTES.Parent = game
			UpdateRemote(RemoteName, Value)
		else
			if game:FindFirstChild("_REMOTES_NEKO_"):FindFirstChild(RemoteName) == nil then
				local _NEWREMOTE = Instance.new("StringValue")
				_NEWREMOTE.Name = RemoteName
				_NEWREMOTE.Value = Value
				_NEWREMOTE.Parent = game:FindFirstChild("_REMOTES_NEKO_")
			else
				DebugCheck(0,"Remote Update: "..RemoteName)
				game:FindFirstChild("_REMOTES_NEKO_"):FindFirstChild(RemoteName).Value = Value
			end
		end
	end

	if IsFolder("/Hash System") and IsFile("Game Version") and ReadFile("Game Version") and game.PlaceVersion == tonumber(ReadFile("Game Version")) then
		print("Ist Nicht geupdated!")

		UpdateRemote("KillRemote", ReadFile("/Hash System/KillRemote")) -- 2
		UpdateRemote("KillRemoteHashName", ReadFile("/Hash System/KillRemoteHashName")) -- 2
		_G.KillRemoteHash = ReadFile("/Hash System/KillRemoteHash")

		UpdateRemote("FishFarmFinishRemote", ReadFile("/Hash System/FishFarmFinishRemote")) -- 2
		UpdateRemote("AngelRemote", ReadFile("/Hash System/AngelRemote")) -- 2

		UpdateRemote("TOOL_PICKUPHashData", ReadFile("/Hash System/TOOL_PICKUPHashData")) -- 2
		_G.TOOL_PICKUPHash = ReadFile("/Hash System/TOOL_PICKUPHash")

		UpdateRemote("CropHashData", ReadFile("/Hash System/CropHashData")) -- 2
		_G.CropHash = ReadFile("/Hash System/CropHash")

		UpdateRemote("TreeHashData", ReadFile("/Hash System/TreeHashData")) -- 2
		_G.TreeHash = ReadFile("/Hash System/TreeHash")
		UpdateRemote("BlockHitHashData", ReadFile("/Hash System/BlockHitHashData")) -- 2
		_G.BlockHitHash = ReadFile("/Hash System/BlockHitHash")

		UpdateRemote("FlowerCollect", "client_request_1") -- 1
		UpdateRemote("PetCollect", "CLIENT_PET_ANIMAL")
		UpdateRemote("BlockRemote", "CLIENT_BLOCK_HIT_REQUEST")
		UpdateRemote("SpiritRemote", "nflutpppqsFS/ZroaqkcspgrTkvpnkrdWcc")

		UpdateRemote("CropPlaceHashData", ReadFile("/Hash System/CropPlaceHashData")) -- 2
		_G.CropPlaceHash = ReadFile("/Hash System/CropPlaceHash") -- 2
		_G.CropPlaceH1 = ReadFile("/Hash System/BlockPlaceHashData") 
		UpdateRemote("BlockPlaceHashData", ReadFile("/Hash System/BlockPlaceHashData")) -- 2
		_G.BlockPlaceHash = ReadFile("/Hash System/BlockPlaceHash") -- 2

	else

		CreateFolder("Hash System")

		print("Getting Hashes!")

		CreateFile("Game Version", tostring(game.PlaceVersion), false)

		function Update()
			local MOBRIGHT = ""
			local MOBLEFT = ""
			local mobRemoteName = ""
			function UpdateMob()

				local Tool

				for i,v in pairs(game:GetService("ReplicatedStorage").Tools:GetChildren()) do 
					if v.Name == "swordWood" then
						local Clone = v:Clone()
						Clone.Parent = game.Players.LocalPlayer.Character
						task.wait(0.2)
						Clone.Parent = game.Players.LocalPlayer.Backpack
						task.wait(0.2)
						Clone.Parent = game.Players.LocalPlayer.Character
						task.wait(0.2)
						Tool = Clone
					end
				end

				local function getrem(p9)
					rem = ""
					for i,v in pairs(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@rbxts"].net.out["_NetManaged"]:GetChildren()) do
						if v.Name:match(p9) then
							rem = v
						end
					end
					return rem.Name
				end
				local remleft = ""
				mobrem = ""
				for i,v in pairs(getgc(true)) do
					if type(v) == "function" and getinfo(v).name == "attemptHit" then
						for i2,v2 in pairs(getprotos(v)) do
							for i3,v3 in pairs(getprotos(v2)) do
								mobrem = getrem("/"..getconstants(v3)[1])
								remleft = getconstants(v3)[4]
							end
						end
					end
				end


				for i,v in pairs(getgc(true)) do
					if type(v) == "function" and getinfo(v).name == "attemptHit" then
						MOBRIGHT = getupvalues(v)[5]
						task.wait() -- 1
					end
				end
				print("mobrem:",mobrem)
				mobramsides = string.split(mobrem, "/")

				MOBLEFT = remleft
				if mobramsides and mobramsides[1] and mobramsides[2] then
					mobRemoteName = mobramsides[1].."/"..mobramsides[2]
					if MOBRIGHT then
						_G.KillRemoteHash = MOBRIGHT
					else
						_G.KillRemoteHash = nil
					end 
				else
					_G.KillRemoteHash = nil
					local RunService = game:GetService("RunService")
					local CoreGui = game:GetService("CoreGui")




				end
				if Tool then
					DebugCheck(0,"Sword ist da")

					Tool.Parent = game.Players.LocalPlayer.Backpack
					Tool:Destroy()
				else
					DebugCheck(0,"NO SWORD!")
				end
			end

			UpdateMob()


			local Remote1
			local Remote15
			local Remote2

			function UpdateFish()

				local Tool

				for i,v in pairs(game:GetService("ReplicatedStorage").Tools:GetChildren()) do 
					if v.Name == "fishingRod" then
						local Clone = v:Clone()
						Clone.Parent = game.Players.LocalPlayer.Character
						task.wait(0.5)
						Clone.Parent = game.Players.LocalPlayer.Backpack
						task.wait(0.5)
						Clone.Parent = game.Players.LocalPlayer.Character
						task.wait(0.5)
						Tool = Clone
					end
				end

				local function getrem(p9)
					rem = ""
					for i,v in pairs(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@rbxts"].net.out["_NetManaged"]:GetChildren()) do
						if v.Name:match(p9) then
							rem = v
						end
					end
					return rem.Name
				end

				local WerfRemote

				local dump1
				local dump2



				if Tool then
					local ToolScript = Tool:FindFirstChild("fishing-rod")

					if Tool and ToolScript then
						for i,v222 in pairs(getgc(true)) do
							if type(v222) == "function" and  getfenv(v222).script == ToolScript then


								for i,v in pairs(getconstants(v222)) do
									if i == 9 then

										if getrem(v) then
											DebugCheck(0,v)
											if v == 1.5 or v == "1.5" then

											else
												Remote1 = v
												Remote15 = string.split(Remote1, "/")[1]
												DebugCheck(0,"Remote15:",Remote15)

											end
										end
									end

									if i == 3 then
										if type(v) == "string" then
											if getrem(v) then

												Remote2 = v
												dump2 = Remote2
											end
										end
									end
								end

							end
						end

						local FinishRemote

						local function getrem(p9)
							rem = ""
							for i,v in pairs(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@rbxts"].net.out["_NetManaged"]:GetChildren()) do
								if v.Name:match(p9) then
									rem = v
								end
							end
							return rem.Name
						end

						for i,v222 in pairs(getgc(true)) do
							if type(v222) == "function" and getinfo(v222).name == "handleGameOver" and getfenv(v222).script == game:GetService("Players").LocalPlayer.PlayerScripts.TS.flame.controllers.fishing["fishing-controller"] then


								for i,v in pairs(getconstants(v222)) do

									if type(v) == "string" then

										if getrem(v) then
											if i == 2 then
												DebugCheck(0,"FINISH: ",v)
												dump1 = v
												DebugCheck(0,Remote15)
												WerfRemote = Remote2.."/"..Remote15
												DebugCheck(0,"FNISH2:",WerfRemote)
											end
										end

									end

								end

							end
						end
						--[[

								if FinishRemote then
									UpdateRemote("FishFarmFinishRemote", FinishRemote)
									DebugCheck(0,"FishFarmFinishRemote", FinishRemote)
								else
									game.Players.LocalPlayer:Kick("cant get FinishRemote!")
								end
								if FinishRemote then
									UpdateRemote("AngelRemote", Remote1)
									DebugCheck(0,"AngelRemote", Remote1)
								else
									game.Players.LocalPlayer:Kick("cant get AngelRemote!")
								end

						]]
					end
				end

				local Finishremote = dump2.."/"..dump1

				DebugCheck(0,"FinishRemote:",Finishremote)

				if WerfRemote then
					DebugCheck(0,"WerfRemote:",WerfRemote)
				end

				UpdateRemote("FishFarmFinishRemote", Finishremote) -- 2
				SendNotification("[SECURITY]", "Check 1/42 Done!")
				UpdateRemote("AngelRemote", WerfRemote) -- 2
				SendNotification("[SECURITY]", "Check 2/42 Done!")

				CreateFile("/Hash System/FishFarmFinishRemote", Finishremote, false)
				SendNotification("[SECURITY]", "Check 3/42 Done!")
				CreateFile("/Hash System/AngelRemote", WerfRemote, false)
				SendNotification("[SECURITY]", "Check 4/42 Done!")
				Tool.Parent = game.Players.LocalPlayer.Backpack
				Tool:Destroy()

			end



			-- UpdateFish()

			task.spawn(function()
				UpdateFish()
				task.wait()
			end)

			function Updateinv(v)
				if v:FindFirstChild("sword") then
					if _G.KillRemoteHash == nil or _G.KillRemoteHash == "" or _G.KillRemoteHash == " " then
						UpdateMob()
						task.wait()
						UpdateRemote("KillRemote", mobRemoteName) -- 2
						SendNotification("[SECURITY]", "Check 5/42 Done!")
						UpdateRemote("KillRemoteHashName", MOBLEFT) -- 2
						SendNotification("[SECURITY]", "Check 6/42 Done!")
						_G.KillRemoteHash = MOBRIGHT
						SendNotification("[SECURITY]", "Check 7/42 Done!")
					end
				end
			end

			game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function(v)
				Updateinv(v)
			end)

			game.Players.LocalPlayer.Backpack.ChildRemoved:Connect(function(v)
				Updateinv(v)
			end)

			print("mobRemoteName:",mobRemoteName)

			UpdateRemote("KillRemote", mobRemoteName) -- 2
			SendNotification("[SECURITY]", "Check 8/42 Done!")
			UpdateRemote("KillRemoteHashName", MOBLEFT) -- 2
			SendNotification("[SECURITY]", "Check 9/42 Done!")
			_G.KillRemoteHash = MOBRIGHT

			print("Debug 1")

			task.wait()

			CreateFile("/Hash System/KillRemote", mobRemoteName, false)
			SendNotification("[SECURITY]", "Check 10/42 Done!")
			CreateFile("/Hash System/KillRemoteHashName", MOBLEFT, false)
			SendNotification("[SECURITY]", "Check 11/42 Done!")
			CreateFile("/Hash System/KillRemoteHash", MOBRIGHT or _G.KillRemoteHash, false)
			SendNotification("[SECURITY]", "Check 12/42 Done!")

			print("Debug 2")


			local ToolLEFT
			local TOOLRIGHT 
			function UpdatePickUpTool()
				for i,v in pairs(getgc(true)) do
					if type(v) == "function" and getinfo(v).name == "pickupTool" then
						ToolLEFT = getconstants(v)[23]
						TOOLRIGHT = getconstants(v)[25]..getconstants(v)[26]
					end
				end
			end
			task.spawn(function()
				UpdatePickUpTool()
			end)

			print("Debug 3")

			UpdateRemote("TOOL_PICKUPHashData", ToolLEFT) -- 2
			SendNotification("[SECURITY]", "Check 13/42 Done!")
			_G.TOOL_PICKUPHash = TOOLRIGHT
			SendNotification("[SECURITY]", "Check 14/42 Done!")

			CreateFile("/Hash System/TOOL_PICKUPHashData", ToolLEFT, false)
			SendNotification("[SECURITY]", "Check 15/42 Done!")
			CreateFile("/Hash System/TOOL_PICKUPHash", TOOLRIGHT, false)
			SendNotification("[SECURITY]", "Check 16/42 Done!")

			print("Debug 4")

			local CROPleft
			local CROPright
			function CropUpdate()
				remleft = ""
				remright = ""
				for i,v in pairs(getgc(true)) do
					if type(v) == "function" and getinfo(v).name == "breakCrop" and getfenv(v).script == game.Players.LocalPlayer.PlayerScripts.TS.block.crop["crop-service"] then
						for i2,v2 in pairs(getprotos(v)) do

							for i,v in pairs(getconstants(v)) do

								if i == 22 then
									remleft = v 
								end 

								if i == 26 then
									remright = v 
								end


								if i == 27 then
									remright = remright..v
								end


							end
						end
					end
				end    
				if remleft and remright then
					CROPleft = remleft
					CROPright = remright
				else
					game.Players.LocalPlayer:Kick("Error: NCD1")
				end
			end
			task.spawn(function()
				CropUpdate()
			end)

			print("Debug 5")

			local HITleft
			local HITright
			function HitUpdate()
				remright2 = ""
				remleft = ""
				remright = ""
				for i,v in pairs(getgc(true)) do
					if type(v) == "function" and getinfo(v).name == "onBlockHit" then
						for i2,v2 in pairs(getprotos(v)) do
							if table.find(getconstants(v2), "Get") then
								for i3,v3 in pairs(getconstants(v2)) do
									remleft = getconstants(v2)[8]
									remright2 = getconstants(v2)[11]
									remright = getconstants(v2)[10]
								end
							end
						end
					end
				end

				HITleft = remleft
				HITright = remright..remright2
			end
			task.spawn(function()
				HitUpdate()
			end)

			task.wait(0.2)

			print("Debug 6")

			UpdateRemote("CropHashData", CROPleft) -- 2
			SendNotification("[SECURITY]", "Check 17/42 Done!")
			_G.CropHash = CROPright
			SendNotification("[SECURITY]", "Check 18/42 Done!")


			UpdateRemote("TreeHashData", HITleft) -- 2
			SendNotification("[SECURITY]", "Check 19/42 Done!")
			_G.TreeHash = HITright
			SendNotification("[SECURITY]", "Check 20/42 Done!")
			UpdateRemote("BlockHitHashData", HITleft) -- 2
			SendNotification("[SECURITY]", "Check 21/42 Done!")
			_G.BlockHitHash = HITright
			SendNotification("[SECURITY]", "Check 22/42 Done!")

			CreateFile("/Hash System/CropHashData", CROPleft, false)
			SendNotification("[SECURITY]", "Check 23/42 Done!")
			CreateFile("/Hash System/CropHash", CROPright, false)
			SendNotification("[SECURITY]", "Check 24/42 Done!")

			print("Debug 7")

			CreateFile("/Hash System/TreeHashData", HITleft, false)
			SendNotification("[SECURITY]", "Check 25/42 Done!")
			CreateFile("/Hash System/TreeHash", HITright, false)
			SendNotification("[SECURITY]", "Check 26/42 Done!")
			CreateFile("/Hash System/BlockHitHashData", HITleft, false)
			SendNotification("[SECURITY]", "Check 27/42 Done!")
			CreateFile("/Hash System/BlockHitHash", HITright, false)
			SendNotification("[SECURITY]", "Check 28/42 Done!")

			print("Debug 8")


			local BlockRight1
			local BlockRight
			local BlockLeft
			function UpdatePlaceBlocks()


				for i,v in pairs(getgc(true)) do
					if type(v) == "function" and getfenv(v).script == game.Players.LocalPlayer.PlayerScripts.TS.flame.controllers.block["block-controller"] then

						for dddi,dddv in pairs(getconstants(v)) do

							if tonumber(dddi) == 23 then
								BlockLeft = dddv
							end
							if tonumber(dddi) == 25 then
								BlockLeft1 = dddv
							end
							if tonumber(dddi) == 26 then
								BlockRight = BlockLeft1..dddv
							end
						end
					end
				end

			end
			UpdatePlaceBlocks()

			print("Debug 9")

			function GetNet()
				local A1
				local A2

				for i,v in pairs(getgc(true)) do
					if type(v) == "function" and getinfo(v).name == "constructor" and getfenv(v).script == game:GetService("Workspace").ANTICATBYASHO.net.net then

						for i2,v2 in pairs(getprotos(v)) do

							A1 = getconstants(v2)[16]

							A2 = getconstants(v2)[13]

							for i,v in pairs(getconstants(v2)) do
								DebugCheck(0,i,v, " | type:", type(v)) 
							end


						end
					end
				end

				DebugCheck(0,A1)
				DebugCheck(0,A2)
			end

			print("Debug 10")

			UpdateRemote("FlowerCollect", "client_request_1") -- 1
			SendNotification("[SECURITY]", "Check 29/42 Done!")
			UpdateRemote("PetCollect", "CLIENT_PET_ANIMAL")
			SendNotification("[SECURITY]", "Check 30/42 Done!")
			UpdateRemote("BlockRemote", "CLIENT_BLOCK_HIT_REQUEST")
			SendNotification("[SECURITY]", "Check 31/42 Done!")
			-- UpdateRemote("SendMailRemote", "NINGI(HUINUH(UIN(IH(HUUI")
			SendNotification("[SECURITY]", "Check 32/42 Done!")
			UpdateRemote("SpiritRemote", "gecqaLhbvAbyjo/qDgqEvuQzyryuBnlzh")
			SendNotification("[SECURITY]", "Check 33/42 Done!")

			print("BlockLeft:",BlockLeft)

			UpdateRemote("CropPlaceHashData", BlockLeft) -- 2
			SendNotification("[SECURITY]", "Check 34/42 Done!")
			_G.CropPlaceHash = BlockRight -- 2
			SendNotification("[SECURITY]", "Check 35/42 Done!")
			_G.CropPlaceH1 = BlockLeft
			SendNotification("[SECURITY]", "Check 36/42 Done!")
			UpdateRemote("BlockPlaceHashData", BlockLeft) -- 2
			SendNotification("[SECURITY]", "Check 37/42 Done!")
			_G.BlockPlaceHash = BlockRight -- 2
			SendNotification("[SECURITY]", "Check 38/42 Done!")

			print("Debug 11")

			CreateFile("/Hash System/CropPlaceHashData", BlockLeft, false)
			SendNotification("[SECURITY]", "Check 39/42 Done!")
			CreateFile("/Hash System/CropPlaceHash", BlockRight, false)
			SendNotification("[SECURITY]", "Check 40/42 Done!")
			CreateFile("/Hash System/BlockPlaceHashData", BlockLeft, false)
			SendNotification("[SECURITY]", "Check 41/42 Done!")
			CreateFile("/Hash System/BlockPlaceHash", BlockRight, false)
			SendNotification("[SECURITY]", "Check 42/42 Done!")
		end
		Update()
	end
end

SendNotification("[SECURITY]", "Scanning Game...")

Remotes()

function FixInv()
	for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		v.Parent = game.Players.LocalPlayer.Character
		task.wait()
		v.Parent = game.Players.LocalPlayer.Backpack
		task.wait()
	end
end

function Hash()
	local HttpService = game:GetService("HttpService")
	local Abd = HttpService:GenerateGUID(false)..HttpService:GenerateGUID(false)..HttpService:GenerateGUID(false)
	return Abd
end

local MotHitH2 = _G.KillRemoteHash 
local RemoteData = game:WaitForChild("_REMOTES_NEKO_")

local function MoveToTarget(targetPosition)
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        if ShouldGoto then
            local tweenInfo = TweenInfo.new(
                (character.HumanoidRootPart.Position - targetPosition).Magnitude / 35,
                Enum.EasingStyle.Linear
            )
            
            local tween = TweenService:Create(character.HumanoidRootPart, tweenInfo, {
                CFrame = CFrame.new(targetPosition)
            })
            tween:Play()
            return tween
        else
            Humanoid:MoveTo(targetPosition)
            return Humanoid.MoveToFinished
        end
    end
end

local function Attack(Entity)
    -- Play animation
    local Player = game.Players.LocalPlayer.Name
    local AnimationId = "5328169716"
    local Anim = Instance.new("Animation")
    Anim.AnimationId = "rbxassetid://"..AnimationId
    local k = game.Players[Player].Character.Humanoid:LoadAnimation(Anim)
    k:Play()
    k:AdjustSpeed(0)

    local args = {
        [1] = Entity.EntityUUID.Value,
        [2] = {
            [1] = {
                ["UiItXhnkf"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nTwudhybaivliemzqrcNmf",
                ["hitUnit"] = Entity
            }
        }
    }

    game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("jiqEhnmoMV/ZlgessyomwyEX"):FireServer(unpack(args))
    print("Attacking entity with UUID:".. Entity.EntityUUID.Value)
    
    task.wait(5)
    k:Stop()
end

-- Settings Tab
local SettingsTab = win:Tab('Settings')

SettingsTab:Section('Movement Settings')
SettingsTab:Toggle('Auto Tween', function(v)
    ShouldGoto = v
end)

SettingsTab:Toggle('Anti-Cheat Debuffer', function(v)
    local noclip = v
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    local function updateNoclip()
        if noclip then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA('BasePart') and part ~= rootPart then
                    part.CanCollide = false
                end
            end
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
            humanoid:ChangeState(11)
            workspace.Gravity = 50
        else
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA('BasePart') then
                    part.CanCollide = true
                end
            end
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
            humanoid:ChangeState(7)
            workspace.Gravity = 196.2
        end
    end
    
    local connection
    connection = game:GetService('RunService').Heartbeat:Connect(function()
        if character and character:FindFirstChild("Humanoid") then
            updateNoclip()
        else
            if connection then
                connection:Disconnect()
            end
        end
    end)
end)
SettingsTab:Comment('When using Auto-Tween enable the Anti-Cheat Debuffer.')
SettingsTab:Comment('Anti-Cheat Debuffer in BETA.')

local Distance = 300

SettingsTab:Section('Range Settings')
SettingsTab:Textbox('Search Distance', function(value)
    local newDistance = tonumber(value)
    if newDistance then
        Distance = newDistance
        print("Distance set to:", Distance)
        BlareLib:CreateNotification("Distance Updated", "Search Distance set to: " .. Distance, 2)
    else
        BlareLib:CreateNotification("Invalid Input", "Please enter a number!", 3)
    end
end)
SettingsTab:Comment('Lower or Disable some settings to reduce Anti-Cheat detection')

-- AutoFarm Tab
local ResourceTab = win:Tab('Resource Farming')
ResourceTab:Section('Ores')

ResourceTab:Toggle('Iron Ore', function(v)
    print("Iron Ore toggled:", v)
    wait(1)
    IronOre = v
    while IronOre do
        local rocks = workspace:GetDescendants()
        local closestRock = nil
        local closestDistance = math.huge
        
        for _, rock in pairs(rocks) do
            if rock.Name == "rockIron" and rock:IsA("Part") then
                local distance = (rock.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance <= Distance and distance < closestDistance then
                    closestRock = rock
                    closestDistance = distance
                end
            end
        end
        
        if closestRock then
            local movement = MoveToTarget(closestRock.Position)
            if ShouldGoto then
                movement.Completed:Wait()
            else
                movement:Wait()
            end
            
            local args = {
                [1] = {
                    ["xkpOrfvithbzcvKundjsvoamBnpkqBsXm"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nkyaxebDphmkcyha",
                    ["part"] = closestRock:FindFirstChild("1"),
                    ["block"] = closestRock,
                    ["norm"] = closestRock.Position,
                    ["pos"] = closestRock.Position - Character.HumanoidRootPart.Position
                }
            }
            
            game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
        end
        task.wait(0.1)
    end
end)

ResourceTab:Toggle('Eletrite Ore', function(v)
    print("Eletrite Ore toggled:", v)
    wait(1)
    EletriteOre = v
    while EletriteOre do
        local rocks = workspace:GetDescendants()
        local closestRock = nil
        local closestDistance = math.huge
        
        for _, rock in pairs(rocks) do
            if rock.Name == "rockElectrite" and rock:IsA("Part") then
                local distance = (rock.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance <= Distance and distance < closestDistance then
                    closestRock = rock
                    closestDistance = distance
                end
            end
        end
        
        if closestRock then
            local movement = MoveToTarget(closestRock.Position)
            if ShouldGoto then
                movement.Completed:Wait()
            else
                movement:Wait()
            end
            
            local args = {
                [1] = {
                    ["xkpOrfvithbzcvKundjsvoamBnpkqBsXm"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nkyaxebDphmkcyha",
                    ["part"] = closestRock:FindFirstChild("1"),
                    ["block"] = closestRock,
                    ["norm"] = closestRock.Position,
                    ["pos"] = closestRock.Position - Character.HumanoidRootPart.Position
                }
            }
            
            game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
        end
        task.wait(0.1)
    end
end)

ResourceTab:Section('Stones')

ResourceTab:Toggle('Slate Rock', function(v)
    print("Slate Rock toggled:", v)
    wait(1)
    SlateRock = v
    while SlateRock do
        local rocks = workspace:GetDescendants()
        local closestRock = nil
        local closestDistance = math.huge
        
        for _, rock in pairs(rocks) do
            if rock.Name == "rockSlate" and rock:IsA("Part") then
                local distance = (rock.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance <= Distance and distance < closestDistance then
                    closestRock = rock
                    closestDistance = distance
                end
            end
        end
        
        if closestRock then
            local movement = MoveToTarget(closestRock.Position)
            if ShouldGoto then
                movement.Completed:Wait()
            else
                movement:Wait()
            end
            
            local args = {
                [1] = {
                    ["xkpOrfvithbzcvKundjsvoamBnpkqBsXm"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nkyaxebDphmkcyha",
                    ["part"] = closestRock:FindFirstChild("1"),
                    ["block"] = closestRock,
                    ["norm"] = closestRock.Position,
                    ["pos"] = closestRock.Position - Character.HumanoidRootPart.Position
                }
            }
            
            game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
        end
        task.wait(0.1)
    end
end)

ResourceTab:Toggle('Marble Rock', function(v)
    print("Marble Rock toggled:", v)
    wait(1)
    MarbleRock = v
    while MarbleRock do
        local rocks = workspace:GetDescendants()
        local closestRock = nil
        local closestDistance = math.huge
        
        for _, rock in pairs(rocks) do
            if rock.Name == "rockMarble" and rock:IsA("Part") then
                local distance = (rock.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance <= Distance and distance < closestDistance then
                    closestRock = rock
                    closestDistance = distance
                end
            end
        end
        
        if closestRock then
            local movement = MoveToTarget(closestRock.Position)
            if ShouldGoto then
                movement.Completed:Wait()
            else
                movement:Wait()
            end
            
            local args = {
                [1] = {
                    ["xkpOrfvithbzcvKundjsvoamBnpkqBsXm"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nkyaxebDphmkcyha",
                    ["part"] = closestRock:FindFirstChild("1"),
                    ["block"] = closestRock,
                    ["norm"] = closestRock.Position,
                    ["pos"] = closestRock.Position - Character.HumanoidRootPart.Position
                }
            }
            
            game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
        end
        task.wait(0.1)
    end
end)

ResourceTab:Toggle('Obsidian Rock', function(v)
    print("Obsidian Rock toggled:", v)
    wait(1)
    ObsidianRock = v
    while ObsidianRock do
        local rocks = workspace:GetDescendants()
        local closestRock = nil
        local closestDistance = math.huge
        
        for _, rock in pairs(rocks) do
            if rock.Name == "rockObsidian" and rock:IsA("Part") then
                local distance = (rock.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance <= Distance and distance < closestDistance then
                    closestRock = rock
                    closestDistance = distance
                end
            end
        end
        
        if closestRock then
            local movement = MoveToTarget(closestRock.Position)
            if ShouldGoto then
                movement.Completed:Wait()
            else
                movement:Wait()
            end
            
            local args = {
                [1] = {
                    ["xkpOrfvithbzcvKundjsvoamBnpkqBsXm"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nkyaxebDphmkcyha",
                    ["part"] = closestRock:FindFirstChild("1"),
                    ["block"] = closestRock,
                    ["norm"] = closestRock.Position,
                    ["pos"] = closestRock.Position - Character.HumanoidRootPart.Position
                }
            }
            
            game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
        end
        task.wait(0.1)
    end
end)
local MobFarmTab = win:Tab('Mob Farm')
MobFarmTab:Comment('Please equip your sword before enabling and also go to the island first.')

MobFarmTab:Section('Slime Island')
MobFarmTab:Toggle('Farm Slimes', function(v)
    local Slimes = game.workspace.WildernessIsland.Entities
    SlimeFarm = v
    while SlimeFarm do
        local closestSlime = nil
        local closestDistance = math.huge
        
        for _, slime in pairs(Slimes:GetChildren()) do
            if slime.Name == "slime" and slime:FindFirstChild("Humanoid") and slime.Humanoid.Health > 0 and SlimeFarm then
                local distance = (slime.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance and distance <= Distance then
                    closestSlime = slime
                    closestDistance = distance
                end
            end
        end
        
        if closestSlime then
            while closestSlime:FindFirstChild("Humanoid") and closestSlime.Humanoid.Health > 0 and SlimeFarm do
                local movement = MoveToTarget(closestSlime.HumanoidRootPart.Position)
                if ShouldGoto then
                    movement.Completed:Wait()
                else
                    movement:Wait()
                end
                
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closestSlime.HumanoidRootPart.Position)
                Attack(closestSlime)
            end
            print("Slime defeated!")
        end
        task.wait(0.1)
    end
end)

MobFarmTab:Toggle('Farm slimeKing', function(v)
    local Slimes = game.workspace.WildernessIsland.Entities
    SlimeKingFarm = v
    while SlimeKingFarm do
        local closestSlime = nil
        local closestDistance = math.huge
        
        for _, slime in pairs(Slimes:GetChildren()) do
            if slime.Name == "slimeKing" and slime:FindFirstChild("Humanoid") and slime.Humanoid.Health > 0 and SlimeKingFarm then
                local distance = (slime.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance and distance <= Distance then
                    closestSlime = slime
                    closestDistance = distance
                end
            end
        end
        
        if closestSlime then
            while closestSlime:FindFirstChild("Humanoid") and closestSlime.Humanoid.Health > 0 and SlimeKingFarm do
                local movement = MoveToTarget(closestSlime.HumanoidRootPart.Position)
                if ShouldGoto then
                    movement.Completed:Wait()
                else
                    movement:Wait()
                end
                
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closestSlime.HumanoidRootPart.Position)
                
                local virtualInput = game:GetService("VirtualInputManager")
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, true, game, 1)
                task.wait(0.1)
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, false, game, 1)
                task.wait(0.1)
            end
            print("Slime King defeated!")
        end
        task.wait(0.1)
    end
end)

MobFarmTab:Section('Buffalkor Island')
MobFarmTab:Toggle('Farm buffalkor', function(v)
    local Entities = game.workspace.WildernessIsland.Entities
    BuffalkorFarm = v
    while BuffalkorFarm do
        local closestBuffalkor = nil
        local closestDistance = math.huge
        
        for _, mob in pairs(Entities:GetChildren()) do
            if mob.Name == "buffalkor" and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and BuffalkorFarm then
                local distance = (mob.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance and distance <= Distance then
                    closestBuffalkor = mob
                    closestDistance = distance
                end
            end
        end
        
        if closestBuffalkor then
            while closestBuffalkor:FindFirstChild("Humanoid") and closestBuffalkor.Humanoid.Health > 0 and BuffalkorFarm do
                local movement = MoveToTarget(closestBuffalkor.HumanoidRootPart.Position)
                if ShouldGoto then
                    movement.Completed:Wait()
                else
                    movement:Wait()
                end
                
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closestBuffalkor.HumanoidRootPart.Position)
                
                local virtualInput = game:GetService("VirtualInputManager")
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, true, game, 1)
                task.wait(0.1)
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, false, game, 1)
                task.wait(0.1)
            end
            print("Buffalkor defeated!")
        end
        task.wait(0.1)
    end
end)

MobFarmTab:Section('Wizard Island')
MobFarmTab:Toggle('Farm Lizard Wizard', function(v)
    local Entities = game.workspace.WildernessIsland.Entities
    WizardFarm = v
    while WizardFarm do
        local closestWizard = nil
        local closestDistance = math.huge
        
        for _, mob in pairs(Entities:GetChildren()) do
            if mob.Name == "wizardLizard" and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and WizardFarm then
                local distance = (mob.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance and distance <= Distance then
                    closestWizard = mob
                    closestDistance = distance
                end
            end
        end
        
        if closestWizard then
            while closestWizard:FindFirstChild("Humanoid") and closestWizard.Humanoid.Health > 0 and WizardFarm do
                local movement = MoveToTarget(closestWizard.HumanoidRootPart.Position)
                if ShouldGoto then
                    movement.Completed:Wait()
                else
                    movement:Wait()
                end
                
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closestWizard.HumanoidRootPart.Position)
                
                local virtualInput = game:GetService("VirtualInputManager")
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, true, game, 1)
                task.wait(0.1)
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, false, game, 1)
                task.wait(0.1)
            end
            print("Wizard Lizard defeated!")
        end
        task.wait(0.1)
    end
end)

MobFarmTab:Toggle('Farm Wizard Boss', function(v)
    local Entities = game.workspace.WildernessIsland.Entities
    WizardBossFarm = v
    while WizardBossFarm do
        local closestWizardBoss = nil
        local closestDistance = math.huge
        
        for _, mob in pairs(Entities:GetChildren()) do
            if mob.Name == "wizardBoss" and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and WizardBossFarm then
                local distance = (mob.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance and distance <= Distance then
                    closestWizardBoss = mob
                    closestDistance = distance
                end
            end
        end
        
        if closestWizardBoss then
            while closestWizardBoss:FindFirstChild("Humanoid") and closestWizardBoss.Humanoid.Health > 0 and WizardBossFarm do
                local movement = MoveToTarget(closestWizardBoss.HumanoidRootPart.Position)
                if ShouldGoto then
                    movement.Completed:Wait()
                else
                    movement:Wait()
                end
                
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closestWizardBoss.HumanoidRootPart.Position)
                
                local virtualInput = game:GetService("VirtualInputManager")
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, true, game, 1)
                task.wait(0.1)
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, false, game, 1)
                task.wait(0.1)
            end
            print("Wizard Boss defeated!")
        end
        task.wait(0.1)
    end
end)

MobFarmTab:Section('Pirate Island')

MobFarmTab:Toggle('Farm Skeleton Pirate', function(v)
    local Entities = game.workspace.WildernessIsland.Entities
    PirateFarm = v
    while PirateFarm do
        local closestPirate = nil
        local closestDistance = math.huge
        
        for _, mob in pairs(Entities:GetChildren()) do
            if mob.Name == "skeletonPirate" and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and PirateFarm then
                local distance = (mob.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance and distance <= Distance then
                    closestPirate = mob
                    closestDistance = distance
                end
            end
        end
        
        if closestPirate then
            while closestPirate:FindFirstChild("Humanoid") and closestPirate.Humanoid.Health > 0 and PirateFarm do
                local movement = MoveToTarget(closestPirate.HumanoidRootPart.Position)
                if ShouldGoto then
                    movement.Completed:Wait()
                else
                    movement:Wait()
                end
                
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closestPirate.HumanoidRootPart.Position)
                
                local virtualInput = game:GetService("VirtualInputManager")
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, true, game, 1)
                task.wait(0.1)
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, false, game, 1)
                task.wait(0.1)
            end
            print("Pirate defeated!")
        end
        task.wait(0.1)
    end
end)

BlareLib:CreateNotification("Island Script Initiated", "Welcome " .. PlayerName .. ", we hope u enjoy!", 2)