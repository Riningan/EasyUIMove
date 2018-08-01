local AddonName, Addon = ...
local L = Addon.L

General = {}
General.__index = General;

function General:new(pOption)
	local self = {}
	setmetatable(self, General)


	self.group = pOption:AddGroup(L.General, 1)
	self.chb_show_gryphon = self.group:AddCheckBox(L.OptionGeneralGryphon, 20, 1, function(pChecked)
		if InCombatLockdown() then
			self.chb_show_gryphon:SetChecked(UI_SETTINGS.general.show_gryphon)
			pOption.ShowErrorMessage()
		else
			UI_SETTINGS.general.show_gryphon = pChecked
			self:ShowGryphon()
		end
	end)


  return self
end

function General:Init()
	self.chb_show_gryphon:SetChecked(UI_SETTINGS.general.show_gryphon)

	self:ShowGryphon()
end

function General:ShowGryphon()
	if UI_SETTINGS.general.show_gryphon then
		MainMenuBarArtFrame.LeftEndCap:Show()
		MainMenuBarArtFrame.RightEndCap:Show()
	else
		MainMenuBarArtFrame.LeftEndCap:Hide()
		MainMenuBarArtFrame.RightEndCap:Hide()
	end
end
