local AddonName, Addon = ...
local L = Addon.L
local ANCHORS_ITEMS = ANCHORS_ITEMS

Raid = {}
Raid.__index = Raid;

function Raid:new(pOption)
	local self = {}
	setmetatable(self, Raid)
	
	self.group = pOption:AddGroup(L.Raid, 2)
	self.cmb_anchor = self.group:AddComboBox(L.OptionAnchor, 30, 1, 180, ANCHORS_ITEMS, function(pIndex)
		if InCombatLockdown() then
			self.cmb_anchor:SetValue(UI_SETTINGS.raid.anchor)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.raid.anchor = ANCHORS_ITEMS[pIndex]
			self:SetPosition()
		end
	end)
	self.sld_pos_x = self.group:AddSlider(L.OptionPosX, 20, 2, 180, -2000, 2000, function(pValue)
		if InCombatLockdown() then
			self.sld_pos_x:SetValue(UI_SETTINGS.raid.pos.x)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.raid.pos.x = pValue
			self:SetPosition()
		end
	end)
	self.sld_pos_y = self.group:AddSlider(L.OptionPosY, 220, 2, 180, -2000, 2000, function(pValue)
		if InCombatLockdown() then
			self.sld_pos_y:SetValue(UI_SETTINGS.raid.pos.y)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.raid.pos.y = pValue
			self:SetPosition()
		end
	end)

	return self
end

function Raid:Init()
	self.cmb_anchor:SetValue(UI_SETTINGS.raid.anchor)
	self.sld_pos_x:SetValue(UI_SETTINGS.raid.pos.x)
	self.sld_pos_y:SetValue(UI_SETTINGS.raid.pos.y)
	
	self:SetPosition()
end

function Raid:SetPosition()
	PlayerFrame:ClearAllPoints()
	PlayerFrame:SetPoint(UI_SETTINGS.raid.anchor, 'UIParent', UI_SETTINGS.raid.anchor, UI_SETTINGS.raid.pos.x, UI_SETTINGS.raid.pos.y)
end
