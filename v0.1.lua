local Keybind = Enum.KeyCode.H

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
            if LatestRoom.Value == 50 then
                CurrentDoor = workspace.CurrentRooms[tostring(LatestRoom.Value + 1)]:WaitForChild("Door")
                game.Players.LocalPlayer.Character:PivotTo(CF(CurrentDoor.Door.Position))
            else
                if key then
                    game.Players.LocalPlayer.Character:PivotTo(CF(key.Hitbox.Position))
                    task.wait(.3)
                    fireproximityprompt(key.ModulePrompt)
                    task.wait(.3)
                    game.Players.LocalPlayer.Character:PivotTo(CF(CurrentDoor.Door.Position))
                    fireproximityprompt(CurrentDoor.Lock.UnlockPrompt)
                end
                game.Players.LocalPlayer.Character:PivotTo(CF(CurrentDoor.Door.Position))
            end
            task.wait(.2)
            CurrentDoor.ClientOpen:FireServer()
        end)
    end
end)
