-- Copyright © 2008, 2009 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.

local SpellNames = TotemTimers.SpellNames
local SpellIDs = TotemTimers.SpellIDs

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers", true)

BINDING_NAME_TOTEMTIMERSSET1 = "Set 1"
BINDING_NAME_TOTEMTIMERSSET2 = "Set 2"
BINDING_NAME_TOTEMTIMERSSET3 = "Set 3"
BINDING_NAME_TOTEMTIMERSSET4 = "Set 4"
BINDING_NAME_TOTEMTIMERSSET5 = "Set 5"
BINDING_NAME_TOTEMTIMERSSET6 = "Set 6"
BINDING_NAME_TOTEMTIMERSSET7 = "Set 7"
BINDING_NAME_TOTEMTIMERSSET8 = "Set 8"
BINDING_NAME_TOTEMTIMERSSTORMSTRIKE = "Stormstrike"
BINDING_NAME_TOTEMTIMERSLAVALASH = "Lava Lash"
BINDING_NAME_TOTEMTIMERSEARTHSHOCK = "Earth Shock"
BINDING_NAME_TOTEMTIMERSMULTICAST = "Cast Active Totems"
BINDING_NAME_TOTEMTIMERSMULTICASTMENU = "Open Multicast Menu"

local _G = getfenv()

for i=1,4 do
    local e
    if i==1 then e = L["Fire Button"] elseif i==2 then e=L["Earth Button"] elseif i==3 then e=L["Water Button"] else e=L["Air Button"] end
    for j=1,7 do
        _G["BINDING_NAME_TOTEMTIMERSCAST"..i..j] = e.." "..j
    end
end

local function SetupSpellNames()
    BINDING_NAME_TOTEMTIMERSLIGHTNINGSHIELD = SpellNames[SpellIDs.LightningShield]      
    BINDING_NAME_TOTEMTIMERSWATERSHIELD = SpellNames[SpellIDs.WaterShield]
    BINDING_NAME_TOTEMTIMERSTOTEMICCALL = SpellNames[SpellIDs.TotemicCall]
    BINDING_NAME_TOTEMTIMERSSTORMSTRIKE = SpellNames[SpellIDs.StormStrike]
    BINDING_NAME_TOTEMTIMERSLAVALASH = SpellNames[SpellIDs.LavaLash]
    BINDING_NAME_TOTEMTIMERSEARTHSHOCK = SpellNames[SpellIDs.EarthShock]
end

local menubutton = "Button4"

local buttonnames = {
    [AIR_TOTEM_SLOT] = "XiTimers_Timer"..AIR_TOTEM_SLOT,
    [FIRE_TOTEM_SLOT] = "XiTimers_Timer"..FIRE_TOTEM_SLOT,
    [WATER_TOTEM_SLOT] = "XiTimers_Timer"..WATER_TOTEM_SLOT,
    [EARTH_TOTEM_SLOT] = "XiTimers_Timer"..EARTH_TOTEM_SLOT,
    ["es"] = "XiTimers_Timer7",
    ["wp"] = "XiTimers_Timer8",
}
	
