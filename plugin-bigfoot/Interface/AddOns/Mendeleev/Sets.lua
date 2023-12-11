﻿local BB = LibStub("LibBabble-Boss-3.0"):GetLookupTable()
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BC = LibStub("LibBabble-Class-3.0"):GetLookupTable()
local L = LibStub("AceLocale-3.0"):GetLocale("Mendeleev")

MENDELEEV_SETS = {
	{
		name = L["Gathering skills"],
		setindex = "Tradeskill.Gather",
		colour = "|cff8470FF",
		header = L["Gathering skills"],
		quality = 1,
		sets = {
			["Tradeskill.Gather.Disenchant"] = GetSpellInfo(13262),
			["Tradeskill.Gather.Fishing"] = GetSpellInfo(13615),
			["Tradeskill.Gather.Herbalism"] = GetSpellInfo(9134),
			["Tradeskill.Gather.Milling"] = GetSpellInfo(51005),
			["Tradeskill.Gather.Mining"] = GetSpellInfo(12560),
			["Tradeskill.Gather.Pickpocketing"] = GetSpellInfo(5167),
			["Tradeskill.Gather.Prospecting"] = GetSpellInfo(32177),
			["Tradeskill.Gather.Skinning"] = GetSpellInfo(13697),
		},
	},
	{
		name = L["Crafted by"],
		setindex = "Tradeskill.Crafted",
		colour = "|cff8470ff",
		header = L["Crafted by"],
		useval = function (v) return " ("..v..")" end,
		quality = 1,
		sets = {
			["Tradeskill.Crafted.Alchemy"] = GetSpellInfo(2259),
			["Tradeskill.Crafted.Blacksmithing.Basic"] = GetSpellInfo(2018),
			["Tradeskill.Crafted.Blacksmithing.Armorsmith"] = GetSpellInfo(9788),
			["Tradeskill.Crafted.Blacksmithing.Weaponsmith.Axesmith"] = GetSpellInfo(17041),
			["Tradeskill.Crafted.Blacksmithing.Weaponsmith.Hammersmith"] = GetSpellInfo(17040),
			["Tradeskill.Crafted.Blacksmithing.Weaponsmith.Swordsmith"] = GetSpellInfo(17039),
			["Tradeskill.Crafted.Blacksmithing.Weaponsmith.Basic"] = GetSpellInfo(9787),
			["Tradeskill.Crafted.Cooking"] = GetSpellInfo(2550),
			["Tradeskill.Crafted.Engineering.Basic"] = GetSpellInfo(4036),
			["Tradeskill.Crafted.Engineering.Gnomish"] = GetSpellInfo(20220),
			["Tradeskill.Crafted.Engineering.Goblin"] = GetSpellInfo(20221),
			["Tradeskill.Crafted.First Aid"] = GetSpellInfo(3273),
			["Tradeskill.Crafted.Inscription"] = GetSpellInfo(45357),
			["Tradeskill.Crafted.Jewelcrafting"] = GetSpellInfo(25229),
			["Tradeskill.Crafted.Leatherworking.Basic"] = GetSpellInfo(2108),
			["Tradeskill.Crafted.Leatherworking.Dragonscale"] = GetSpellInfo(10657),
			["Tradeskill.Crafted.Leatherworking.Elemental"] = GetSpellInfo(10659),
			["Tradeskill.Crafted.Leatherworking.Tribal"] = GetSpellInfo(10661),
			["Tradeskill.Crafted.Tailoring.Basic"] = GetSpellInfo(3908),
			["Tradeskill.Crafted.Tailoring.Mooncloth"] = GetSpellInfo(26798),
			["Tradeskill.Crafted.Tailoring.Shadoweave"] = GetSpellInfo(26801),
			["Tradeskill.Crafted.Tailoring.Spellfire"] = GetSpellInfo(26797),
		},
	},
	{
		name = L["Mine Gems"],
		setindex = "Tradeskill.Gather.GemsInNodes",
		colour = "|cffB0C4DE",
		header = L["Found in"],
		quality = 1,
		sets = {
			["Tradeskill.Gather.GemsInNodes.Copper Vein"] = L["Copper Vein"],
			["Tradeskill.Gather.GemsInNodes.Tin Vein"] = L["Tin Vein"],
			["Tradeskill.Gather.GemsInNodes.Silver Vein"] = L["Silver Vein"],
			["Tradeskill.Gather.GemsInNodes.Iron Deposit"] = L["Iron Deposit"],
			["Tradeskill.Gather.GemsInNodes.Gold Vein"] = L["Gold Vein"],
			["Tradeskill.Gather.GemsInNodes.Mithril Deposit"] = L["Mithril Deposit"],
			["Tradeskill.Gather.GemsInNodes.Truesilver Deposit"] = L["Truesilver Deposit"],
			["Tradeskill.Gather.GemsInNodes.Small Thorium Vein"] = L["Small Thorium Vein"],
			["Tradeskill.Gather.GemsInNodes.Hakkari Thorium Vein"] = L["Hakkari Thorium Vein"],
			["Tradeskill.Gather.GemsInNodes.Rich Thorium Vein"] = L["Rich Thorium Vein"],
			["Tradeskill.Gather.GemsInNodes.Dark Iron Deposit"] = L["Dark Iron Deposit"],
			["Tradeskill.Gather.GemsInNodes.Adamantite Deposit"] = L["Adamantite Deposit"],
			["Tradeskill.Gather.GemsInNodes.Fel Iron Deposit"] = L["Fel Iron Deposit"],
			["Tradeskill.Gather.GemsInNodes.Khorium Vein"] = L["Khorium Vein"],
			["Tradeskill.Gather.GemsInNodes.Rich Adamantite Deposit"] = L["Rich Adamantite Deposit"],
			["Tradeskill.Gather.GemsInNodes.Cobalt Deposit"] = L["Cobalt Deposit"],
			["Tradeskill.Gather.GemsInNodes.Rich Cobalt Deposit"] = L["Rich Cobalt Deposit"],
			["Tradeskill.Gather.GemsInNodes.Saronite Deposit"] = L["Saronite Deposit"],
			["Tradeskill.Gather.GemsInNodes.Rich Saronite Deposit"] = L["Rich Saronite Deposit"],
			["Tradeskill.Gather.GemsInNodes.Titanium Vein"] = L["Titanium Vein"],
		},
	},
	{
		name = L["Trade skills"],
		setindex = "Tradeskill.Mat.ByProfession",
		colour = "|cffF5DEB3",
		header = L["Component in"],
		quality = 1,
		descfunc = function(skill, reagent) return Mendeleev:GetLinesForTradeskillReagent(skill, reagent) end,
		sets = {
			["Tradeskill.Mat.ByProfession.Alchemy"] = "Alchemy",
			["Tradeskill.Mat.ByProfession.Blacksmithing.Armorsmith"] = "Blacksmithing.Armorsmith",
			["Tradeskill.Mat.ByProfession.Blacksmithing.Basic"] = "Blacksmithing.Basic",
			["Tradeskill.Mat.ByProfession.Blacksmithing.Weaponsmith.Axesmith"] = "Blacksmithing.Weaponsmith.Axesmith",
			["Tradeskill.Mat.ByProfession.Blacksmithing.Weaponsmith.Basic"] = "Blacksmithing.Weaponsmith.Basic",
			["Tradeskill.Mat.ByProfession.Blacksmithing.Weaponsmith.Hammersmith"]	= "Blacksmithing.Weaponsmith.Hammersmith",
			["Tradeskill.Mat.ByProfession.Blacksmithing.Weaponsmith.Swordsmith"] = "Blacksmithing.Weaponsmith.Swordsmith",
			["Tradeskill.Mat.ByProfession.Cooking"] = "Cooking",
			["Tradeskill.Mat.ByProfession.Enchanting"] = "Enchanting",
			["Tradeskill.Mat.ByProfession.Engineering.Basic"] = "Engineering.Basic",
			["Tradeskill.Mat.ByProfession.Engineering.Gnomish"] = "Engineering.Gnomish",
			["Tradeskill.Mat.ByProfession.Engineering.Goblin"] = "Engineering.Goblin",
			["Tradeskill.Mat.ByProfession.First Aid"] = "First Aid",
			["Tradeskill.Mat.ByProfession.Inscription"] = "Inscription",
			["Tradeskill.Mat.ByProfession.Jewelcrafting"] = "Jewelcrafting",
			["Tradeskill.Mat.ByProfession.Leatherworking.Basic"] = "Leatherworking.Basic",
			["Tradeskill.Mat.ByProfession.Leatherworking.Dragonscale"] = "Leatherworking.Dragonscale",
			["Tradeskill.Mat.ByProfession.Leatherworking.Elemental"] = "Leatherworking.Elemental",
			["Tradeskill.Mat.ByProfession.Leatherworking.Tribal"] = "Leatherworking.Tribal",
			["Tradeskill.Mat.ByProfession.Poisons"] = "Poisons",
			["Tradeskill.Mat.ByProfession.Smelting"] = "Smelting",
			["Tradeskill.Mat.ByProfession.Tailoring.Basic"] = "Tailoring.Basic",
			["Tradeskill.Mat.ByProfession.Tailoring.Mooncloth"] = "Tailoring.Mooncloth",
			["Tradeskill.Mat.ByProfession.Tailoring.Shadoweave"] = "Tailoring.Shadoweave",
			["Tradeskill.Mat.ByProfession.Tailoring.Spellfire"] = "Tailoring.Spellfire",
		},
	},
	{
		name = L["Class Reagents"],
		setindex = "Misc.Reagent.Class",
		colour = "|cffff00ff",
		header = L["Classes"],
		quality = 1,
		sets = {
			["Misc.Reagent.Class.Death Knight"] = BC["Deathknight"],
			["Misc.Reagent.Class.Druid"] = BC["Druid"],
			["Misc.Reagent.Class.Hunter"] = BC["Hunter"],
			["Misc.Reagent.Class.Mage"] = BC["Mage"],
			["Misc.Reagent.Class.Paladin"] = BC["Paladin"],
			["Misc.Reagent.Class.Priest"] = BC["Priest"],
			["Misc.Reagent.Class.Rogue"] = BC["Rogue"],
			["Misc.Reagent.Class.Shaman"] = BC["Shaman"],
			["Misc.Reagent.Class.Warlock"] = BC["Warlock"],
			["Misc.Reagent.Class.Warrior"] = BC["Warrior"],
		},
	},
	{
		name = L["Food type"],
		setindex = "Consumable.Food",
		colour = "|cff87CEFA",
		header = L["Food type"],
		quality = 1,
		sets = {
			["Consumable.Food.Bread"] = L["Bread"],
			["Consumable.Food.Fish"] = L["Fish"],
			["Consumable.Food.Meat"] = L["Meat"],
			["Consumable.Food.Cheese"] = L["Cheese"],
			["Consumable.Food.Fruit"] = L["Fruit"],
			["Consumable.Food.Fungus"] = L["Fungus"],
			["Consumable.Food.Misc"] = L["Misc"],
		},
	},
	{
		name = L["Recipe source"],
		setindex = "Tradeskill.Recipe",
		colour = "|cff8470FF",
		header = L["Recipe source"],
		useval = function (v) return " ("..v..")" end,
		--PT3's value is minimum skill and not price
		--[[useval = function (v)
			v = math.floor(v)
			if v == 0 then return "" end
			local g = v > 9999 and floor(v/10000) or 0
			v = v-(g*10000)
			local s = v > 99 and floor(v/100) or 0
			v = v-(s*100)
			local c = v
			return " ("..(g>0 and (g.."g ") or "").. (((g+s)>0) and (s.."s ") or "").. c.. "c)"
		end, ]]
		quality = 1,
		sets = {
			["Tradeskill.Recipe.Vendor"] = L["Vendor"],
			["Tradeskill.Recipe.Drop"] = L["Drop"],
			["Tradeskill.Recipe.Quest"] = L["Quest"],
			["Tradeskill.Recipe.Crafted"] = L["Crafted"],
		},
	},
	{
		name = L["Booze"],
		setindex = "Misc",
		colour = "|cffB0C4DE",
		header = " ",
		useval = function (v) return string.format(L["%d%% alc/vol (%d proof)"], v, v*2) end,
		quality = 1,
		sets = {
			["Misc.Booze"] = L["Booze"],
		},
	},
	{
		name = L["Darkmoon Faire"],
		setindex = "QuestMats.Darkmoon Faire.Turnin",
		colour = "|cffFFFF00",
		header = L["Darkmoon Faire"],
		useval = function (v) return string.format(L[" (%d tickets)"], v) end,
		quality = 1,
		sets = {
			["QuestMats.Darkmoon Faire.Turnin.Engineering"] = GetSpellInfo(4036),
			["QuestMats.Darkmoon Faire.Turnin.Greys"] = L["Junk Items"],
			["QuestMats.Darkmoon Faire.Turnin.Leather"] = L["Leather"],
			["QuestMats.Darkmoon Faire.Turnin.Blacksmithing"] = GetSpellInfo(2018),
		},
	},
	{
		name = L["Darkmoon Faire Card"],
		setindex = "QuestMats.Darkmoon Faire.Deck",
		colour = "|cffFFFF00",
		header = L["Darkmoon Faire Card"],
		quality = 1,
		sets = {
			["QuestMats.Darkmoon Faire.Deck.Beasts"] = L["Blue Dragon Card"],
			["QuestMats.Darkmoon Faire.Deck.Warlords"] = L["Heroism Card"],
			["QuestMats.Darkmoon Faire.Deck.Portals"] = L["Twisting Nether Card"],
			["QuestMats.Darkmoon Faire.Deck.Elementals"] = L["Maelstrom Card"],
			["QuestMats.Darkmoon Faire.Deck.Blessings"] = L["Crusade Card"],
			["QuestMats.Darkmoon Faire.Deck.Furies"] = L["Vengeance Card"],
			["QuestMats.Darkmoon Faire.Deck.Lunacy"] = L["Madness Card"],
			["QuestMats.Darkmoon Faire.Deck.Storms"] = L["Wrath Card"],
			["QuestMats.Darkmoon Faire.Deck.Prisms"] = L["Illusion Card"],
			["QuestMats.Darkmoon Faire.Deck.Chaos"] = L["Berserker! Card"],
			["QuestMats.Darkmoon Faire.Deck.Nobles"] = L["Greatness Card"],
			["QuestMats.Darkmoon Faire.Deck.Undeath"] = L["Death Card"],
		},
	},
	{
		name = L["Lockpicking"],
		setindex = "Misc",
		colour = "|cffFFFF00",
		header = " ",
		useval = function (v) return string.format(" (%d)", v) end,
		quality = 1,
		sets = {
			["Misc.Unlock.Skeleton Keys"] = L["Lockpicking"],
			["Misc.Lockboxes"] = L["Lockpicking"],
			["Misc.Unlock.Seaforium Charges"] = L["Lockpicking"],
		}
	},
	{
		name = L["Fits special bag"],
		setindex = "Misc.Container.ItemsInType",
		colour = "|cff00ff9a",
		header = L["Fits special bag"],
		quality = 1,
		sets = {
			["Misc.Container.ItemsInType.Herb"] = L["SPECIALBAG_HERB"],
			["Misc.Container.ItemsInType.Enchanting"] = L["SPECIALBAG_ENCHANTING"],
			["Misc.Container.ItemsInType.Engineering"] = L["SPECIALBAG_ENGINEERING"],
			["Misc.Container.ItemsInType.Gem"] = L["SPECIALBAG_GEM"],
			["Misc.Container.ItemsInType.Inscription"] = L["SPECIALBAG_INSCRIPTION"],
			["Misc.Container.ItemsInType.Leatherworking"] = L["SPECIALBAG_LEATHERWORKING"],
			["Misc.Container.ItemsInType.Mining"] = L["SPECIALBAG_MINING"],
			["Misc.Container.ItemsInType.Soul Shard"] = L["SPECIALBAG_SOULSHARD"],
		},
	},
}

