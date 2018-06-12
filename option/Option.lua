local AddonName, Addon = ...
local L = Addon.L

Option = {}
Option.__index = Option;

function Option:new()
	local self = {}
	setmetatable(self, Option)

	StaticPopupDialogs['MODEFY_ERROR'] = {
		text = L.OptionErrorMessage,
		button1 = 'OK',
		OnAccept = function()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}

	local frame = CreateFrame('Frame', AddonName)
	frame.name = AddonName
	InterfaceOptions_AddCategory(frame)

	local header = frame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
	header:SetPoint('TOPLEFT', 15, -10)
	header:SetText(AddonName)

	local parent_frame = CreateFrame('Frame', nil, frame)
	parent_frame:SetPoint('TOPLEFT', frame, 'TOPLEFT', 0, -30)
	parent_frame:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', -30, 5)

	local texture = parent_frame:CreateTexture()
	texture:SetAllPoints()
	texture:SetTexture(0.8, 0.8, 0.8, 1)

	local scroll_frame = CreateFrame('ScrollFrame', nil, parent_frame)
	scroll_frame:SetPoint('TOPLEFT', 10, 0)
	scroll_frame:SetPoint('BOTTOMRIGHT', 0, 0)
	scroll_frame:EnableMouseWheel(true)

	self.height = 10;

	self.scrollbar = CreateFrame('Slider', nil, scroll_frame, 'UIPanelScrollBarTemplate')
	self.scrollbar:SetPoint('TOPLEFT', parent_frame, 'TOPRIGHT', 5, 0)
	self.scrollbar:SetPoint('BOTTOMLEFT', parent_frame, 'BOTTOMRIGHT', -5, 20)
	self.scrollbar:SetMinMaxValues(1, self.height)
	self.scrollbar:SetValueStep(1)
	self.scrollbar:SetValue(0)
	self.scrollbar:SetWidth(16)
	self.scrollbar:SetScript('OnValueChanged', function (pSelf, pValue)
		pSelf:GetParent():SetVerticalScroll(pValue)
	end)

	self.content = CreateFrame('Frame', nil, scroll_frame)
	self.content:SetSize(580, self.height)
	self.content:SetFrameLevel(1)

	scroll_frame:SetScrollChild(self.content)
	scroll_frame:SetScript('OnMouseWheel', function(pSelf, pDelta)
		if pDelta < 0 then
			self.scrollbar:SetValue(self.scrollbar:GetValue() + 50)
		else
			if self.scrollbar:GetValue() > 50 then
				self.scrollbar:SetValue(self.scrollbar:GetValue() - 50)
			else
				self.scrollbar:SetValue(0)
			end
		end
	end)

	self.groups = {}

	return self
end

function Option:ShowErrorMessage()
	StaticPopup_Show('MODEFY_ERROR')
	print('RininganUI: Combat mode')
end

function Option:AddGroup(pHeaderText, pLineCount, pOnActiveChange)
	local group = Group:new(self.content, pHeaderText, pLineCount, pOnActiveChange)

	if table.getn(self.groups) == 0 then
		group.frame:SetPoint('TOPLEFT', 0, -25)
		group.frame:SetPoint('TOPRIGHT', 0, -25)
	else
		local previous_frame = self.groups[table.getn(self.groups)]
		group.frame:SetPoint('TOPLEFT', previous_frame, 'BOTTOMLEFT', 0, -25)
		group.frame:SetPoint('TOPRIGHT', previous_frame, 'BOTTOMRIGHT', 0, -25)
	end

	table.insert(self.groups, group.frame)

	self.height = self.height + 48 * pLineCount
	self.scrollbar:SetMinMaxValues(1, self.height)
	self.content:SetSize(580, self.height)

	return group
end
