-- ==============================
-- Settings for ModernSpellAlert Addon
-- ==============================
ModernSpellAlertSettings = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDebug-2.0", "AceModuleCore-2.0",
	"AceConsole-2.0", "AceDB-2.0", "AceHook-2.1")
ModernSpellAlertSettings:RegisterDB("ModernSpellAlertSettingsDB")
ModernSpellAlertSettings:RegisterDefaults("profile", {
	showMinimapIcon = true,
	playSoundForSpell = false,
	framePosX = 0,   -- Default X offset
	framePosY = 200, -- Default Y offset
	fadeTime = 3,    -- Default fade time in seconds
	fontIndex = 2,   -- Default font
})

-- ==============================
-- Menu and Options Management
-- ==============================
local classSpells = {
	DRUID = {
		"Abolish Poison",
		"Aquatic Form",
		"Barkskin",
		"Barkskin (Feral)",
		"Bash",
		"Cat Form",
		"Claw",
		"Cure Poison",
		"Dash",
		"Demoralizing Roar",
		"Dire Bear Form",
		"Enrage",
		"Entangling Roots",
		"Faerie Fire",
		"Faerie Fire (Feral)",
		"Feral Charge",
		"Ferocious Bite",
		"Frenzied Regeneration",
		"Gift of the Wild",
		"Growl",
		"Healing Touch",
		"Hibernate",
		"Hurricane",
		"Innervate",
		"Insect Swarm",
		"Mangle",
		"Mark of the Wild",
		"Maul",
		"Moonfire",
		"Moonkin Form",
		"Nature's Grasp",
		"Nature's Swiftness",
		"Omen of Clarity",
		"Pounce",
		"Prowl",
		"Rake",
		"Ravage",
		"Rebirth",
		"Regrowth",
		"Rejuvenation",
		"Remove Curse",
		"Rip",
		"Shred",
		"Soothe Animal",
		"Starfire",
		"Swiftmend",
		"Swipe",
		"Thorns",
		"Tranquility",
		"Travel Form",
		"Wrath",
	},
	HUNTER = {
		"Aimed Shot",
		"Arcane Shot",
		"Aspect of the Beast",
		"Aspect of the Cheetah",
		"Aspect of the Hawk",
		"Aspect of the Monkey",
		"Aspect of the Pack",
		"Aspect of the Wild",
		"Auto Shot",
		"Bestial Wrath",
		"Beast Lore",
		"Call Pet",
		"Concussive Shot",
		"Counterattack",
		"Deterrence",
		"Disengage",
		"Dismiss Pet",
		"Distracting Shot",
		"Eyes of the Beast",
		"Explosive Trap",
		"Feed Pet",
		"Feign Death",
		"Flare",
		"Freezing Trap",
		"Frost Trap",
		"Hunter's Mark",
		"Immolation Trap",
		"Intimidation",
		"Mend Pet",
		"Mongoose Bite",
		"Multi-Shot",
		"Rapid Fire",
		"Raptor Strike",
		"Readiness",
		"Revive Pet",
		"Scare Beast",
		"Scatter Shot",
		"Scorpid Sting",
		"Serpent Sting",
		"Track Beasts",
		"Track Demons",
		"Track Dragonkin",
		"Track Elementals",
		"Track Giants",
		"Track Hidden",
		"Track Humanoids",
		"Track Undead",
		"Tranquilizing Shot",
		"Trueshoot Aura",
		"Viper Sting",
		"Volley",
		"Wing Clip",
		"Wyvern Sting",
	},
	MAGE = {
		"Amplify Magic",
		"Arcane Brilliance",
		"Arcane Explosion",
		"Arcane Intellect",
		"Arcane Missiles",
		"Arcane Power",
		"Blast Wave",
		"Blink",
		"Blizzard",
		"Cold Snap",
		"Combustion",
		"Cone of Cold",
		"Conjure Food",
		"Conjure Mana Agate",
		"Conjure Mana Citrine",
		"Conjure Mana Jade",
		"Conjure Mana Ruby",
		"Conjure Water",
		"Counterspell",
		"Dampen Magic",
		"Detect Magic",
		"Evocation",
		"Fire Blast",
		"Fireball",
		"Fire Ward",
		"Flamestrike",
		"Frost Armor",
		"Frost Nova",
		"Frostbolt",
		"Frost Ward",
		"Ice Armor",
		"Ice Barrier",
		"Ice Block",
		"Ice Lance",
		"Mage Armor",
		"Magic Absorption",
		"Magic Attunement",
		"Mana Shield",
		"Molten Armor",
		"Netherwind Focus",
		"Polymorph: Cow",
		"Polymorph: Pig",
		"Polymorph: Turtle",
		"Portal: Darnassus",
		"Portal: Ironforge",
		"Portal: Orgrimmar",
		"Portal: Stormwind",
		"Portal: Thunder Bluff",
		"Portal: Undercity",
		"Presence of Mind",
		"Pyroblast",
		"Remove Lesser Curse",
		"Scorch",
		"Slow Fall",
		"Teleport: Darnassus",
		"Teleport: Ironforge",
		"Teleport: Orgrimmar",
		"Teleport: Stormwind",
		"Teleport: Thunder Bluff",
		"Teleport: Undercity",
	},
	PALADIN = {
		"Blessing of Freedom",
		"Blessing of Kings",
		"Blessing of Light",
		"Blessing of Might",
		"Blessing of Protection",
		"Blessing of Sacrifice",
		"Blessing of Salvation",
		"Blessing of Sanctuary",
		"Blessing of Wisdom",
		"Cleanse",
		"Concentration Aura",
		"Consecration",
		"Devotion Aura",
		"Divine Favor",
		"Divine Intervention",
		"Divine Protection",
		"Divine Shield",
		"Exorcism",
		"Fire Resistance Aura",
		"Flash of Light",
		"Frost Resistance Aura",
		"Greater Blessing of Kings",
		"Greater Blessing of Light",
		"Greater Blessing of Might",
		"Greater Blessing of Salvation",
		"Greater Blessing of Sanctuary",
		"Greater Blessing of Wisdom",
		"Hammer of Justice",
		"Hammer of Wrath",
		"Hand of Freedom",
		"Hand of Protection",
		"Hand of Sacrifice",
		"Holy Light",
		"Holy Shield",
		"Holy Shock",
		"Holy Wrath",
		"Judgement",
		"Lay on Hands",
		"Purge",
		"Purify",
		"Redemption",
		"Repentance",
		"Retribution Aura",
		"Righteous Fury",
		"Sanctiti Aura",
		"Seal of Command",
		"Seal of Justice",
		"Seal of Light",
		"Seal of Righteousness",
		"Seal of Wisdom",
		"Seal of the Crusader",
		"Sense Undead",
		"Shadow Resistance Aura",
		"Summon Warhorse",
		"Turn Undead",
	},
	PRIEST = {
		"Abolish Disease",
		"Cure Disease",
		"Desperate Prayer",
		"Devouring Plague",
		"Dispel Magic",
		"Divine Spirit",
		"Elune's Grace",
		"Fade",
		"Fear Ward",
		"Feedback",
		"Flash Heal",
		"Greater Heal",
		"Heal",
		"Holy Fire",
		"Holy Nova",
		"Inner Fire",
		"Inner Focus",
		"Lesser Heal",
		"Levitate",
		"Lightwell",
		"Mana Burn",
		"Mind Blast",
		"Mind Control",
		"Mind Flay",
		"Mind Soothe",
		"Mind Vision",
		"Power Infusion",
		"Power Word: Fortitude",
		"Power Word: Shield",
		"Prayer of Fortitude",
		"Prayer of Healing",
		"Prayer of Shadow Protection",
		"Prayer of Spirit",
		"Psychic Scream",
		"Renew",
		"Resurrection",
		"Shackle Undead",
		"Shadow Protection",
		"Shadow Word: Pain",
		"Shadowform",
		"Silence",
		"Smite",
		"Spirit Tap",
		"Starshards",
		"Touch of Weakness",
		"Vampiric Embrace",
	},
	ROGUE = {
		"Adrenaline Rush",
		"Ambush",
		"Backstab",
		"Blade Flurry",
		"Blind",
		"Blinding Powder",
		"Cheap Shot",
		"Cold Blood",
		"Crippling Poison",
		"Deadly Poison",
		"Detection",
		"Disarm Trap",
		"Distract",
		"Evasion",
		"Eviscerate",
		"Expose Armor",
		"Feint",
		"Garrote",
		"Ghostly Strike",
		"Gouge",
		"Hemorrhage",
		"Kick",
		"Kidney Shot",
		"Mind-numbing Poison",
		"Pick Lock",
		"Pick Pocket",
		"Poisons",
		"Premeditation",
		"Preparation",
		"Relentless Strikes",
		"Riposte",
		"Rupture",
		"Sap",
		"Sinister Strike",
		"Sprint",
		"Stealth",
		"Slice and Dice",
		"Vanish",
		"Wound Poison",
	},
	SHAMAN = {
		"Ancestral Spirit",
		"Astral Recall",
		"Chain Heal",
		"Chain Lightning",
		"Cure Disease",
		"Cure Poison",
		"Disease Cleansing Totem",
		"Earth Shock",
		"Earthbind Totem",
		"Earth Shield",
		"Elemental Mastery",
		"Far Sight",
		"Fire Nova Totem",
		"Fire Resistance Totem",
		"Flame Shock",
		"Flametongue Totem",
		"Flametongue Weapon",
		"Frost Resistance Totem",
		"Frost Shock",
		"Frostbrand Weapon",
		"Ghost Wolf",
		"Grace of Air Totem",
		"Grounding Totem",
		"Healing Stream Totem",
		"Healing Wave",
		"Lesser Healing Wave",
		"Lightning Bolt",
		"Lightning Shield",
		"Lightning Strike",
		"Magma Totem",
		"Mana Spring Totem",
		"Mana Tide Totem",
		"Nature Resistance Totem",
		"Nature's Swiftness",
		"Poison Cleansing Totem",
		"Purge",
		"Reincarnation",
		"Rockbiter Weapon",
		"Searing Totem",
		"Sentry Totem",
		"Stoneclaw Totem",
		"Stoneskin Totem",
		"Stormstrike",
		"Strength of Earth Totem",
		"Tranquil Air totem",
		"Tremor Totem",
		"Water Breathing",
		"Water Shield",
		"Water Walking",
		"Windfury Totem",
		"Windfury Weapon",
		"Windwall Totem",
	},
	WARLOCK = {
		"Amplify Curse",
		"Banish",
		"Conflagrate",
		"Corruption",
		"Create Firestone",
		"Create Healthstone",
		"Create Soulstone",
		"Create Spellstone",
		"Curse of Agony",
		"Curse of Doom",
		"Curse of Elements",
		"Curse of Exhaustion",
		"Curse of Recklessness",
		"Curse of Shadows",
		"Curse of Tongues",
		"Curse of Weakness",
		"Dark Pact",
		"Death Coil",
		"Demon Armor",
		"Demon Skin",
		"Demonic Sacrifice",
		"Detect Greater Invisibility",
		"Detect Invisibility",
		"Detect Lesser Invisibility",
		"Drain Life",
		"Drain Mana",
		"Drain Soul",
		"Enslave Demon",
		"Eye of Kilrogg",
		"Fear",
		"Fel Domination",
		"Greater Healthstone",
		"Health Funnel",
		"Healthstone",
		"Hellfire",
		"Howl of Terror",
		"Immolate",
		"Incinerate",
		"Inferno",
		"Lesser Healthstone",
		"Life Tap",
		"Major Healthstone",
		"Minor Healthstone",
		"Rain of Fire",
		"Ritual of Doom",
		"Ritual of Summoning",
		"Searing Pain",
		"Seduction",
		"Sense Demons",
		"Shadow Bolt",
		"Shadow Ward",
		"Shadowburn",
		"Siphon Life",
		"Summon Dreadsteed",
		"Summon Felhunter",
		"Summon Imp",
		"Summon Infernal",
		"Summon Succubus",
		"Summon Voidwalker",
		"Soul Fire",
		"Soul Link",
		"Soulstone Ressurection",
		"Unending Breath",
	},
	WARRIOR = {
		"Battle Shout",
		"Battle Stance",
		"Berserker Rage",
		"Berserker Stance",
		"Bloodrage",
		"Bloodthirst",
		"Charge",
		"Challenging Shout",
		"Cleave",
		"Concussion Blow",
		"Death Wish",
		"Demoralizing Shout",
		"Defensive Stance",
		"Disarm",
		"Enrage",
		"Execute",
		"Hamstring",
		"Heroic Strike",
		"Intercept",
		"Intimidating Shout",
		"Last Stand",
		"Mocking Blow",
		"Mortal Strike",
		"Overpower",
		"Piercing Howl",
		"Pummel",
		"Rage",
		"Recklessness",
		"Rend",
		"Retaliation",
		"Revenge",
		"Shield Bash",
		"Shield Block",
		"Shield Slam",
		"Shield Wall",
		"Slam",
		"Sweeping Strikes",
		"Sunder Armor",
		"Taunt",
		"Thunder Clap",
		"Whirlwind",
	},
}

