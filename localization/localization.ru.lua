if GetLocale() ~= 'ruRU' then
	return
end

local _, Addon = ...
local L = Addon.L

L.OptionErrorMessage = 'Нельзя именить это значение в бою'

L.OptionAnchor = 'Прикрепить к'
L.OptionPosX = 'Позиция по X'
L.OptionPosY = 'Позиция по Y'
L.OptionScale = 'Маштаб'
L.OptionGeneralGryphon = 'Показывать грифонов'

L.General = 'Общие настройки'
L.Player = 'Игрок'
L.Target = 'Цели'
L.TargetOfTarget = 'Цель цели'
L.Focus = 'Фокуса'
L.Castbar = 'Применение заклинания'
L.Raid = 'Рейд'
