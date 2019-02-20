--[[
Project name: HeadCount
Developed by: seppyk
Website: http://www.wowace.com/projects/head-count/
Description: Manages tracking of raid attendance and more.
License: Creative Common Attribution-NonCommercial-ShareAlike 3.0 Unported
File: HeadCountConstants.lua
File description: Constants listing
]]

local L = AceLibrary("AceLocale-2.2"):new("HeadCount")
local HeadCount = HeadCount

-- Localized boss targets
HeadCount.BOSS_TARGET = { }

-- Localized battlegrounds
HeadCount.BATTLEGROUNDS = { }

-- Default level
HeadCount.DEFAULT_LEVEL = 70

-- Raid instances
HeadCount.INSTANCES = { }

-- Raid boss aliases (to manage a list of bosses that should be displayed with different names than their actual name)
HeadCount.BOSS_ALIASES = { }

-- Raid boss blacklist (bosses that should never be tracked since they aren't true bosses or due to technical reasons)
HeadCount.BOSS_BLACKLIST = { }

-- Raid boss whitelist (bosses that should ALWAYS be tracked but aren't due to technical reasons)
HeadCount.BOSS_WHITELIST = { }

-- Raid boss end triggers
HeadCount.BOSS_END_TRIGGER = { }

-- Channels
HeadCount.CHAT_CHANNELS = { }

-- Raid groups
HeadCount.NUMBER_OF_PARTY_PLAYERS = 5
HeadCount.NUMBER_OF_PARTY_GROUPS = 8
HeadCount.NUMBER_OF_NORMAL_PLAYERS = 10
HeadCount.NUMBER_OF_HEROIC_PLAYERS = 25

-- Loot
HeadCount.DEFAULT_LOOT_SOURCE = L["Trash mob"]
HeadCount.DEFAULT_LOOT_QUANTITY = 1
HeadCount.ITEM_COLORS_NO_ALPHA = { "9D9D9D", "FFFFFF", "1EFF00", "0070DD", "A335EE", "FF8000", "E6CC80", }
HeadCount.DEFAULT_COLOR_NO_ALPHA = "A335EE"

-- Class colors
HeadCount.CLASS_COLORS = {
	["Druid"] = { r = 1, g = 0.49, b = 0.04, }, 
	["Hunter"] =  { r = 0.67, g = 0.83, b = 0.45 },
	["Mage"] = { r = 0.41, g = 0.8, b = 0.94 },
	["Paladin"] = { r = 0.96, g = 0.55, b = 0.73 }, 
	["Priest"] = { r = 1, g = 1, b = 1 }, 
	["Rogue"] = { r = 1, g = 0.96, b = 0.41 }, 
	["Shaman"] = { r = 0.14, g = 0.35, b = 1 }, 
	["Warlock"] = { r = 0.58, g = 0.51, b = 0.79 }, 
	["Warrior"] = { r = 0.78, g = 0.61, b = 0.43 }, 
	["Unknown"] = { r = 0.6, g = 0.6, b = 0.6 }, 
}

-- Metadata
HeadCount.TITLE = "HeadCount"
HeadCount.VERSION = GetAddOnMetadata(HeadCount.TITLE, "Version")
HeadCount.AUTHOR = GetAddOnMetadata(HeadCount.TITLE, "Author") 

-- Events
HeadCount.EVENT_RAID_ROSTER_UPDATE = "HeadCount_RAID_ROSTER_UPDATE"
HeadCount.EVENT_WAITLIST_ACCEPTANCE_UPDATE = "HeadCount_WAITLIST_ACCEPTANCE_UPDATE"
HeadCount.EVENT_OUTGOING_WHISPER_UPDATE = "HeadCount_OUTGOING_WHISPER_UPDATE"
HeadCount.EVENT_OUTGOING_WHISPER_UPDATE_DELAY = 0.25

-- Lengths
HeadCount.MAX_MESSAGE_LENGTH = 250
HeadCount.MAX_PLAYER_NAMES_PER_LINE = 15

-- Message handling
HeadCount.MESSAGE_PREFIX = "[HeadCount]"

-- Initialize constants
function HeadCount:initializeConstants()
	-- Raid instances
	HeadCount:addHashValue(HeadCount.INSTANCES, L["Zul'Gurub"], { name = L["Zul'Gurub"], players = { 20 } })
	HeadCount:addHashValue(HeadCount.INSTANCES, L["Ruins of Ahn'Qiraj"], { name = L["Ruins of Ahn'Qiraj"], players = { 20 } })
	HeadCount:addHashValue(HeadCount.INSTANCES, L["Temple of Ahn'Qiraj"], { name = L["Ruins of Ahn'Qiraj"], players = { 40 } })
	HeadCount:addHashValue(HeadCount.INSTANCES, L["Onyxia's Lair"], { name = L["Onyxia's Lair"], players = { 40 } })
	HeadCount:addHashValue(HeadCount.INSTANCES, L["Molten Core"], { name = L["Molten Core"], players = { 40 } })
	HeadCount:addHashValue(HeadCount.INSTANCES, L["Blackwing Lair"], { name = L["Blackwing Lair"], players = { 40 } })
	HeadCount:addHashValue(HeadCount.INSTANCES, L["Ahn'Qiraj"], { name = L["Temple of Ahn'Qiraj"], players = { 40 } })
	HeadCount:addHashValue(HeadCount.INSTANCES, L["Naxxramas"], { name = L["Naxxramas"], players = { 40 } })
	HeadCount:addHashValue(HeadCount.INSTANCES, L["Karazhan"], { name = L["Karazhan"], players = { 10 } })
	HeadCount:addHashValue(HeadCount.INSTANCES, L["Zul'Aman"], { name = L["Zul'Aman"], players =  { 10 } })
	HeadCount:addHashValue(HeadCount.INSTANCES, L["Gruul's Lair"], { name = L["Gruul's Lair"], players = { 25 } })
	HeadCount:addHashValue(HeadCount.INSTANCES, L["Magtheridon's Lair"], { name = L["Magtheridon's Lair"], players = { 25 } })
	HeadCount:addHashValue(HeadCount.INSTANCES, L["Serpentshrine Cavern"], { name = L["Serpentshrine Cavern"], players = { 25 } })
	HeadCount:addHashValue(HeadCount.INSTANCES, L["Tempest Keep"], { name = L["Tempest Keep"], players = { 25 } })
	HeadCount:addHashValue(HeadCount.INSTANCES, L["Hyjal Summit"], { name = L["Battle for Mount Hyjal"], players = { 25 } })
	HeadCount:addHashValue(HeadCount.INSTANCES, L["Black Temple"], { name = L["Black Temple"], players = { 25 } })
	HeadCount:addHashValue(HeadCount.INSTANCES, L["Sunwell Plateau"], { name = L["Sunwell Plateau"], players = { 25 } })

	-- Raid boss aliases
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["Emperor Vek'lor"], L["Twin Emperors"])
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["Emperor Vek'nilash"], L["Twin Emperors"])
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["Highlord Mograine"], L["The Four Horsemen"])
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["Lady Blaumeux"], L["The Four Horsemen"])
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["Sir Zeliek"], L["The Four Horsemen"])
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["Thane Korth'azz"], L["The Four Horsemen"])
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["Julianne"], L["Opera Event (Romulo and Julianne)"])
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["Romulo"], L["Opera Event (Romulo and Julianne)"])
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["The Big Bad Wolf"], L["Opera Event (The Big Bad Wolf)"])
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["The Crone"], L["Opera Event (Wizard of Oz)"])
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["Essence of Anger"], L["Reliquary of Souls"])
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["Gathios the Shatterer"], L["The Illidari Council"])
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["High Nethermancer Zerevor"], L["The Illidari Council"])
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["Lady Malande"], L["The Illidari Council"])
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["Veras Darkshadow"], L["The Illidari Council"])
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["Sathrovarr the Corruptor"], L["Kalecgos"])
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["Grand Warlock Alythess"], L["Eredar Twins"])
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["Lady Sacrolash"], L["Eredar Twins"])
	HeadCount:addHashValue(HeadCount.BOSS_ALIASES, L["Entropius"], L["M'uru"])

	-- Raid boss blacklist
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Cairne Bloodhoof"], true)				-- Horde city bosses
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Lady Sylvanas Windrunner"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Lor'themar Theron"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Grand Magister Rommath"], true)	
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Thrall"], true)							-- City/Battle for Mount Hyjal
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["King Magni Bronzebeard"], true)			-- Alliance city bosses
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["King Varian Wrynn"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Prophet Velen"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Tyrande Whisperwind"], true)			-- City/Battle for Mount Hyjal
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Drek'Thar"], true)						-- Battlegrounds
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Captain Galvangar"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Captain Balinda Stonehearth"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Vanndar Stormpike"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Atiesh"], true)							-- Legendary quest
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Ohgan"], true)							-- Zul'Gurub (ZG)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Lord Victor Nefarius"], true)			-- Blackwing Lair (BWL)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Arygos"], true)							-- Temple of Ahn'Qiraj (AQ40)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Caelestrasz"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Eye of C'Thun"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Merithra of the Dream"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Dorothee"], true)						-- Karazhan
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Echo of Medivh"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Image of Medivh"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Midnight"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Roar"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Shadow of Aran"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Strawman"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Tinhead"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Tito"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Amani Bear Spirit"], true)				-- Zul'Aman (ZA)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Amani Dragonhawk Spirit"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Amani Eagle Spirit"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Amani Lynx Spirit"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Spirit of the Lynx"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Blindeye the Seer"], true)				-- Gruul's Lair
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Kiggler the Crazed"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Krosh Firehand"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Olm the Summoner"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Hellfire Channeler"], true)				-- Magtheridon's Lair
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Shadow of Leotheras"], true)			-- Serpentshrine Cavern (SSC)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Grand Astromancer Capernian"], true)	-- Tempest Keep (TK)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Lord Sanguinar"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Master Engineer Telonicus"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Thaladred the Darkener"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Lady Jaina Proudmoore"], true)			-- Battle for Mount Hyjal
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Dire Wolf"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Blade of Azzinoth"], true)				-- Black Temple (BT)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Essence of Desire"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Essence of Suffering"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Maiev Shadowsong"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["The Illidari Council"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Akama"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Flame of Azzinoth"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Kalecgos"], true)						-- Sunwell Plateau
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Madrigosa"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Feugen"], true)							-- Naxxramas
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Stalagg"], true)
	HeadCount:addHashValue(HeadCount.BOSS_BLACKLIST, L["Cat"], true)

	-- Chat channels
	HeadCount:addHashValue(HeadCount.CHAT_CHANNELS, L["Guild"], "GUILD")
	HeadCount:addHashValue(HeadCount.CHAT_CHANNELS, L["Officer"], "OFFICER")
	HeadCount:addHashValue(HeadCount.CHAT_CHANNELS, L["Party"], "PARTY")
	HeadCount:addHashValue(HeadCount.CHAT_CHANNELS, L["Raid"], "RAID")
	HeadCount:addHashValue(HeadCount.CHAT_CHANNELS, L["Say"], "SAY")
	HeadCount:addHashValue(HeadCount.CHAT_CHANNELS, L["Yell"], "YELL")
	
	-- Boss targets
	HeadCount:addHashValue(HeadCount.BOSS_TARGET, L["Cache of the Firelord"], L["Majordomo Executus"])
	HeadCount:addHashValue(HeadCount.BOSS_TARGET, L["Four Horsemen Chest"], L["The Four Horsemen"])
	HeadCount:addHashValue(HeadCount.BOSS_TARGET, L["Dust Covered Chest"], L["Chess Event"])
	
	-- Battlegrounds/arenas
	HeadCount:addHashValue(HeadCount.BATTLEGROUNDS, L["Alterac Valley"], true)
	HeadCount:addHashValue(HeadCount.BATTLEGROUNDS, L["Arathi Basin"], true)
	HeadCount:addHashValue(HeadCount.BATTLEGROUNDS, L["Eye of the Storm"], true)
	HeadCount:addHashValue(HeadCount.BATTLEGROUNDS, L["Warsong Gulch"], true)	
	HeadCount:addHashValue(HeadCount.BATTLEGROUNDS, L["Blade's Edge Arena"], true)
	HeadCount:addHashValue(HeadCount.BATTLEGROUNDS, L["Dalaran Arena"], true)
	HeadCount:addHashValue(HeadCount.BATTLEGROUNDS, L["Nagrand Arena"], true)
	HeadCount:addHashValue(HeadCount.BATTLEGROUNDS, L["Ruins of Lordaeron"], true)