-- ==============================
-- Utility
-- ==============================
local function getSpellSetting(spellName, settingKey)
	local spellSettings = ModernSpellAlertSettings.db.profile[spellName]
	if spellSettings and spellSettings[settingKey] ~= nil then
		return spellSettings[settingKey]
	end
	return false
end

local function setSpellSetting(spellName, settingKey, value)
	ModernSpellAlertSettings.db.profile[spellName] = ModernSpellAlertSettings.db.profile[spellName] or {}
	ModernSpellAlertSettings.db.profile[spellName][settingKey] = value and true or nil

	DEFAULT_CHAT_FRAME:AddMessage(string.format("Updated: %s - %s = %s", spellName, settingKey,
		value and "enabled" or "disabled"))

	if ModernSpellAlert and ModernSpellAlert.PopulateSpellNames then
		ModernSpellAlert:PopulateSpellNames()
	else
		DEFAULT_CHAT_FRAME:AddMessage("Error: ModernSpellAlert or PopulateSpellNames not found!")
	end
end

local function sanitizeKey(spellName)
	local sanitized = ""
	for i = 1, string.len(spellName) do
		local char = string.sub(spellName, i, i)
		if char == " " then
			sanitized = sanitized .. "_"
		else
			sanitized = sanitized .. char
		end
	end
	return sanitized
