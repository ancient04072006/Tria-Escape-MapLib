-- Copyright (C) 2023 Tria
-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.

--< Services >--
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerStates = require(ReplicatedStorage.shared.PlayerStates)

--< Main >--
local PlayerUI = { context = "client" }
PlayerUI.__index = PlayerUI

--- @class PlayerUI
--- @client

--- @prop cleanup {ScreenGUI}
--- @readonly
--- @private
--- @within PlayerUI

--[=[ 
	Creates a new PlayerUI class for loading ScreenGUI's! This can be used for creating cutscenes, ending screens, etc.

		Example:

	```lua
		local PlayerUI = PlayerUI.new() -- Initalizes PlayerUI Class
	```

	:::info
	im so gay
	:::

]=]

function PlayerUI.new()
	local self = setmetatable({}, PlayerUI)

	self.cleanup = {}

	PlayerStates.LocalStateChanged:Connect(function(newState)
		if newState == PlayerStates.SURVIVED or newState == PlayerStates.LOBBY then
			for _, v in pairs(self.cleanup) do
				v:Destroy()
			end
			table.clear(self.cleanup)
		end
	end)

	return self
end

--[=[
	Loads a ScreenGUI object into the Players PlayerGui. The ScreenGUI object has to be defined in the script somewhere in order to access it in this function. It can have Frames, TextLabels, etc in it as long as the parent is a ScreenGUI. 

		Example:
	
	```lua
		local ScreenGUI = Path.To.ScreenGUI

		PlayerUI:LoadUI(ScreenGUI) -- Call the function to load the GUI
	```

	:::info
	You call the :LoadUI() function in the LocalMapScript as it is a client object.
	:::

]=]

function PlayerUI:LoadUI(gui: ScreenGui): ScreenGui
	assert(gui:IsA("ScreenGui"), "':LoadUI' must be passed a 'ScreenGUI'")

	gui.Parent = Players.LocalPlayer.PlayerGui
	table.insert(self.cleanup, gui)
	return gui
end

return PlayerUI
