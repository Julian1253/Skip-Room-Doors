getgenv().Settings = {
	Keybind = Enum.KeyCode.H
	SkipRoom50 = true -- default is true
	AutoUnlockDoors = true -- default is true
}

do
	local UIS = game:GetService("UserInputService")
local CF = CFrame.new
local LatestRoom = game:GetService("ReplicatedStorage").GameData.LatestRoom

UIS.InputBegan:Connect(function(input, typing)
    if typing then return end
    if input.KeyCode == Keybind then
        pcall(function()
				local key = false
            	local CurrentDoor = workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("Door")
				for i,object in ipairs(CurrentDoor.Parent:GetDescendants()) do
                    	if object.Name == "KeyObtain" then
                        	key = object
                    	end
                	end
            	if LatestRoom.Value == 50 and Settings.SkipRoom50 == true then
					if Settings.SkipRoom50 == true then
						CurrentDoor = workspace.CurrentRooms[tostring(LatestRoom.Value + 1)]:WaitForChild("Door")
                		game.Players.LocalPlayer.Character:PivotTo(CF(CurrentDoor.Door.Position))
					end
            	else
					if key and Settings.AutoUnlockDoors == true then
						if Settings.AutoUnlockDoors == true then
							game.Players.LocalPlayer.Character:PivotTo(CF(key.Hitbox.Position))
						task.wait(.3)
							fireproximityprompt(key.ModulePrompt)
						task.wait(.3)
							game.Players.LocalPlayer.Character:PivotTo(CF(CurrentDoor.Door.Position))
						task.wait(.4)
							fireproximityprompt(CurrentDoor.Lock.UnlockPrompt)
						end
					end
                	game.Players.LocalPlayer.Character:PivotTo(CF(CurrentDoor.Door.Position))
            	end
				task.wait(.2)
				CurrentDoor.ClientOpen:FireServer()
        	end)
    	end
	end)
end
