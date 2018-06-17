local AddonName, Addon = ...
local L = Addon.L
local ANCHORS_ITEMS = ANCHORS_ITEMS

Chat = {}
Chat.__index = Chat;

function Chat:new(pOption)
	local self = {}
	setmetatable(self, Chat)
	
	self.group = pOption:AddGroup(L.Chat, 2)
	self.cmb_anchor = self.group:AddComboBox(L.OptionAnchor, 30, 1, 180, ANCHORS_ITEMS, function(pIndex)
		if InCombatLockdown() then
			self.cmb_anchor:SetValue(UI_SETTINGS.chat.anchor)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.chat.anchor = ANCHORS_ITEMS[pIndex]
			self:SetPosition()
		end
	end)
	self.sld_pos_x = self.group:AddSlider(L.OptionPosX, 20, 2, 270, -2000, 2000, function(pValue)
		if InCombatLockdown() then
			self.sld_pos_x:SetValue(UI_SETTINGS.chat.pos.x)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.chat.pos.x = pValue
			self:SetPosition()
		end
	end)
	self.sld_pos_y = self.group:AddSlider(L.OptionPosY, 300, 2, 270, -2000, 2000, function(pValue)
		if InCombatLockdown() then
			self.sld_pos_y:SetValue(UI_SETTINGS.chat.pos.y)
			pOption:ShowErrorMessage()
		else
			UI_SETTINGS.chat.pos.y = pValue
			self:SetPosition()
		end
	end)

	return self
end

function Chat:Init()
	self.cmb_anchor:SetValue(UI_SETTINGS.chat.anchor)
	self.sld_pos_x:SetValue(UI_SETTINGS.chat.pos.x)
	self.sld_pos_y:SetValue(UI_SETTINGS.chat.pos.y)

	self.hookSetPoint = true;
	hooksecurefunc(ChatFrame1, "SetPoint", function()
		if self.hookSetPoint then
			self:SetPosition()
		else 
			self.hookSetPoint = true;
		end
	end)
	self:SetPosition()
end

function Chat:SetPosition()
	self.hookSetPoint = false
	ChatFrame1:ClearAllPoints()
	ChatFrame1:SetPoint(UI_SETTINGS.chat.anchor, 'UIParent', UI_SETTINGS.chat.anchor, UI_SETTINGS.chat.pos.x, UI_SETTINGS.chat.pos.y)
end
