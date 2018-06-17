local AddonName, Addon = ...
local L = Addon.L
local ANCHORS_ITEMS = ANCHORS_ITEMS

Target = {}
Target.__index = Target;

function Target:new(pOption)
	local self = {}
	setmetatable(self, Target)
	
	self.group = pOption:AddGroup(L.Target, 2)
	self.cmb_anchor = self.group:AddComboBox(L.OptionAnchor, 30, 1, 180, ANCHORS_ITEMS, function(pIndex)
		if InCombatLockdown() then
			self.cmb_anchor:SetValue(UI_SETTINGS.target.anchor)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.target.anchor = ANCHORS_ITEMS[pIndex]
			self:SetPosition()
		end
	end)
	self.sld_scale = self.group:AddSlider(L.OptionScale, 280, 1, 140, 50, 200, function(pValue)
		if InCombatLockdown() then
			self.sld_scale:SetValue(UI_SETTINGS.target.scale)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.target.scale = pValue
			self:SetScale()
		end
	end)
	self.sld_pos_x = self.group:AddSlider(L.OptionPosX, 20, 2, 270, -2000, 2000, function(pValue)
		if InCombatLockdown() then
			self.sld_pos_x:SetValue(UI_SETTINGS.target.pos.x)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.target.pos.x = pValue
			self:SetPosition()
		end
	end)
	self.sld_pos_y = self.group:AddSlider(L.OptionPosY, 300, 2, 270, -2000, 2000, function(pValue)
		if InCombatLockdown() then
			self.sld_pos_y:SetValue(UI_SETTINGS.target.pos.y)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.target.pos.y = pValue
			self:SetPosition()
		end
	end)

	return self
end

function Target:Init()
	self.cmb_anchor:SetValue(UI_SETTINGS.target.anchor)
	self.sld_pos_x:SetValue(UI_SETTINGS.target.pos.x)
	self.sld_pos_y:SetValue(UI_SETTINGS.target.pos.y)
	self.sld_scale:SetValue(UI_SETTINGS.target.scale)

	TargetFrame:SetUserPlaced(true)
	
	self:SetPosition()
	self:SetScale()
end

function Target:SetPosition()
	TargetFrame:ClearAllPoints()
	TargetFrame:SetPoint(UI_SETTINGS.target.anchor, 'UIParent', UI_SETTINGS.target.anchor, UI_SETTINGS.target.pos.x, UI_SETTINGS.target.pos.y)
end

function Target:SetScale()
	TargetFrame:SetScale(UI_SETTINGS.target.scale / 100)
end
