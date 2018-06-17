local AddonName, Addon = ...
local L = Addon.L

local option = Option:new()
local general = General:new(option)
local player = Player:new(option)
local target = Target:new(option)
local targetOfTarget = TargetOfTarget:new(option)
local focus = Focus:new(option)
local castbar = Castbar:new(option)
local chat = Chat:new(option)
local extraActionButton = ExtraActionButton:new(option)
--local raid = Raid:new(option)


local frame = CreateFrame('Frame')
frame:RegisterEvent('ADDON_LOADED')
-- frame:RegisterAllEvents()

frame:HookScript('OnEvent', function(pSelf, pEvent, pUnit)
	if pEvent == 'ADDON_LOADED' and pUnit == AddonName then
		if UI_SETTINGS == nil then
			UI_SETTINGS = DEFAULT_SETTINGS
		end
		if UI_SETTINGS.chat == nil then
			UI_SETTINGS.chat = DEFAULT_SETTINGS.chat
		end
		if UI_SETTINGS.extra_action_button == nil then
			UI_SETTINGS.extra_action_button = DEFAULT_SETTINGS.extra_action_button
		end
		
		general:Init()
		player:Init()
		target:Init()
		targetOfTarget:Init()
		focus:Init()
		castbar:Init()
		chat:Init()
		extraActionButton:Init()
		--raid:Init()
		
		print(AddonName .. ' loaded')
	else
		--print(pEvent)
	end
end)