table.insert(MENDELEEV_SETS, {
	name = L["Bought for"],
	setindex = "CurrencyItems",
	colour = "|cffB0C4DE",
	header = L["Bought for"],
	descfunc = function(desc, item, val) return string.format("%d |T%s:18|t", val, GetItemIcon(desc)) end,
	quality = 1,
	sets = {
		["CurrencyItems.Alterac Valley Mark of Honor"] = 20560,
		["CurrencyItems.Apexis Crystal"] = 32572,
		["CurrencyItems.Apexis Shard"] = 32569,
		["CurrencyItems.Arathi Basin Mark of Honor"] = 20559,
		["CurrencyItems.Arcane Rune"] = 29736,
		["CurrencyItems.Arctic Fur"] = 44128,
--		["CurrencyItems.Arena Points"] = 43307,
		["CurrencyItems.Badge of Justice"] = 29434,
		["CurrencyItems.Brewfest Prize Token"] = 37829,
		["CurrencyItems.Burning Blossom"] = 23247,
		["CurrencyItems.Champion's Seal"] = 44990,
		["CurrencyItems.Coilfang Armaments"] = 24368,
		["CurrencyItems.Coin of Ancestry"] = 21100,
		["CurrencyItems.Dalaran Cooking Award"] = 43016,
		["CurrencyItems.Dalaran Jewelcrafter's Token"] = 41596,
		["CurrencyItems.Dream Shard"] = 34052,
		["CurrencyItems.Emblem of Conquest"] = 45624,
		["CurrencyItems.Emblem of Frost"] = 49426,
		["CurrencyItems.Emblem of Heroism"] = 40752,
		["CurrencyItems.Emblem of Triumph"] = 47241,
		["CurrencyItems.Emblem of Valor"] = 40753,
		["CurrencyItems.Glowcap"] = 24245,
		["CurrencyItems.Halaa Battle Token"] = 26045,
		["CurrencyItems.Halaa Research Token"] = 26044,
		["CurrencyItems.Heavy Borean Leather"] = 38425,
		["CurrencyItems.Holy Dust"] = 29735,
--		["CurrencyItems.Honor Points"] = 43308,
		["CurrencyItems.Isle of Conquest Mark of Honor"] = 47395,
		["CurrencyItems.Mark of Honor Hold"] = 24579,
		["CurrencyItems.Mark of the Illidari"] = 32897,
		["CurrencyItems.Mark of Thrallmar"] = 24581,
		["CurrencyItems.Necrotic Rune"] = 22484,
		["CurrencyItems.Noblegarden Chocolate"] = 44791,
		["CurrencyItems.Spirit Shard"] = 28558,
		["CurrencyItems.Stone Keeper's Shard"] = 43228,
		["CurrencyItems.Strand of the Ancients Mark of Honor"] = 42425,
		["CurrencyItems.Sunmote"] = 34664,
		["CurrencyItems.Venture Coin"] = 37836,
		["CurrencyItems.Warsong Gulch Mark of Honor"] = 20558,
		["CurrencyItems.Winterfin Clam"] = 34597,
		["CurrencyItems.Wintergrasp Mark of Honor"] = 43589,
	},
})
