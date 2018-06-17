local AddonName, Addon = ...
local L = Addon.L
local ANCHORS_ITEMS = ANCHORS_ITEMS

Castbar = {}
Castbar.__index = Castbar;

function Castbar:new(pOption)
	local self = {}
	setmetatable(self, Castbar)
	
	self.group = pOption:AddGroup(L.Castbar, 2)
	self.cmb_anchor = self.group:AddComboBox(L.OptionAnchor, 30, 1, 180, ANCHORS_ITEMS, function(pIndex)
		if InCombatLockdown() then
			self.cmb_anchor:SetValue(UI_SETTINGS.castbar.anchor)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.castbar.anchor = ANCHORS_ITEMS[pIndex]
			self:SetPosition()
		end
	end)
	self.sld_scale = self.group:AddSlider(L.OptionScale, 280, 1, 140, 50, 200, function(pValue)
		if InCombatLockdown() then
			self.sld_scale:SetValue(UI_SETTINGS.castbar.scale)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.castbar.scale = pValue
			self:SetScale()
		end
	end)
	self.sld_pos_x = self.group:AddSlider(L.OptionPosX, 20, 2, 270, -2000, 2000, function(pValue)
		if InCombatLockdown() then
			self.sld_pos_x:SetValue(UI_SETTINGS.castbar.pos.x)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.castbar.pos.x = pValue
			self:SetPosition()
		end
	end)
	self.sld_pos_y = self.group:AddSlider(L.OptionPosY, 300, 2, 270, -2000, 2000, function(pValue)
		if InCombatLockdown() then
			self.sld_pos_y:SetValue(UI_SETTINGS.castbar.pos.y)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.castbar.pos.y = pValue
			self:SetPosition()
		end
	end)

	return self
end

function Castbar:Init()
	self.cmb_anchor:SetValue(UI_SETTINGS.castbar.anchor)
	self.sld_pos_x:SetValue(UI_SETTINGS.castbar.pos.x)
	self.sld_pos_y:SetValue(UI_SETTINGS.castbar.pos.y)
	self.sld_scale:SetValue(UI_SETTINGS.castbar.scale)
	
	self.hookSetPoint = true;
	hooksecurefunc(CastingBarFrame, "SetPoint", function()
		if self.hookSetPoint then
			self:SetPosition()
		else 
			self.hookSetPoint = true;
		end
	end)
	self:SetPosition()
	self:SetScale()
end

function Castbar:SetPosition()
	self.hookSetPoint = false
	CastingBarFrame:ClearAllPoints()
	CastingBarFrame:SetPoint(UI_SETTINGS.castbar.anchor, 'UIParent', UI_SETTINGS.castbar.anchor, UI_SETTINGS.castbar.pos.x, UI_SETTINGS.castbar.pos.y)
end

function Castbar:SetScale()
	CastingBarFrame:SetScale(UI_SETTINGS.castbar.scale / 100)
end
