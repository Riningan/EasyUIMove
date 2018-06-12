local AddonName, Addon = ...
local L = Addon.L

local option = Option:new()
local general = General:new(option)
local player = Player:new(option)
local target = Target:new(option)
local target_of_target = TargetOfTarget:new(option)
local focus = Focus:new(option)
local castbar = Castbar:new(option)
--local raid = Raid:new(option)


local frame = CreateFrame('Frame')
frame:RegisterEvent('ADDON_LOADED')
-- frame:RegisterAllEvents()

frame:HookScript('OnEvent', function(pSelf, pEvent, pUnit)
	if pEvent == 'ADDON_LOADED' and pUnit == AddonName then
		if UI_SETTINGS == nil then
			UI_SETTINGS = DEFAULT_SETTINGS
		end
		
		general:Init()
		player:Init()
		target:Init()
		target_of_target:Init()
		focus:Init()
		castbar:Init()
		--raid:Init()
		
		print(AddonName .. ' loaded')
	else
		--print(pEvent)
	end
end)