local TotemTimers_Bindings = {
	["TOTEMTIMERSAIR"] = function(key) 
		SetOverrideBindingClick(TotemTimersFrame, false, key, buttonnames[AIR_TOTEM_SLOT])
		getglobal(buttonnames[AIR_TOTEM_SLOT]).hotkey:SetText(GetBindingText(key, "KEY_", 1))
	end,
	["TOTEMTIMERSEARTH"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, buttonnames[EARTH_TOTEM_SLOT])
		getglobal(buttonnames[EARTH_TOTEM_SLOT]).hotkey:SetText(GetBindingText(key, "KEY_", 1))
	end,
	["TOTEMTIMERSFIRE"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, buttonnames[FIRE_TOTEM_SLOT])
		getglobal(buttonnames[FIRE_TOTEM_SLOT]).hotkey:SetText(GetBindingText(key, "KEY_", 1))
	end,
	["TOTEMTIMERSWATER"] = function(key)	
		SetOverrideBindingClick(TotemTimersFrame, false, key, buttonnames[WATER_TOTEM_SLOT])
		getglobal(buttonnames[WATER_TOTEM_SLOT]).hotkey:SetText(GetBindingText(key, "KEY_", 1))
	end,
	["TOTEMTIMERSAIRMENU"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, buttonnames[AIR_TOTEM_SLOT], menubutton)
	end,
	["TOTEMTIMERSEARTHMENU"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, buttonnames[EARTH_TOTEM_SLOT], menubutton)
	end,
	["TOTEMTIMERSFIREMENU"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, buttonnames[FIRE_TOTEM_SLOT], menubutton)
	end,
	["TOTEMTIMERSWATERMENU"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, buttonnames[WATER_TOTEM_SLOT], menubutton)
	end,
	["TOTEMTIMERSLIGHTNINGSHIELD"] = function(key)
		SetOverrideBindingSpell(TotemTimersFrame, false, key, SpellNames[SpellIDs.LightningShield])
	end,
	["TOTEMTIMERSWATERSHIELD"] = function(key)
		SetOverrideBindingSpell(TotemTimersFrame, false, key, SpellNames[SpellIDs.WaterShield])
	end,
	["TOTEMTIMERSTOTEMICCALL"] = function(key)
		SetOverrideBindingSpell(TotemTimersFrame, false, key, SpellNames[SpellIDs.TotemicCall])
	end,
	["TOTEMTIMERSEARTHSHIELDLEFT"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, buttonnames["es"])
	end,
	["TOTEMTIMERSEARTHSHIELDRIGHT"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, buttonnames["es"], "RightButton")
	end,
	["TOTEMTIMERSEARTHSHIELDMIDDLE"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, buttonnames["es"], "MiddleButton")
	end,
	["TOTEMTIMERSWEAPONBUFF1"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, buttonnames["wp"])
	end,
	["TOTEMTIMERSWEAPONBUFF2"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, buttonnames["wp"], "RightButton")
	end,
	["TOTEMTIMERSSTORMSTRIKE"] = function(key)
		SetBindingClick(TotemTimersFrame, false, key, "XiTimers_Timer9")
        XiTimers.timers[9].button.hotkey:SetText(GetBindingText(key, "KEY_", 1))
	end,
	["TOTEMTIMERSLAVALASH"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, "XiTimers_Timer10")
        XiTimers.timers[10].button.hotkey:SetText(GetBindingText(key, "KEY_", 1))
	end,
	["TOTEMTIMERSEARTHSHOCK"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, "XiTimers_Timer11")
        XiTimers.timers[11].button.hotkey:SetText(GetBindingText(key, "KEY_", 1))
	end,
	["TOTEMTIMERSSET1"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, "TotemTimers_SetButton1")
	end,
	["TOTEMTIMERSSET2"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, "TotemTimers_SetButton2")
	end,
	["TOTEMTIMERSSET3"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, "TotemTimers_SetButton3")
	end,
	["TOTEMTIMERSSET4"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, "TotemTimers_SetButton4")
	end,
	["TOTEMTIMERSSET5"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, "TotemTimers_SetButton5")
	end,
	["TOTEMTIMERSSET6"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, "TotemTimers_SetButton6")
	end,
	["TOTEMTIMERSSET7"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, "TotemTimers_SetButton7")
	end,
	["TOTEMTIMERSSET8"] = function(key)
		SetOverrideBindingClick(TotemTimersFrame, false, key, "TotemTimers_SetButton8")
	end,
    ["TOTEMTIMERSMULTICAST"] = function(key)
        SetOverrideBindingClick(TotemTimersFrame, false, key, "TotemTimers_MultiSpell")
        TotemTimers_MultiSpellHotKey:SetText(GetBindingText(key, "KEY_", 1))
    end,
    ["TOTEMTIMERSMULTICASTMENU"] = function(key)
        SetOverrideBindingClick(TotemTimersFrame, false, key, "TotemTimers_MultiSpell", menubutton)
    end,
}


function TotemTimers_SetBinding(key, binding)
    if not TotemTimers_IsSetUp then return end
    for i=1,11 do
        if XiTimers.timers[i].button.hotkey:GetText() == key then
            XiTimers.timers[i].button.hotkey:SetText("")
        end
    end
	if TotemTimers_Bindings[binding] then
		TotemTimers_Bindings[binding](key)
    elseif string.sub(binding,1, 15) == "TOTEMTIMERSCAST" then
        SetOverrideBindingClick(TotemTimersFrame, false, key, "TT_ActionButton"..string.sub(binding,16))
	end
    TotemTimers.ProcessSetting("BarBindings")  
end

function TotemTimers_InitializeBindings()
    SetupSpellNames()
	local key1, key2
    for i=1,11 do
        if i~=7 then XiTimers.timers[i].button.hotkey:SetText("") end
    end
	for binding,_ in pairs(TotemTimers_Bindings) do
		key1, key2 = GetBindingKey(binding)
		if key2 then TotemTimers_Bindings[binding](key2) end
		if key1 then TotemTimers_Bindings[binding](key1) end
	end
    for i=1,4 do
        for j=1,7 do
            key1, key = GetBindingKey("TOTEMTIMERSCAST"..i..j)
            if key2 then SetOverrideBindingClick(TotemTimersFrame, false, key2, "TT_ActionButton"..i..j) end
            if key1 then SetOverrideBindingClick(TotemTimersFrame, false, key1, "TT_ActionButton"..i..j) end
        end
    end
    TotemTimers.ProcessSetting("BarBindings") 
end