end

local function generateSpellOptions(spellName)
	local options = {}
	local keys = {
		"EnabledOnPlayer", "EnabledByPlayer",
		"EnabledOnTarget", "EnabledByTarget",
		"EnabledOnFriendly", "EnabledByFriendly",
		"EnabledOnHostile", "EnabledByHostile"
	}
	local nameMapping = {
		EnabledOnPlayer = "on Player",
		EnabledByPlayer = "by Player",
		EnabledOnTarget = "on Target",
		EnabledByTarget = "by Target",
		EnabledOnFriendly = "on Friendly",
		EnabledByFriendly = "by Friendly",
		EnabledOnHostile = "on Hostile",
		EnabledByHostile = "by Hostile",
	}

	for i = 1, table.getn(keys) do
		local key = keys[i]
		local descriptionSuffix = nameMapping[key] or "Unknown"

		options[key] = {
			type = "toggle",
			name = "Track " .. descriptionSuffix,
			desc = "Enable or disable tracking when " .. spellName .. " is cast " .. descriptionSuffix .. ".",
			order = i,
			get = function() return getSpellSetting(spellName, key) end,
			set = function(value) setSpellSetting(spellName, key, value) end,
		}
	end
	return options
end

local function generateClassSpellMenu()
	local menu = {}
	for class, spells in pairs(classSpells) do
		table.sort(spells, function(a, b)
			return a < b
		end)
		menu[class] = {
			type = "group",
			name = class,
			desc = "Settings for " .. class .. " spells.",
			order = 1,
			args = {},
		}
		for i, spell in ipairs(spells) do
			local sanitizedKey = sanitizeKey(spell)
			menu[class].args[sanitizedKey] = {
				type = "group",
				name = spell,
				desc = "Settings for " .. spell .. " spell.",
				order = i,
				args = generateSpellOptions(spell),
			}
		end
	end
	return menu
