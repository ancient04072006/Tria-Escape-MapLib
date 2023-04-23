-- Copyright (C) 2023 Tria 
-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
-- If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.

--< Main >--
local Skills = {}

--- @class Skills

function Skills.new(MapLib)
	local self = setmetatable({}, Skills)
	self.map = MapLib.map

	return Skills
end

--[=[
	Toggles whether Sliding should be enabled or disabled at a certain point in your map.

		Example:
	
	```lua
		Skills:AllowSliding(true) -- Enables Sliding when called
	```

	:::info
	
	:::

]=]

function Skills:AllowSliding(enabled: boolean): nil
	local skills = self.map:FindFirstChild("Settings") and self.map.Settings:FindFirstChild("Skills")
	if skills then
		skills:SetAttribute("AllowSliding", enabled)
	end
end

return Skills
