local lplr = game.Players.LocalPlayer
lplr.Character.Humanoid.WalkSpeed = 15
_G.Speedddd11 = true
while _G.Speedddd11 do
	if game.UserInputService:IsKeyDown(Enum.KeyCode.W) then
		--game.Players.LocalPlayer.Character.Humanoid:ChangeState(3)
		for i=1,4 do
		wait()
			lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + lplr.Character.HumanoidRootPart.CFrame.lookVector * 1.2
		end
		for i=1,2 do
      wait()
		  lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + lplr.Character.HumanoidRootPart.CFrame.lookVector * 0.6
	 end
					for i=1,1 do
						wait()
						lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + lplr.Character.HumanoidRootPart.CFrame.lookVector * 0.4
					end
					for i=1,4 do
						wait()
						lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + lplr.Character.HumanoidRootPart.CFrame.lookVector * 0.2
					end
	
				end
				if game.UserInputService:IsKeyDown(Enum.KeyCode.S) then
					lplr.Character.Humanoid.WalkSpeed = 23
				else
					lplr.Character.Humanoid.WalkSpeed = 15
				end
				wait(0.57)
			end
