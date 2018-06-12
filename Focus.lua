local AddonName, Addon = ...
local L = Addon.L
local ANCHORS_ITEMS = ANCHORS_ITEMS

Focus = {}
Focus.__index = Focus;

function Focus:new(pOption)
	local self = {}
	setmetatable(self, Focus)
	
	self.group = pOption:AddGroup(L.Focus, 2)
	self.cmb_anchor = self.group:AddComboBox(L.OptionAnchor, 30, 1, 180, ANCHORS_ITEMS, function(pIndex)
		if InCombatLockdown() then
			self.cmb_anchor:SetValue(UI_SETTINGS.focus.anchor)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.focus.anchor = ANCHORS_ITEMS[pIndex]
			self:SetPosition()
		end
	end)
	self.sld_pos_x = self.group:AddSlider(L.OptionPosX, 20, 2, 180, -2000, 2000, function(pValue)
		if InCombatLockdown() then
			self.sld_pos_x:SetValue(UI_SETTINGS.focus.pos.x)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.focus.pos.x = pValue
			self:SetPosition()
		end
	end)
	self.sld_pos_y = self.group:AddSlider(L.OptionPosY, 220, 2, 180, -2000, 2000, function(pValue)
		if InCombatLockdown() then
			self.sld_pos_y:SetValue(UI_SETTINGS.focus.pos.y)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.focus.pos.y = pValue
			self:SetPosition()
		end
	end)
	self.sld_scale = self.group:AddSlider(L.OptionScale, 420, 2, 140, 50, 200, function(pValue)
		if InCombatLockdown() then
			self.sld_scale:SetValue(UI_SETTINGS.focus.scale)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.focus.scale = pValue
			self:SetScale()
		end
	end)

	return self
end

function Focus:Init()
	self.cmb_anchor:SetValue(UI_SETTINGS.focus.anchor)
	self.sld_pos_x:SetValue(UI_SETTINGS.focus.pos.x)
	self.sld_pos_y:SetValue(UI_SETTINGS.focus.pos.y)
	self.sld_scale:SetValue(UI_SETTINGS.focus.scale)

	FocusFrame:SetUserPlaced(true)
	
	self:SetPosition()
	self:SetScale()
end

function Focus:SetPosition()
	FocusFrame:ClearAllPoints()
	FocusFrame:SetPoint(UI_SETTINGS.focus.anchor, 'UIParent', UI_SETTINGS.focus.anchor, UI_SETTINGS.focus.pos.x, UI_SETTINGS.focus.pos.y)
end

function Focus:SetScale()
	FocusFrame:SetScale(UI_SETTINGS.focus.scale / 100)
end
