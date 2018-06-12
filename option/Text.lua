local AddonName, Addon = ...
local L = Addon.L

Text = {}
Text.__index = Text;

function Text:new(pGroupFrame, pTitle, pPosX, pLineIndex)
	local self = {}
	setmetatable(self, Text)

	local text = CreateFrame('Frame', nil, pGroupFrame)
	text:SetWidth(100)
	text:SetHeight(25)
	text:SetPoint('TOPLEFT', pPosX, 45 * (1 - pLineIndex) - 25 + 11)
	text:SetFrameLevel(3)

	local title = text:CreateFontString(nil, 'BACKGROUND', 'GameFontNormalLeft')
	title:ClearAllPoints()
	title:SetPoint('LEFT', 0, 3)
	title:SetText(pTitle)

	return self
end
