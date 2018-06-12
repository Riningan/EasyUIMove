local AddonName, Addon = ...
local L = Addon.L

CheckBox = {}
CheckBox.__index = CheckBox;

function CheckBox:new(pGroupFrame, pTitle, pPosX, pLineIndex, pOnCheckedChange)
	local self = {}
	setmetatable(self, CheckBox)

	self.checkbox = CreateFrame('CheckButton', nil, pGroupFrame, 'UICheckButtonTemplate')
	--self.checkbox:SetWidth(pWidth)
	self.checkbox:SetPoint('TOPLEFT', pPosX, 45 * (1 - pLineIndex) - 25 + 11)
	self.checkbox:SetFrameLevel(3)
	self.checkbox:SetScript('OnClick', function(pSelf, pButton, pDown)
		if self.checkbox:GetChecked() then
			pOnCheckedChange(true)
		else
			pOnCheckedChange(false)
		end
	end)

	local title = self.checkbox:CreateFontString(nil, 'BACKGROUND', 'GameFontNormalLeft')
	title:ClearAllPoints()
	title:SetPoint('LEFT', self.checkbox, 'RIGHT')
	title:SetText(pTitle)

	return self
end

function CheckBox:SetChecked(pValue)
	self.checkbox:SetChecked(pValue)
end
