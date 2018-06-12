local AddonName, Addon = ...
local L = Addon.L

Slider = {}
Slider.__index = Slider;

function Slider:new(pGroupFrame, pTitle, pPosX, pLineIndex, pWidth, pMinValue, pMaxValue, pOnValueChanged)
	local self = {}
	setmetatable(self, Slider)

	self.user_manipulation = true

	local frame = CreateFrame('Frame', nil, pGroupFrame)
	frame:SetWidth(pWidth)
	frame:SetHeight(25)
	frame:SetPoint('TOPLEFT', pPosX, 45 * (1 - pLineIndex) - 25)
	frame:SetFrameLevel(3)

	local btnDown = CreateFrame('Button', nil, frame)
	btnDown:SetPoint('LEFT', 0, 0)
	btnDown:SetWidth(15)
	btnDown:SetHeight(15)
	btnDown:SetNormalTexture("Interface/Buttons/UI-MinusButton-UP")
	btnDown:SetPushedTexture("Interface/Buttons/UI-MinusButton-DOWN")

	local btnUp = CreateFrame('Button', nil, frame)
	btnUp:SetPoint('RIGHT', 0, 0)
	btnUp:SetWidth(15)
	btnUp:SetHeight(15)
	btnUp:SetNormalTexture("Interface/Buttons/UI-PlusButton-UP")
	btnUp:SetPushedTexture("Interface/Buttons/UI-PlusButton-DOWN")

	local title = frame:CreateFontString(nil, 'BACKGROUND', 'GameFontNormalLeft')
	title:ClearAllPoints()
	title:SetPoint('BOTTOMLEFT', frame, 'TOPLEFT')
	title:SetText(pTitle)

	self.slider = CreateFrame('Slider', nil, frame, 'OptionsSliderTemplate')
	self.slider:SetMinMaxValues(pMinValue, pMaxValue)
	self.slider:SetValueStep(1)
	self.slider:SetWidth(pWidth - 40)
	self.slider:EnableMouseWheel(true)
	self.slider:SetPoint('CENTER', 0, 0)
	-- _G[slider:GetName() .. 'Low']:SetText(pMinValueTitle)
	-- _G[slider:GetName() .. 'High']:SetText(pMaxValueTitle)

	self.text = frame:CreateFontString(nil, 'BACKGROUND', 'GameFontNormalLarge')
	self.text:ClearAllPoints()
	self.text:SetPoint('TOPRIGHT', 0, 12)
	self.text:SetFont(STANDARD_TEXT_FONT, 12, 'THINOUTLINE')
	self.text:SetTextColor(1, 1, 1)

	self.slider:SetScript('OnValueChanged', function(pSelf, pValue)
		if self.user_manipulation then
			pValue = string.format('%i', pValue)
			self:SetValue(pValue)
			pOnValueChanged(pValue)
		else
			self.user_manipulation = true
		end
	end)

	btnDown:SetScript("OnClick", function(pSelf, pArg)
		local value = self.slider:GetValue()
		if value ~= pMinValue then
			value = value - 1
			self:SetValue(value)
			pOnValueChanged(value)
		end
	end)

	btnUp:SetScript("OnClick", function(pSelf, pArg)
		local value = self.slider:GetValue()
		if value ~= pMaxValue then
			value = value + 1
			self:SetValue(value)
			pOnValueChanged(value)
		end
	end)

	return self
end

function Slider:SetValue(pValue)
	self.user_manipulation = false
	self.slider:SetValue(pValue)
	self.text:SetText(pValue)
end