end

-- Add a hash table value
-- @param targetTable The table
-- @param key The key
-- @param value The value
function HeadCount:addHashValue(targetTable, key, value) 
	assert(type(targetTable) == "table", "Unable to add hash table value because targetTable is not a table.")
	assert(type(key) == "string", "Unable to add table value because the key is not a string.")

	targetTable[key] = value	
end

-- Add a list table value
-- @param targetTable The table
-- @param value The value
function HeadCount:addListValue(targetTable, value)
	assert(type(targetTable) == "table", "Unable to add list table value because targetTable is not a table.")

	table.insert(targetTable, value)
end

-- group values
local MINIMUM_GROUP_NUMBER = 1
local MAXIMUM_GROUP_NUMBER = 8

local RAID_MEMBER_SORT = {
	["Name"] = "Name", 
	["Start"] = "Start", 
	["End"] = "End", 
	["Total"] = "Total", 
	["Waitlist"] = "Waitlist", 
	["WaitlistNote"] = "WaitlistNote", 
}

-- "You receive loot: %sx%d"
local MULTIPLE_LOOT_SELF_REGEX = (LOOT_ITEM_SELF_MULTIPLE):gsub("%%sx%%d", "(.+)x(%%d+)")
		
-- "You receive loot: %s"
local LOOT_SELF_REGEX = (LOOT_ITEM_SELF):gsub("%%s", "(.+)")
		
