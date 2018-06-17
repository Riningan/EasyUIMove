local AddonName, Addon = ...
local L = Addon.L
local ANCHORS_ITEMS = ANCHORS_ITEMS

ExtraActionButton = {}
ExtraActionButton.__index = ExtraActionButton;

function ExtraActionButton:new(pOption)
	local self = {}
	setmetatable(self, ExtraActionButton)

	ExtraActionBarFrame:SetParent(UIParent)
	
	self.group = pOption:AddGroup(L.ExtraActionButton, 2)
	self.cmb_anchor = self.group:AddComboBox(L.OptionAnchor, 30, 1, 180, ANCHORS_ITEMS, function(pIndex)
		if InCombatLockdown() then
			self.cmb_anchor:SetValue(UI_SETTINGS.extra_action_button.anchor)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.extra_action_button.anchor = ANCHORS_ITEMS[pIndex]
			self:SetPosition()
		end
	end)
	self.sld_pos_x = self.group:AddSlider(L.OptionPosX, 20, 2, 270, -2000, 2000, function(pValue)
		if InCombatLockdown() then
			self.sld_pos_x:SetValue(UI_SETTINGS.extra_action_button.pos.x)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.extra_action_button.pos.x = pValue
			self:SetPosition()
		end
	end)
	self.sld_pos_y = self.group:AddSlider(L.OptionPosY, 300, 2, 270, -2000, 2000, function(pValue)
		if InCombatLockdown() then
			self.sld_pos_y:SetValue(UI_SETTINGS.extra_action_button.pos.y)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.extra_action_button.pos.y = pValue
			self:SetPosition()
		end
	end)

	return self
end

function ExtraActionButton:Init()
	self.cmb_anchor:SetValue(UI_SETTINGS.extra_action_button.anchor)
	self.sld_pos_x:SetValue(UI_SETTINGS.extra_action_button.pos.x)
	self.sld_pos_y:SetValue(UI_SETTINGS.extra_action_button.pos.y)
	
	self.hookSetPoint = true;
	hooksecurefunc(ExtraActionBarFrame, "SetPoint", function()
		if self.hookSetPoint then
			self:SetPosition()
		else 
			self.hookSetPoint = true;
		end
	end)
	self:SetPosition()
end

function ExtraActionButton:SetPosition()
	self.hookSetPoint = false
	ExtraActionBarFrame:ClearAllPoints()
	ExtraActionBarFrame:SetPoint(UI_SETTINGS.extra_action_button.anchor, 'UIParent', UI_SETTINGS.extra_action_button.anchor, UI_SETTINGS.extra_action_button.pos.x, UI_SETTINGS.extra_action_button.pos.y)
end
