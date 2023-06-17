-- Lua Smart Kingpad widget V1.01
--
--
-- A FRSKY widget for the Ethos OS to simulate a Pistenking Kingpad
--
-- Author: Lukas Worbs, https://pistenking.com/
-- Modyfied by Thomas RUDOLF
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


local version = "V1.01"
local translations = {en="Kingpad", de="Kingpad"}
icon = {}

local function name(widget)
    local locale = system.getLocale()
    return translations[locale] or translations["en"]
 --   return translations["en"]
end

local function create()
    
    local locale = system.getLocale()

    local names = {}
    local taste
    local config = {}
    local turnoff

    if locale == "de" then
        names = {
            {"Licht +", 1}, 
            {"Licht -", 2}, 
            {"Blinker Links", 3}, 
            {"Warnblinker", 4}, 
            {"Blinker Rechts", 5}, 
            {"Rundumlicht", 6}, 
            {"Lichthupe", 7}, 
            {"Nebelschlusslicht", 8}, 
            {"Nebelscheinwerfer", 9}, 
            {"Arbeitsscheinwerfer Hinten", 10}, 
            {"Arbeitsscheinwerfer Vorne", 11}, 
            {"F1", 12}, 
            {"Hupe", 13}, 
            {"Rückfahrwarner ausschalten", 14}, 
            {"Fahrsound ein/aus", 15}, 
            {"Lautstärke +", 16}, 
            {"Lautstärke -", 17}, 
            {"Ton aus", 18}, 
            {"WAV-Player: Play/Stop", 19}, 
            {"WAV-Player: Pause", 20}, 
            {"WAV-Player: Titel vor", 21}, 
            {"WAV-Player: Titel zurück", 22}, 
            {"Spiel mit Gaspedal", 23}, 
            {"Fahrsound Drehzahl", 24}
        }
    
        taste = "Taste "
        turnoff = "Widget Titel ausschalten"

        config = {
           {"Kingpad Art", 0, {{"Lkw", 0}, {"Pistenbully", 1}}},
            {"Kingpad Ebene", 0, {{"Licht", 0}, {"Sound", 1}}},
          {"Tasten zurücksetzen", nil, "Reset Kingpad"},
            {"Kingpad einlernen", nil, "Kingpad einlernen"}
        }
    else    -- English
        names = {
            {"parking light", 1}, 
            {"low beam", 2}, 
            {"high beam", 3}, 
            {"front working lights", 4}, 
            {"fog lights", 5}, 
            {"rotating beacon", 6}, 
            {"reversing light", 7}, 
            {"rear working light", 8}, 
            {"left turn signal", 9}, 
            {"hazard warning lights", 10}, 
            {"right turn signal", 11}, 
            {"S-Button", 12}, 
            {"legs up", 13}, 
            {"legs down", 14}, 
            {"ramp up", 15}, 
            {"ramp down", 16}, 
            {"manual steering", 17}, 
            {"+", 18}, 
            {"F1", 19}, 
            {"trailer hitch", 20}, 
            {"inverse", 21}, 
            {"-", 22}, 
            {"F2", 23}, 
            {"F3", 24}
        }
    
        taste = "Button "
        turnoff = "Turn off widget title"
        
        config = {
            {"Kingpad type", 0, {{"Lkw", 0}, {"Pistenbully", 1}}},
            {"Kingpad level", 0, {{"light", 0}, {"funktion", 1}}},
            {"reset buttons", nil, "reset Kingpad"},
            {"teach in Kingpad", nil, "teach in Kingpad"}
        }
    end

    local parameters = { -- Bezeichnung in der Konfig, Auswahl für Anzeige, Tastenname + Reihenfolge, reset Anzeige
    {taste, 1, names, 1},
    {taste, 2, names, 2},
    {taste, 3, names, 3},
    {taste, 4, names, 4},
    {taste, 5, names, 5},
    {taste, 6, names, 6},
    {taste, 7, names, 7},
    {taste, 8, names, 8},
    {taste, 9, names, 9},
    {taste, 10, names, 10},
    {taste, 11, names, 11},
    {taste, 12, names, 12},
    {taste, 13, names, 13},
    {taste, 14, names, 14},
    {taste, 15, names, 15},
    {taste, 16, names, 16},
    {taste, 17, names, 17},
    {taste, 18, names, 18},
    {taste, 19, names, 19},
    {taste, 20, names, 20},
    {taste, 21, names, 21},
    {taste, 22, names, 22},
    {taste, 23, names, 23},
    {taste, 24, names, 24}
    }

    local colors = {
        0xF000500,
        0xF000500,
        0xF000500,
        0xF000500,
        0xF000500,
        0xF000500,
        0xF000500,
        0xF000500,
        0xF000500,
        0xF000500,
        0xF000500,
        0xF000500,
        0xF00FCA0, --orange
        0xF00FCA0, --orange
        0xF00F800, --rot       0xF0054DF blau
        0xF00F800, --rot
        0xF00F800, --rot
        0xF00F800, --rot
        0xF000500, --grün
        0xF000500, --grün
        0xF000500, --grün
        0xF000500, --grün
        0xF008410, --grau
        0xF008410, --grau
    }

    
    return {r=0, g=0, b=255, pr=4, names=names, parameters=parameters, config=config, configChange=0, _h=nil, _w=nil, h=nil, w=nil, colors=colors, but=nil, turnoff=turnoff}
