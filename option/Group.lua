local AddonName, Addon = ...
local L = Addon.L
local BACKDROP = {
	bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 16,
	tile = true,
	tileSize = 16,
	insets = {left = 4, right = 4, top = 4, bottom = 4}
}

Group = {}
Group.__index = Group;

function Group:new(pOptionFrame, pHeaderText, pLineCount, pOnActiveChange)
	local self = {}
	setmetatable(self, Group)

	self.frame = CreateFrame('Frame', nil, pOptionFrame, 'OptionsBoxTemplate')
	self.frame:SetBackdrop(BACKDROP)
	self.frame:SetBackdropBorderColor(0.4, 0.4, 0.4)
	self.frame:SetBackdropColor(0, 0, 0, 0.3)
	self.frame:SetHeight(pLineCount * 45 + 15)
	self.frame:SetFrameLevel(2)

	if pOnActiveChange ~= nil then
		self.checkbox = CreateFrame('CheckButton', nil, self.frame, 'UICheckButtonTemplate')
		self.checkbox:SetPoint('TOPLEFT', 0, 26)
		self.checkbox:SetScript('OnClick', function(pSelf, pButton, pDown)
			if pSelf:GetChecked() then
				pOnActiveChange(true)
			else
				pOnActiveChange(false)
			end
		end)
	end

	local header = self.frame:CreateFontString(nil, 'BACKGROUND', 'GameFontHighlightSmall')
	header:SetPoint('BOTTOMLEFT', self.frame, 'TOPLEFT', 30, 2)
	header:SetText(pHeaderText)
	header:SetFont(STANDARD_TEXT_FONT, 14, 'THINOUTLINE')

	return self
end

function Group:SetChecked(pValue)
	self.checkbox:SetChecked(pValue)
end

function Group:AddSlider(pTitle, pPosX, pLineIndex, pWidth, pMinValue, pMaxValue, pOnValueChanged)
	return Slider:new(self.frame, pTitle, pPosX, pLineIndex, pWidth, pMinValue, pMaxValue, pOnValueChanged)
end

function Group:AddCheckBox(pTitle, pPosX, pLineIndex, pOnCheckedChange)
	return CheckBox:new(self.frame, pTitle, pPosX, pLineIndex, pOnCheckedChange)
end

function Group:AddComboBox(pTitle, pPosX, pLineIndex, pWidth, pItems, pOnSelectedChange)
	return ComboBox:new(self.frame, pTitle, pPosX, pLineIndex, pWidth, pItems, pOnSelectedChange)
end

function Group:AddText(pTitle, pPosX, pLineIndex)
	return Text:new(self.frame, pTitle, pPosX, pLineIndex)
end
