local AddonName, Addon = ...
local L = Addon.L

local counter = 0

ComboBox = {}
ComboBox.__index = ComboBox;

function ComboBox:new(pGroupFrame, pTitle, pPosX, pLineIndex, pWidth, pItems, pOnSelectedChange)
	local self = {}
	setmetatable(self, ComboBox)

	self.items = pItems;

	local frame = CreateFrame('Frame', nil, pGroupFrame)
	frame:SetWidth(pWidth)
	frame:SetHeight(25)
	frame:SetPoint('TOPLEFT', pPosX, 45 * (1 - pLineIndex) - 20)
	frame:SetFrameLevel(3)

	local title = frame:CreateFontString(nil, 'BACKGROUND', 'GameFontNormalLeft')
	title:ClearAllPoints()
	title:SetPoint('LEFT', 0, 3)
	title:SetText(pTitle)

	self.menu = CreateFrame('Button', 'RininganUIDropDownMenu'..counter, frame, 'UIDropDownMenuTemplate')
	counter = counter + 1
	self.menu:SetPoint('LEFT', pWidth - 100, 0)

	UIDropDownMenu_Initialize(self.menu, function(pSelf, pLevel)
	   for k, v in pairs(self.items) do
	      local info = UIDropDownMenu_CreateInfo()
	      info.text = v
	      info.value = v
	      info.func = function(pSelf)
				  UIDropDownMenu_SetSelectedID(self.menu, pSelf:GetID())
					pOnSelectedChange(pSelf:GetID())
				end
	      UIDropDownMenu_AddButton(info, pLevel)
	   end
	end)
	UIDropDownMenu_SetWidth(self.menu, 100)
	UIDropDownMenu_SetButtonWidth(self.menu, 124)
	-- UIDropDownMenu_SetSelectedValue(self.menu, self.items[1])
	-- UIDropDownMenu_SetSelectedName(self.menu, self.items[1])
	-- UIDropDownMenu_SetSelectedID(self.menu, 1)
	-- UIDropDownMenu_Refresh(self.menu, self.items[1], 1)

	return self
end

function ComboBox:SetValue(pValue)
	for k, v in pairs(self.items) do
		if v == pValue then
			-- UIDropDownMenu_SetSelectedValue(self.menu, v)
			-- UIDropDownMenu_SetSelectedName(self.menu, v)
			UIDropDownMenu_SetSelectedID(self.menu, k)
			UIDropDownMenu_SetText(self.menu, v)
			-- UIDropDownMenu_Refresh(self.menu, v, 1)
			return
		end
	end
end
