-- Lua Smart Kingpad widget V0.4
--
--
-- A FRSKY widget for the Ethos OS to simulate a Pistenking Kingpad
--
-- Author: Lukas Worbs, https://pistenking.com/
--
-- This file is part of Smart Kingpad.
--
-- Smart Kingpad is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY, without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, see <http://www.gnu.org/licenses>.


local translations = {en="Kingpad Source"}

local function name(widget)
  local locale = system.getLocale()
  return translations[locale] or translations["en"]
end

local function sourceInit(source)
  source:value(0)
  source:decimals(2)
  --source:unit(UNIT_VOLT)
end

local function init()
  system.registerSource({key="Kingpad", name=name, create=sourceInit})
end

return {init=init}