-- %s receives loot: %sx%d.
local MULTIPLE_LOOT_REGEX = (LOOT_ITEM_MULTIPLE):gsub("%%s receives loot: %%sx%%d", "(.+) receives loot: (.+)x(%%d+)")

-- %s receives loot: %s.
local LOOT_REGEX = (LOOT_ITEM):gsub("%%s", "(.+)")

-- Gets the multiple loot self regex
-- @return string Returns the multiple loot self regex
function HeadCount:getMULTIPLE_LOOT_SELF_REGEX()
	return MULTIPLE_LOOT_SELF_REGEX
end

-- Gets the loot self regex
-- @return string Returns the loot self regex
function HeadCount:getLOOT_SELF_REGEX() 
	return LOOT_SELF_REGEX
end

-- Gets the multiple loot regex
-- @return string Returns the multiple loot regex
function HeadCount:getMULTIPLE_LOOT_REGEX() 
	return MULTIPLE_LOOT_REGEX
end

-- Gets the loot regex
-- @return string Returns the loot regex
function HeadCount:getLOOT_REGEX() 
	return LOOT_REGEX
end

-- Gets the raid member sort criteria.
-- @return table Returns the raid member sort criteria.
function HeadCount:getRAID_MEMBER_SORT()
	return RAID_MEMBER_SORT
end

-- Gets the minimum group number.
-- @return number Returns the minimum group number.
function HeadCount:getMINIMUM_GROUP_NUMBER() 
	return MINIMUM_GROUP_NUMBER
end

-- Gets the maximum group number.
-- @return number Returns the maximum group number.
function HeadCount:getMAXIMUM_GROUP_NUMBER() 
	return MAXIMUM_GROUP_NUMBER
end
