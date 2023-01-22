local tab = {
	GameLoaded = function()
		if game:IsLoaded() then
			return true
		end
		return false
	end,
	isAlive = function(plr)
		if not plr.Character then return false end
		if not plr.Character.Head then return false end
		if not plr.Character.PrimaryPart then return false end
		if plr.Character.Humanoid.Health < 1 then return false end
		return true
	end,
	scriptActive = false,
}

shared.Functions = tab