end




local function getValue(parameter)
    if parameter[2] == nil then
      return 0
    else
      return parameter[2]
    end
  end

local function setValue(parameter, value)
    parameter[2] = value
    --modifications[#modifications+1] = {parameter[3], value}
    --for index = 1, #fields do
    --  fields[index]:enable(false)
    --end
  end

local function calcWidget(widget)
    -- get the correct source
    widget.source = system.getSource({name="Kingpad Source"})
    -- calculate the button arrangement
    local _h, _w, h, w 
    seize=70
    w, h = lcd.getWindowSize()
    _h = (h/seize)
    _w = (w/seize)
    _w = math.floor(_w)
    _h = math.floor(_h)
    while _w * _h > 12 do
        seize = seize+1
        _w = math.floor(w/seize)
        _h = math.floor(h/seize)
    end
    while (w - _w*seize)/(_w+1) < 9 do
        _w = _w - 1
    end
    while (h - _h*seize)/(_h+1) < 9 do
        _h = _h - 1
    end
    while (_w < 6 and seize > 80) or (w - _w*seize)/(_w+1) < 9 do
        seize = seize-1
        _w = math.floor(w/seize)
    end
    while _h < 3 and seize > 110 or (h - _h*seize)/(_h+1) < 9 do
        seize = seize-1
        _h = math.floor(h/seize)
    end
    while ((h - _h*seize)/(_h+1) > 12 and (w - _w*seize)/(_w+1) > 12) do
        seize = seize+1
    end
    widget.h = h
    widget._h = _h
    widget.w = w
    widget._w = _w
    widget.seize = seize
end

local function configKP(widget)
    -- switch between light and function
    local reset = widget.config[3]
    local switch = widget.config[2]
    for i=1, 12 do
        local parameter = widget.parameters[i]
        local parameter1 = widget.parameters[i+12]
        if (parameter[2] == parameter1[4] or reset[2] == 1) and switch[2] == 0 then
            parameter[2] = parameter[4]
            widget.parameters[i] = parameter
        end
        if (parameter1[2] == parameter[4] or reset[2] == 1) and switch[2] == 0 then
            parameter1[2] = parameter1[4]
            widget.parameters[i+12] = parameter1
        end
        if (parameter[2] == parameter[4] or reset[2] == 1) and switch[2] == 1 then
            parameter[2] = parameter1[4]
            widget.parameters[i] = parameter
        end
        if (parameter1[2] == parameter1[4] or reset[2] == 1) and switch[2] == 1 then
            parameter1[2] = parameter[4]
            widget.parameters[i+12] = parameter1
        end
    end
  --  if reset[2] == 1 then
  --      for i = 1, 24 do
  --          local parameter = widget.parameters[i]
  --          parameter[2] = parameter[4]
  --          widget.parameters[i] = parameter
  --      end
  --  end

end


local function buttonToValue(but, parameter, widget)
    if but > 0 then
        --local parameter = widget.parameters[but]
        number = parameter[2]
     --   widget.source:value((parameter[2]-6.5)*170)
     --   print("Value ", (parameter[2]-6.5)*170)
        local value = 0
        local factor = 85
        if parameter[2] == 1 then value = -12*factor
        elseif parameter[2] == 2 then value = -11*factor
        elseif parameter[2] == 3 then value = -10*factor
        elseif parameter[2] == 4 then value = -9*factor
        elseif parameter[2] == 5 then value = -8*factor
        elseif parameter[2] == 6 then value = -7*factor
        elseif parameter[2] == 7 then value = -6*factor
        elseif parameter[2] == 8 then value = -5*factor
        elseif parameter[2] == 9 then value = -4*factor
        elseif parameter[2] == 10 then value = -3*factor
        elseif parameter[2] == 11 then value = -2*factor
        elseif parameter[2] == 12 then value = -1*factor
        elseif parameter[2] == 13 then value = 12*factor
        elseif parameter[2] == 14 then value = 11*factor
        elseif parameter[2] == 15 then value = 10*factor
        elseif parameter[2] == 16 then value = 9*factor
        elseif parameter[2] == 17 then value = 8*factor
        elseif parameter[2] == 18 then value = 7*factor
        elseif parameter[2] == 19 then value = 6*factor
        elseif parameter[2] == 20 then value = 5*factor
        elseif parameter[2] == 21 then value = 4*factor
        elseif parameter[2] == 22 then value = 3*factor
        elseif parameter[2] == 23 then value = 2*factor
        elseif parameter[2] == 24 then value = 1*factor
        end
        widget.source:value(value)
       -- print("Value ", value)
    end
end


local function paint(widget)
    --lcd.drawLine(0, h/2, w, h/2)
    lcd.color(lcd.RGB(widget.r, widget.g, widget.b))
    --for i = 0,w do
    --  local val = math.sin(i*math.pi/(w/widget.pr))
    --  lcd.drawPoint(i, val*h/2+h/2)
    --end    
    if(widget.h == nil) then
        calcWidget(widget)
    --    configKP(widget)
    end
    local h=widget.h
    local _h=widget._h
    local w=widget.w
    local _w=widget._w
    local seize = widget.seize
    lcd.color(0xF002945)
    lcd.drawFilledRectangle(4, 4, w-8, h-8)

    for j = 0, _h - 1 do
        for i=0, _w - 1 do
            --lcd.color((i+j*_w)*25782000*4+25782000*4)
            local parameter = widget.parameters[(i+1)+(j*_w)]
            local helper = parameter[3]
            local name = helper[parameter[2]]
         --   print("taste " .. (i+1)+(j*_w) .. " para2 " .. parameter[2] .. " name " .. name[1] .. " value " .. name[2])
                --            else
            
                if widget.but == (j*_w) + (i+1) then
                    lcd.color(0xF00FFE0)                    --hinterlege die aktuell gedrückte Taste gelb
                else
                    lcd.color(0xF00B596)
                end
           --     if widget.source:value() == 0 then
           --         lcd.color(0xF00B596)
           --     end
                lcd.drawFilledCircle((w - _w*seize)/(_w+1) * (i+1) + i*seize + seize/2, (h - _h*seize)/(_h+1) * (j+1) + j*seize + seize/2, seize/2)
                lcd.color(widget.colors[name[2]])
                lcd.drawFilledCircle((w - _w*seize)/(_w+1) * (i+1) + i*seize + seize/2, (h - _h*seize)/(_h+1) * (j+1) + j*seize + seize/2, (seize-2)/2)
             --   lcd.color(0xF00B596)
             --   lcd.drawFilledRectangle((w - _w*seize)/(_w+1) * (i+1) + i*seize, (h - _h*seize)/(_h+1) * (j+1) + j*seize, seize, seize)
             --   lcd.color(widget.colors[parameter[2]])
             --   lcd.drawFilledRectangle((w - _w*seize)/(_w+1) * (i+1) + i*seize+ 2, (h - _h*seize)/(_h+1) * (j+1) + j*seize + 2, seize-4, seize-4)
                --lcd.font(XXL)
                --lcd.color(RED)
                --local parameter = widget.parameters[(i+1)+(j*_w)]
                --lcd.drawText((w - _w*seize)/(_w+1) * (i+1) + i*seize +seize/2, (h - _h*seize)/(_h+1) * (j+1) + j*seize + seize/2 -12, parameter[2], CENTERED)
   --         end
        --    if parameter[2] == 1 then
        lcd.drawBitmap((w - _w*seize)/(_w+1) * (i+1) + i*seize + 1, (h - _h*seize)/(_h+1) * (j+1) + j*seize +1, icon[name[2]], seize -2, seize-2)
       -- lcd.drawMask((w - _w*seize)/(_w+1) * (i+1) + i*seize + 1, (h - _h*seize)/(_h+1) * (j+1) + j*seize +1, icon[name[2]])
                --lcd.drawBitmap(10, 5, icon, 70, 70)
         --   end
        end
    end

    if _w*_h == 0 then
        lcd.font(XXL)
        lcd.color(RED)
        local tw, th = lcd.getTextSize(widget.turnoff)
        lcd.drawText(w/2, h/2-(th/2), widget.turnoff, CENTERED)
    end

end


local function event(widget, category, value, x, y)
 --   print("Event received:", category, value, x, y)
lcd.invalidate()
 local h=widget.h
 local _h=widget._h
 local w=widget.w
 local _w=widget._w
 local seize = widget.seize

    if category == EVT_TOUCH and value == 16640 then

        local but = 0
        local number = 0
        for i=0, _w do
            if ((w - _w*seize)/(_w+1) * (i+1) + i*seize < x) and (x < (w - _w*seize)/(_w+1) * (i+1) + (i+1)*seize) then
                but = i+1
            end
        end
        if but ~= 0 then
            j = 0
            while j < _h do
               if ((h - _h*seize)/(_h+1) * (j+1) + j*seize < y) and (y < (h - _h*seize)/(_h+1) * (j+1) + (j+1)*seize) then
                    but = but+j*_w
                    j = _h
                elseif j == _h-1 then 
                    but = 0
                end
                j = j+1
            end
        end
        if but > 0 then 
            system.playHaptic(50)
        end
        --print("Button ", but)
        widget.but = but 
        buttonToValue(but, widget.parameters[but], widget)
        

     --      lcd.invalidateWindow()
        system.killEvents(value)
        return true
    elseif category == EVT_TOUCH and value == 16641 then
        widget.source:value(0)
        widget.but = 0
        return true
    else
    -- system.killEvents(event)
        return false
    end
end

local function sleep(s)
    local ntime = os.clock() + s
    repeat until os.clock() > ntime
end


local function read(widget)
    widget.source = storage.read("KPsource")
    for i=1 , 12 do
        local para = widget.parameters[i]
        para[2] = storage.read("KPParams" .. i)
        if para[2] then     -- only update if there is something in the storage
            widget.parameters[i] = para
        end
    end
    for i=1 , 2 do
        local para = widget.config[i]
        para[2] = storage.read("KPConfig" .. i)
        if para[2] then
            widget.config[i] = para
        end
    end
end

local function write(widget)
    storage.write("KPsource", widget.source)
    for i=1 , 12 do
        local para = widget.parameters[i]
        storage.write("KPParams"..i, para[2])
    end
    for i=1 , 2 do
        local para = widget.config[i]
        storage.write("KPConfig"..i, para[2])
    end
end


local function configure(widget)
    --print("lcd ", lcd.getWindowSize())
    form.onWakeup(
        function() 
        local switch = widget.config[2]
        if widget.configChange == 1 then
            configKP(widget) 
            widget.configChange = 0
        end
        local resetKP = widget.config[3]
        if resetKP[2] == 1 then
            configKP(widget)
            --write(widget)
            form.invalidate()
            lcd.invalidate()
            resetKP[2] = 0
            widget.config[3] = resetKP
        end 
        local learnKP = widget.config[4]
        if learnKP[2] == 1 then
            form.invalidate()
            for i = 1, 24 do
                local but = {0, i}
                --sleep(0.5)
                widget.source:value(0)
                sleep(0.25)
                buttonToValue(i, but, widget)
                sleep(0.25)
            end
            widget.source:value(0)
            lcd.invalidate()
            learnKP[2] = 0
            widget.config[4] = learnKP
            form.invalidate()
        end
        form.invalidate() 
    end)

   -- print(system.getSource({name="Kingpad Source"}))
    -- select lkw or pistenbully
 --   local parameter = widget.config[2]
 --   local line = form.addLine(parameter[1])
 --   local field = form.addChoiceField(line, nil, parameter[3], function() return getValue(parameter) end, function(value) setValue(parameter, value) end)
    -- Kingpad einlernen
    local parameter = widget.config[4]
    local line = form.addLine(parameter[1])
    local field = form.addTextButton(line, nil, parameter[3], function() return setValue(parameter, 1) end)
    -- select light or function
    local parameter = widget.config[2]
    local line = form.addLine(parameter[1])
    local field = form.addChoiceField(line, nil, parameter[3], function() return getValue(parameter) end, function(value) widget.configChange = 1 setValue(parameter, value) end)
    

    local h=widget.h
    local _h=widget._h
    local w=widget.w
    local _w=widget._w

    if _w then
        if _w > 0 then
        -- reset Kingpad
            local parameter = widget.config[3]
            local line = form.addLine(parameter[1])
            local field = form.addTextButton(line, nil, parameter[3], function() return setValue(parameter, 1) end)
    
 --   if _w*_h < 12 then
            for index = 1, _w*_h do
                local parameter = widget.parameters[index]
                local line = form.addLine(parameter[1] .. index)
                local field = form.addChoiceField(line, nil, parameter[3], function() return getValue(parameter) end, function(value) setValue(parameter, value) end)
            end
        end
    end
        --elseif _w * _h >= 12 then

    -- Source choice
   -- local line = form.addLine("Lua Source")
   -- form.addSourceField(line, nil, function() return widget.source end, function(value) widget.source = value end)

    -- display Version
    local line = form.addLine("Kingpad Version")
    form.addStaticText(line, nil, version)
    
 --   end
--    storage.write("KPParams1", 1)
--    print("storage", storage.read("KPParams1"))
    widget.h = nil
end


local function wakeup(widget)
    
end

local function init()
   -- icon = lcd.loadBitmap("/scripts/001.png")
    for i = 1, 24 do
        icon[i] = lcd.loadBitmap("/scripts/Kingpad/Piktogramme/0" .. i .. ".png")
        --icon[i] = lcd.loadMask("/scripts/Kingpad/Piktogramme/0" .. i .. ".png")
    end
    system.registerWidget({key="KP", name=name, create=create, paint=paint, event=event, configure=configure, read=read, write=write, wakeup=wakeup})
end

return {init=init}