end

-- ==============================
-- Command Table Setup
-- ==============================
ModernSpellAlertSettings.cmdtable = {
	type = "group",
	args = (function()
		local menu = generateClassSpellMenu()
		menu.blank_space_one = {
			type = "header",
			name = " ",
			order = 20,
		}
		menu.playSoundForSpell = {
			type = "toggle",
			name = "Play Sound for Spells",
			desc = "Enable or disable playing sound alerts for spells.",
			get = function()
				return ModernSpellAlertSettings.db.profile.playSoundForSpell
			end,
			set = function(value)
				ModernSpellAlertSettings.db.profile.playSoundForSpell = value
				DEFAULT_CHAT_FRAME:AddMessage("Play Sound for Spells is now " ..
				(value and "enabled" or "disabled") .. ".")
			end,
			order = 21,
		}
		menu.blank_space_two = {
			type = "header",
			name = " ",
			order = 22,
		}
		menu.frameSettings = {
			type = "group",
			name = "Frame Settings",
			desc = "Adjust the settings of the alert frame.",
			order = 23,
			args = {
				testMode = {
					type = "toggle",
					name = "Test Mode",
					desc = "Toggle a test display of the alert frame to set up its position.",
					order = 1,
					get = function() return ModernSpellAlert.frame and ModernSpellAlert.frame:IsVisible() end,
					set = function(value)
						if value then
							ModernSpellAlert:ShowTestFrame()
						else
							ModernSpellAlert:HideTestFrame()
						end
					end,
					order = 1,
				},
				blank_space_three = {
					type = "header",
					name = " ",
					order = 2,
				},
				fadeTime = {
					type = "range",
					name = "Fade Time",
					desc = "Set the fade time for the alert frame (in seconds).",
					min = 1,
					max = 15,
					step = 0.1,
					get = function() return ModernSpellAlertSettings.db.profile.fadeTime end,
					set = function(value)
						ModernSpellAlertSettings.db.profile.fadeTime = value
					end,
					order = 3,
				},
				fontSelection = {
					type = "range",
					name = "Font Selection",
					desc = "Slide to choose a font for alert messages (1-15).",
					min = 1,
					max = 14,
					step = 1,
					get = function()
						return ModernSpellAlertSettings.db.profile.fontIndex
					end,
					set = function(value)
						ModernSpellAlertSettings.db.profile.fontIndex = value
						if ModernSpellAlert and ModernSpellAlert.RefreshMessageFrame then
							ModernSpellAlert:RefreshMessageFrame()
						end
						if ModernSpellAlert.frame and ModernSpellAlert.frame:IsVisible() then
							ModernSpellAlert:ShowTestFrame()
						end
					end,
					order = 4,
				},
				posX = {
					type = "range",
					name = "X Position",
					desc = "Adjust the horizontal position of the alert frame.",
					min = -UIParent:GetWidth() / 2,
					max = UIParent:GetWidth() / 2,
					step = 1,
					get = function() return ModernSpellAlertSettings.db.profile.framePosX end,
					set = function(value)
						ModernSpellAlertSettings.db.profile.framePosX = value
						if ModernSpellAlert.frame then
							ModernSpellAlert.frame:SetPoint("CENTER", UIParent, "CENTER", value,
								ModernSpellAlertSettings.db.profile.framePosY)
						end
					end,
					order = 5,
				},
				posY = {
					type = "range",
					name = "Y Position",
					desc = "Adjust the vertical position of the alert frame.",
					min = -UIParent:GetHeight() / 2,
					max = UIParent:GetHeight() / 2,
					step = 1,
					get = function() return ModernSpellAlertSettings.db.profile.framePosY end,
					set = function(value)
						ModernSpellAlertSettings.db.profile.framePosY = value
						if ModernSpellAlert.frame then
							ModernSpellAlert.frame:SetPoint("CENTER", UIParent, "CENTER",
								ModernSpellAlertSettings.db.profile.framePosX, value)
						end
					end,
					order = 6,
				},
			},
		}
		menu.blank_space_four = {
			type = "header",
			name = " ",
			order = 25,
		}
		menu.showMinimapIcon = {
			type = "toggle",
			name = "Show Minimap Icon",
			desc = "Toggle the visibility of the minimap icon.",
			order = 26,
			get = function() return ModernSpellAlertSettings.db.profile.showMinimapIcon end,
			set = function(value)
				ModernSpellAlertSettings.db.profile.showMinimapIcon = value
				if value then
					ModernSpellAlertOptions:Show()
				else
					ModernSpellAlertOptions:Hide()
				end
			end,
		}
		return menu
	end)(),
}

