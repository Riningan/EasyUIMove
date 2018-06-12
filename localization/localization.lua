local _, Addon = ...

local L = {
	OptionErrorMessage = 'Can\'t change this value in combat mode',

	OptionAnchor = 'Anchor',
	OptionPosX = 'Position on X',
	OptionPosY = 'Position on Y',
	OptionScale = 'Scale',
	OptionGeneralGryphon = 'Show gryphons',

	General = 'General',
	Player = 'Player',
	Target = 'Target',
	TargetOfTarget = 'Target of target',
	Focus = 'Focus',
	Castbar = 'Castbar',
	Raid = 'Raid',
}

Addon.L = setmetatable(L, { __index = function(t, k) return k end })
