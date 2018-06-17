local AddonName, Addon = ...
local L = Addon.L
local ANCHORS_ITEMS = ANCHORS_ITEMS

Player = {}
Player.__index = Player;

function Player:new(pOption)
	local self = {}
	setmetatable(self, Player)
	
	self.group = pOption:AddGroup(L.Player, 2)
	self.cmb_anchor = self.group:AddComboBox(L.OptionAnchor, 30, 1, 180, ANCHORS_ITEMS, function(pIndex)
		if InCombatLockdown() then
			self.cmb_anchor:SetValue(UI_SETTINGS.player.anchor)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.player.anchor = ANCHORS_ITEMS[pIndex]
			self:SetPosition()
		end
	end)
	self.sld_scale = self.group:AddSlider(L.OptionScale, 280, 1, 140, 50, 200, function(pValue)
		if InCombatLockdown() then
			self.sld_scale:SetValue(UI_SETTINGS.player.scale)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.player.scale = pValue
			self:SetScale()
		end
	end)
	self.sld_pos_x = self.group:AddSlider(L.OptionPosX, 20, 2, 270, -2000, 2000, function(pValue)
		if InCombatLockdown() then
			self.sld_pos_x:SetValue(UI_SETTINGS.player.pos.x)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.player.pos.x = pValue
			self:SetPosition()
		end
	end)
	self.sld_pos_y = self.group:AddSlider(L.OptionPosY, 300, 2, 270, -2000, 2000, function(pValue)
		if InCombatLockdown() then
			self.sld_pos_y:SetValue(UI_SETTINGS.player.pos.y)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.player.pos.y = pValue
			self:SetPosition()
		end
	end)

	return self
end

function Player:Init()
	self.cmb_anchor:SetValue(UI_SETTINGS.player.anchor)
	self.sld_pos_x:SetValue(UI_SETTINGS.player.pos.x)
	self.sld_pos_y:SetValue(UI_SETTINGS.player.pos.y)
	self.sld_scale:SetValue(UI_SETTINGS.player.scale)

	PlayerFrame:SetUserPlaced(true)
	
	self:SetPosition()
	self:SetScale()
end

function Player:SetPosition()
	PlayerFrame:ClearAllPoints()
	PlayerFrame:SetPoint(UI_SETTINGS.player.anchor, 'UIParent', UI_SETTINGS.player.anchor, UI_SETTINGS.player.pos.x, UI_SETTINGS.player.pos.y)
end

function Player:SetScale()
	PlayerFrame:SetScale(UI_SETTINGS.player.scale / 100)
end
