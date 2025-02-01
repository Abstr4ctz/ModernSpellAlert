-- ==============================
-- Settings for ModernSpellAlert Addon
-- ==============================
ModernSpellAlertSettings = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDebug-2.0", "AceModuleCore-2.0",
	"AceConsole-2.0", "AceDB-2.0", "AceHook-2.1")
ModernSpellAlertSettings:RegisterDB("ModernSpellAlertSettingsDB")
ModernSpellAlertSettings:RegisterDefaults("profile", {
	showMinimapIcon = true,
	playSoundForSpell = false,
	framePosX = 0, -- Default X offset
	framePosY = 200, -- Default Y offset
	fadeTime = 3, -- Default fade time in seconds
	fontIndex = 2, -- Default font
})

-- ==============================
-- Menu and Options Management
-- ==============================
local classSpells = {
	Druid = {
		"Abolish Poison",
		"Astral Boon",
		"Aquatic Form",
		"Barkskin",
		"Barkskin (Feral)",
		"Bash",
		"Bear Form",
		"Berserk",
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
		"Feral Adrenaline",
		"Feral Charge",
		"Ferocious Bite",
		"Frenzied Regeneration",
		"Gale Winds",
		"Gift of the Wild",
		"Growl",
		"Healing Touch",
		"Hibernate",
		"Hurricane",
		"Improved Shred",
		"Innervate",
		"Insect Swarm",
		"Mangle",
		"Mark of the Wild",
		"Maul",
		"Moonfire",
		"Moonkin Form",
		"Natural Boon",
		"Nature Eclipse",
		"Nature's Grace",
		"Nature's Grasp",
		"Nature's Swiftness",
		"Omen of Clarity",
		"Owlkin Frenzy",
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
		"Spirit of the Ancients",
		"Starfire",
		"Swiftmend",
		"Swipe",
		"Sylvan Blessing",
		"Thorns",
		"Tranquility",
		"Travel Form",
		"Wrath",
	},
	Hunter = {
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
	Mage = {
		"Amplify Magic",
		"Arcane Brilliance",
		"Arcane Explosion",
		"Arcane Intellect",
		"Arcane Missiles",
		"Arcane Power",
		"Arcane Rupture",
		"Arcane Surge",
		"Blast Wave",
		"Blink",
		"Blizzard",
		"Chilled",
		"Clearcasting",
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
		"Fire Vulnerability",
		"Flamestrike",
		"Frost Armor",
		"Frost Nova",
		"Frostbite",
		"Frostbolt",
		"Frost Ward",
		"Hot Streak",
		"Ignite",
		"Ice Armor",
		"Ice Barrier",
		"Ice Block",
		"Icicles",
		"Mage Armor",
		"Mana Shield",
		"Polymorph",
		"Polymorph: Cow",
		"Polymorph: Pig",
		"Polymorph: Turtle",
		"Portal: Darnassus",
		"Portal: Ironforge",
		"Portal: Orgrimmar",
		"Portal: Stonard",
		"Portal: Stormwind",
		"Portal: Theramore",
		"Portal: Thunder Bluff",
		"Portal: Undercity",
		"Presence of Mind",
		"Pyroblast",
		"Remove Lesser Curse",
		"Ritual of Refreshment",
		"Scorch",
		"Slow Fall",
		"Teleport: Darnassus",
		"Teleport: Ironforge",
		"Teleport: Orgrimmar",
		"Teleport: Stormwind",
		"Teleport: Thunder Bluff",
		"Teleport: Undercity",
		"Winter's Chill",
	},
	Paladin = {
		"Blessing of Freedom",
		"Blessing of Kings",
		"Blessing of Light",
		"Blessing of Might",
		"Blessing of Protection",
		"Blessing of Sacrifice",
		"Blessing of Salvation",
		"Blessing of Sanctuary",
		"Blessing of Wisdom",
		"Bulwark of the Righteous",
		"Cleanse",
		"Concentration Aura",
		"Consecration",
		"Crusader Strike",
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
		"Hand of Reckoning",
		"Hand of Sacrifice",
		"Holy Light",
		"Holy Shield",
		"Holy Shock",
		"Holy Strike",
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
	Priest = {
		"Abolish Disease",
		"Armor of Faith",
		"Blackout",
		"Blessed Recovery",
		"Champion's Bond",
		"Champion's Grace",
		"Chastise",
		"Cure Disease",
		"Desperate Prayer",
		"Devouring Plague",
		"Dispel Magic",
		"Divine Spirit",
		"Elune's Grace",
		"Empower Champion",
		"Enlighten",
		"Epiphany",
		"Fade",
		"Fear Ward",
		"Feedback",
		"Flash Heal",
		"Focused Casting",
		"Grace of the Sunwell",
		"Greater Heal",
		"Heal",
		"Hex of Weakness",
		"Holy Fire",
		"Holy Nova",
		"Inner Fire",
		"Inner Focus",
		"Inspiration",
		"Lesser Heal",
		"Levitate",
		"Lightwell",
		"Mana Burn",
		"Mind Blast",
		"Mind Control",
		"Mind Flay",
		"Mind Soothe",
		"Mind Vision",
		"Pain Spike",
		"Power Infusion",
		"Power Word: Fortitude",
		"Power Word: Shield",
		"Prayer of Fortitude",
		"Prayer of Healing",
		"Prayer of Shadow Protection",
		"Prayer of Spirit",
		"Proclaim Champion",
		"Psychic Scream",
		"Renew",
		"Resurgent Shield",
		"Resurrection",
		"Revive Champion",
		"Searing Light",
		"Shackle Undead",
		"Shadowguard",
		"Shadow Protection",
		"Shadow Weaving",
		"Shadow Word: Pain",
		"Shadowform",
		"Silence",
		"Smite",
		"Spirit Tap",
		"Spirit of Redemption",
		"Sun's Embrace",
		"Starshards",
		"Touch of Weakness",
		"Vampiric Embrace",
	},
	Rogue = {
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
		"Deadly Throw",
		"Detection",
		"Disarm Trap",
		"Distract",
		"Dust of Disappearance",
		"Envenom",
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
		"Mark for Death",
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
		"Smoke Bomb",
		"Sprint",
		"Stealth",
		"Slice and Dice",
		"Surprise Attack",
		"Vanish",
		"Wound Poison",
	},
	Shaman = {
		"Ancestral Fortitude",
		"Ancestral Spirit",
		"Astral Recall",
		"Bloodlust",
		"Calm Elements",
		"Chain Heal",
		"Chain Lightning",
		"Clearcasting",
		"Cure Disease",
		"Cure Poison",
		"Disease Cleansing Totem",
		"Earth Shock",
		"Earthbind Totem",
		"Earthshaker Slam",
		"Earth Shield",
		"Electrified",
		"Elemental Devastation",
		"Elemental Mastery",
		"Eye of the Storm",
		"Far Sight",
		"Feral Spirit",
		"Fire Nova Totem",
		"Fire Resistance Totem",
		"Flame Shock",
		"Flametongue Totem",
		"Flametongue Weapon",
		"Flurry",
		"Frost Resistance Totem",
		"Frost Shock",
		"Frostbrand Weapon",
		"Ghost Wolf",
		"Grace of Air Totem",
		"Grounding Totem",
		"Healing Stream Totem",
		"Healing Wave",
		"Healing Way",
		"Hex",
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
		"Spirit Link",
		"Stoneclaw Totem",
		"Stoneskin Totem",
		"Stormstrike",
		"Strength of Earth Totem",
		"Tidal Surge",
		"Totemic Power",
		"Totemic Recall",
		"Totemic Slam",
		"Tranquil Air totem",
		"Tremor Totem",
		"Water Breathing",
		"Water Shield",
		"Water Walking",
		"Windfury Totem",
		"Windfury Weapon",
		"Windwall Totem",
		"Frozen Earth",
		"Rising Magma",
		"Frostburn",
	},
	Warlock = {
		"Amplify Curse",
		"Banish",
		"Blood Pact",
		"Conflagrate",
		"Consume Shadows",
		"Corruption",
		"Create Felstone",
		"Create Firestone",
		"Create Healthstone",
		"Create Healthstone (Greater)",
		"Create Healthstone (Lesser)",
		"Create Healthstone (Major)",
		"Create Healthstone (Minor)",
		"Create Soulstone",
		"Create Soulstone (Greater)",
		"Create Soulstone (Lesser)",
		"Create Soulstone (Major)",
		"Create Soulstone (Minor)",
		"Create Spellstone",
		"Create Wrathstone",
		"Curse of Agony",
		"Curse of Doom",
		"Curse of Elements",
		"Curse of Exhaustion",
		"Curse of Recklessness",
		"Curse of Shadows",
		"Curse of Tongues",
		"Curse of Weakness",
		"Dark Harvest",
		"Dark Pact",
		"Death Coil",
		"Demon Armor",
		"Demon Gate",
		"Demon Skin",
		"Demonic Sacrifice",
		"Detect Greater Invisibility",
		"Detect Invisibility",
		"Detect Lesser Invisibility",
		"Devour Magic",
		"Drain Life",
		"Drain Mana",
		"Drain Soul",
		"Enslave Demon",
		"Eye of Kilrogg",
		"Fear",
		"Fel Domination",
		"Felstone",
		"Firebolt",
		"Fire Shield",
		"Firestone",
		"Greater Healthstone",
		"Health Funnel",
		"Healthstone",
		"Hellfire",
		"Howl of Terror",
		"Immolate",
		"Improved Soul Fire",
		"Incinerate",
		"Inferno",
		"Lash of Pain",
		"Lesser Invisibility",
		"Lesser Healthstone",
		"Life Tap",
		"Major Healthstone",
		"Mana Funnel",
		"Minor Healthstone",
		"Paranoia",
		"Phase Shift",
		"Power Overwhelming",
		"Rain of Fire",
		"Ritual of Doom",
		"Ritual of Souls",
		"Ritual of Summoning",
		"Sacrifice",
		"Searing Pain",
		"Seduction",
		"Sense Demons",
		"Shadow Bolt",
		"Shadow Trance",
		"Shadow Ward",
		"Shadowburn",
		"Siphon Life",
		"Spell Lock",
		"Summon Dreadsteed",
		"Summon Felhunter",
		"Summon Felsteed",
		"Summon Imp",
		"Summon Infernal",
		"Summon Succubus",
		"Summon Voidwalker",
		"Soothing Kiss",
		"Soul Fire",
		"Soul Link",
		"Soulstone Ressurection",
		"Suffering",
		"Tainted Blood",
		"Torment",
		"Unending Breath",
		"Unleashed Potential",
	},
	Warrior = {
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
		"Intervene",
		"Intimidating Shout",
		"Last Stand",
		"Mocking Blow",
		"Mortal Strike",
		"Overpower",
		"Piercing Howl",
		"Pummel",
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

-- Table for racials and items
local racialsAndItems = {
	{ displayName = "Advanced Target Dummy" },
	{ displayName = "Arcanite Dragonling" },
	{ displayName = "Berserking" },
	{ displayName = "Blood Fury" },
	{ displayName = "Cannibalize" },
	{ displayName = "Escape Artist" },
	{ displayName = "Dimensional Ripper - Everlook",    realName = "Everlook Transporter" },
	{ displayName = "Discombobulator Ray",              realName = "Discombobulate" },
	{ displayName = "Explosive Sheep" },
	{ displayName = "Field Repair Bot 74A" },
	{ displayName = "Find Treasure" },
	{ displayName = "Flame Deflector",                  realName = "Fire Resistance" },
	{ displayName = "Gyrofreeze Ice Reflector",         realName = "Frost Reflector" },
	{ displayName = "Gnomish Battle Chicken",           realName = "Battle Chicken" },
	{ displayName = "Gnomish Cloaking Device",          realName = "Cloaking" },
	{ displayName = "Gnomish Death Ray" },
	{ displayName = "Gnomish Harm Prevention Belt",     realName = "Harm Prevention Belt" },
	{ displayName = "Gnomish Mind Control Cap" },
	{ displayName = "Gnomish Net-o-Matic Projector",    realName = "Net-o-Matic" },
	{ displayName = "Gnomish Shrink Ray",               realName = "Shrink Ray" },
	{ displayName = "Ultrasafe Transporter: Gadgetzan", realName = "Gnomish Transporter" },
	{ displayName = "Goblin Jumper Cables",             realName = "Defibrillate" },
	{ displayName = "Goblin Land Mine" },
	{ displayName = "Goblin Mortar" },
	{ displayName = "Goblin Rocket Helmet",             realName = "Reckless Charge" },
	{ displayName = "Hyper-Radiant Flame Reflector",    realName = "Fire Reflector" },
	{ displayName = "Invisibility Potion",              realName = "Invisibility" },
	{ displayName = "Ice Deflector",                    realName = "Frost Resistance" },
	{ displayName = "Lesser Invisibility Potion",       realName = "Lesser Invisibility" },
	{ displayName = "Masterwork Target Dummy" },
	{ displayName = "Mithril Mechanical Dragonling" },
	{ displayName = "Mechanical Dragonling" },
	{ displayName = "Perception" },
	{ displayName = "Goblin Rocket Boots" },
	{ displayName = "Gnomish Rocket Boots" },
	{ displayName = "Shadowmeld" },
	{ displayName = "Stoneform" },
	{ displayName = "Target Dummy" },
	{ displayName = "Ultra-Flash Shadow Reflector",     realName = "Shadow Reflector" },
	{ displayName = "War Stomp" },
	{ displayName = "Will of the Forsaken" },
	{ displayName = "Rough Dynamite" },
	{ displayName = "Rough Copper Bomb" },
	{ displayName = "Coarse Dynamite" },
	{ displayName = "Ez-Thro Dynamite" },
	{ displayName = "Large Copper Bomb" },
	{ displayName = "Small Bronze Bomb" },
	{ displayName = "Heavy Dynamite" },
	{ displayName = "Big Bronze Bomb" },
	{ displayName = "Solid Dynamite" },
	{ displayName = "Iron Grenade" },
	{ displayName = "Flash Bomb" },
	{ displayName = "Goblin Sapper Charge" },
	{ displayName = "Big Iron Bomb" },
	{ displayName = "Mithril Frag Bomb" },
	{ displayName = "Hi-Explosive Bomb" },
	{ displayName = "Dense Dynamite" },
	{ displayName = "The Big One" },
	{ displayName = "Thorium Grenade" },
	{ displayName = "Dark Iron Bomb" },
	{ displayName = "Arcane Bomb" },
	{ displayName = "Parachute Cloak",                  realName = "Slow Fall" },
	{ displayName = "Greater Fire Protection Potion",   realName = "Fire Protection" },
	{ displayName = "Greater Shadow Protection Potion", realName = "Shadow Protection" },
	{ displayName = "Greater Frost Protection Potion",  realName = "Frost Protection" },
	{ displayName = "Greater Arcane Protection Potion", realName = "Arcane Protection" },
	{ displayName = "Greater Nature Protection Potion", realName = "Nature Protection " },
	{ displayName = "Greater Holy Protection Potion",   realName = "Holy Protection" },
	{ displayName = "Limited Invulnerability Potion",   realName = "Invulnerability" },
	{ displayName = "Free Action Potion",               realName = "Free Action" },
	{ displayName = "Living Action Potion",             realName = "Living Free Action" },
	{ displayName = "Tidal Charm" },
	{ displayName = "Skull of Impending Doom",          realName = "Flee" },
	{ displayName = "Swiftness Potion",                 realName = "Speed" },
	-- { displayName = "Nifty Stopwatch", realName = "Speed" },
	{ displayName = "Bandage",                          realName = "First Aid" },
	{ displayName = "Furbolg Medicine Pouch" },
	{ displayName = "Magic Dust",                       realName = "Sleep" },
	{ displayName = "Restorative Potion",               realName = "Restoration" },
	{ displayName = "Catseye Elixir",                   realName = "Stealth Detection" },
	{ displayName = "Spider Belt",                      realName = "Immune Root" },
	{ displayName = "Arena Grand Master",               realName = "Aura of Protection" },
	{ displayName = "Scaleshield of Emerald Flight",    realName = "Emerald Transformation" },
	{ displayName = "Dark Iron Hooked Net",             realName = "Trap" },
	{ displayName = "Insignia TurtleWoW",               realName = "Insignia" },
	{ displayName = "Insignia Druid",                   realName = "Immune Charm/Fear/Stun" },
	{ displayName = "Insignia Mage",                    realName = "Immune Fear/Polymorph/Snare" },
	{ displayName = "Insignia Paladin/Priest",          realName = "Immune Fear/Polymorph/Stun" },
	{ displayName = "Insignia Rogue/Warlock",           realName = "Immune Charm/Fear/Polymorph" },
	{ displayName = "Insignia Hunter/Shaman/Warrior",   realName = "Immune Root/Snare/Stun" },
	{ displayName = "Holy Strength" }
	-- { displayName = "Large Rope Net", realName = "Trap" },
	-- { displayName = "Shard of Nightmare", realName = "Sleep" },
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

local function generateRacialsAndItemsMenu()
	local menu = {
		type = "group",
		name = "Racials & Items",
		desc = "Settings for racials and engineering items.",
		order = 10,
		args = {},
	}

	table.sort(racialsAndItems, function(a, b)
		return a.displayName < b.displayName
	end)

	for i, itemOrRacial in ipairs(racialsAndItems) do
		local realName = itemOrRacial.realName or itemOrRacial.displayName
		local sanitizedKey = sanitizeKey(realName)
		menu.args[sanitizedKey] = {
			type = "group",
			name = itemOrRacial.displayName,
			desc = "Settings for " .. itemOrRacial.displayName,
			order = i,
			args = generateSpellOptions(realName),
		}
	end

	return menu
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

	menu["Racials_Items"] = generateRacialsAndItemsMenu()

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
ModernSpellAlertOptions:RegisterDB("ModernSpellAlertSettingsDB")
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