-- ==============================
-- Initialization and Events
-- ==============================
ModernSpellAlertOptions = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "FuBarPlugin-2.0")
ModernSpellAlertOptions.name = "FuBar - ModernSpellAlert"
ModernSpellAlertOptions.hasIcon = "Interface\\Icons\\Spell_Fire_Flare"
ModernSpellAlertOptions.defaultMinimapPosition = 200
ModernSpellAlertOptions.independentProfile = true
ModernSpellAlertOptions.hideWithoutStandby = false
ModernSpellAlertOptions.folderName = "ModernSpellAlert"
ModernSpellAlertOptions.OnMenuRequest = ModernSpellAlertSettings.cmdtable

local args = AceLibrary("FuBarPlugin-2.0"):GetAceOptionsDataTable(ModernSpellAlertOptions)
for k, v in pairs(args) do
	if ModernSpellAlertOptions.OnMenuRequest.args[k] == nil then
		ModernSpellAlertOptions.OnMenuRequest.args[k] = v
	end
end

function ModernSpellAlertSettings:OnEnable()
	if self.db.profile.showMinimapIcon then
		ModernSpellAlertOptions:Show()
	else
		ModernSpellAlertOptions:Hide()
	end
end

ModernSpellAlertSettings:RegisterChatCommand({ "/modern" }, ModernSpellAlertSettings.cmdtable)
ModernSpellAlertSettings:RegisterEvent("PLAYER_LOGIN", function()
	if ModernSpellAlert and ModernSpellAlert.PopulateSpellNames then
		ModernSpellAlert:PopulateSpellNames()
	else
		DEFAULT_CHAT_FRAME:AddMessage("Error: ModernSpellAlert not loaded!")
	end
end)
