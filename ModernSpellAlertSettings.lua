-- ==============================
-- ModernSpellAlert Settings Addon
-- ==============================

-- Define namespace and dependencies
ModernSpellAlertSettings = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDebug-2.0", "AceModuleCore-2.0", "AceConsole-2.0", "AceDB-2.0", "AceHook-2.1")
ModernSpellAlertSettings:RegisterDB("ModernSpellAlertSettingsDB")
ModernSpellAlertSettings:RegisterDefaults("profile", {
    showMinimapIcon = true,
	playSoundForSpell = false,
    framePosX = 0, -- Default X offset
    framePosY = 200, -- Default Y offset
    fadeTime = 3, -- Default fade time in seconds
})

-- ==============================
-- Utility Functions
-- ==============================

-- Retrieves a specific spell setting.
function getSpellSetting(spellName, settingKey)
    local spellSettings = ModernSpellAlertSettings.db.profile[spellName]
    if spellSettings and spellSettings[settingKey] ~= nil then
        return spellSettings[settingKey]
    end
    return false
end

-- Updates a specific spell setting.
function setSpellSetting(spellName, settingKey, value)
    ModernSpellAlertSettings.db.profile[spellName] = ModernSpellAlertSettings.db.profile[spellName] or {}
    ModernSpellAlertSettings.db.profile[spellName][settingKey] = value and true or nil

    DEFAULT_CHAT_FRAME:AddMessage(string.format("Updated: %s - %s = %s", spellName, settingKey, value and "enabled" or "disabled"))

    if ModernSpellAlert and ModernSpellAlert.PopulateSpellNames then
        ModernSpellAlert:PopulateSpellNames()
    else
        DEFAULT_CHAT_FRAME:AddMessage("Error: ModernSpellAlert or PopulateSpellNames not found!")
    end
end

-- ==============================
-- Menu and Options Management
-- ==============================

local classSpells = {
	DRUID = {
	"Abolish Poison",
	"Barkskin",
	"Dash",
	"Enrage",
	"Entangling Roots",
	"Frenzied Regeneration",
	"Healing Touch",
	"Hibernate",
	"Hurricane",
	"Insect Swarm",
	"Moonfire",
	"Nature's Grasp",
	"Rebirth",
	"Regrowth",
	"Rejuvenation",
	"Starfire",
	"Tranquility",
	"Wrath",
	},
	HUNTER = {
	"Aimed Shot",
	"Arcane Shot",
	"Feign Death",
	"Hunter's Mark",
	},
	MAGE = {
	"Arcane Explosion",
	"Arcane Missiles",
	"Blast Wave",
	"Blink",
	"Blizzard",
	"Cold Snap",
	"Combustion",
	"Cone of Cold",
	"Counterspell",
	"Fire Ward",
	"Fireball",
	"Flamestrike",
	"Frost Warding",
	"Ice Barrier",
	"Ice Block",
	"Mana Shield",
	"Polymorph",
	"Pyroblast",
	"Scorch",
	"Slow Fall",
	},
	PALADIN = {
	"Blessing of Freedom",
	"Blessing of Protection",
	"Blessing of Sacrifice",
	"Cleanse",
	"Consecration",
	"Divine Protection",
	"Divine Shield",
	"Flash of Light",
	"Hammer of Justice",
	"Hammer of Wrath",
	"Holy Light",
	"Holy Shock",
	"Lay on Hands",
	"Purify",
	"Redemption",
	"Repentance",
	},
	PRIEST = {
	"Abolish Disease",
	"Desperate Prayer",
	"Devouring Plague",
	"Dispel Magic",
	"Fear Ward",
	"Flash Heal",
	"Greater Heal",
	"Heal",
	"Holy Fire",
	"Holy Nova",
	"Levitate",
	"Mana Burn",
	"Mind Blast",
	"Mind Flay",
	"Power Word: Shield",
	"Prayer of Healing",
	"Psychic Scream",
	"Renew",
	"Resurrection",
	"Shadow Word: Pain",
	"Smite",
	},
	ROGUE = {
	"Ambush",
	"Backstab",
	"Blind",
	"Eviscerate",
	"Expose Armor",
	"Gouge",
	"Kick",
	"Kidney Shot",
	"Mutilate",
	"Preparation",
	"Rupture",
	"Sap",
	"Slice and Dice",
	"Sprint",
	"Stealth",
	"Vanish",
	},
	SHAMAN = {
	"Ancestral Spirit",
	"Chain Heal",
	"Chain Lightning",
	"Cure Disease",
	"Cure Poison",
	"Earth Shock",
	"Earthbind Totem",
	"Fire Nova Totem",
	"Fire Resistance Totem",
	"Flame Shock",
	"Frost Resistance Totem",
	"Frost Shock",
	"Grounding Totem",
	"Healing Wave",
	"Lesser Healing Wave",
	"Lightning Bolt",
	"Magma Totem",
	"Nature Resistance Totem",
	"Poison Cleansing Totem",
	"Purge",
	"Reincarnation",
	"Searing Totem",
	"Tremor Totem",
	"Water Breathing",
	"Windwall Totem",
	},
	WARLOCK = {
	"Banish",
	"Corruption",
	"Curse of Agony",
	"Curse of Doom",
	"Curse of Recklessness",
	"Curse of Weakness",
	"Death Coil",
	"Drain Life",
	"Drain Mana",
	"Drain Soul",
	"Fear",
	"Fel Domination",
	"Health Funnel",
	"Hellfire",
	"Life Tap",
	"Shadow Bolt",
	"Shadowburn",
	"Soul Link",
	},
	WARRIOR = {
	"Battle Shout",
	"Charge",
	"Cleave",
	"Death Wish",
	"Demoralizing Shout",
	"Execute",
	"Hamstring",
	"Heroic Strike",
	"Intercept",
	"Intimidating Shout",
	"Last Stand",
	"Mortal Strike",
	"Overpower",
	"Pummel",
	"Revenge",
	"Shield Bash",
	"Shield Block",
	"Shield Slam",
	"Slam",
	"Sweeping Strikes",
	"Taunt",
	"Thunder Clap",
	},
}

-- Sanitizes a spell name into a key-friendly format.
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

-- Generates menu options for a given spell.
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

-- Generates the class spell menu structure.
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
				DEFAULT_CHAT_FRAME:AddMessage("Play Sound for Spells is now " .. (value and "enabled" or "disabled") .. ".")
			end,
			order = 21, -- Adjust order to position appropriately in the menu
		}
		
		menu.blank_space_two = {
            type = "header",
            name = " ",
            order = 22,
        }
		
		menu.fadeTime = {
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
			order = 23,
		}
		
		menu.framePosition = {
			type = "group",
			name = "Frame Position",
			desc = "Adjust the position of the alert frame.",
			order = 24,
			args = {
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
							ModernSpellAlert.frame:SetPoint("CENTER", UIParent, "CENTER", value, ModernSpellAlertSettings.db.profile.framePosY)
						end
					end,
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
							ModernSpellAlert.frame:SetPoint("CENTER", UIParent, "CENTER", ModernSpellAlertSettings.db.profile.framePosX, value)
						end
					end,
				},
				testMode = {
					type = "toggle",
					name = "Test Mode",
					desc = "Toggle a test display of the alert frame to set up its position.",
					get = function() return ModernSpellAlert.frame and ModernSpellAlert.frame:IsVisible() end,
					set = function(value)
						if value then
							ModernSpellAlert:ShowTestFrame()
						else
							ModernSpellAlert:HideTestFrame()
						end
					end,
				},
			},
		}

        menu.showMinimapIcon = {
            type = "toggle",
            name = "Show Minimap Icon",
            desc = "Toggle the visibility of the minimap icon.",
            order = 25,
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

-- Create icon with menu
ModernSpellAlertOptions = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "FuBarPlugin-2.0")
ModernSpellAlertOptions.name = "FuBar - ModernSpellAlert"
ModernSpellAlertOptions.hasIcon = "Interface\\Icons\\Spell_Fire_Flare"
ModernSpellAlertOptions.defaultMinimapPosition = 200
ModernSpellAlertOptions.independentProfile = true
ModernSpellAlertOptions.hideWithoutStandby = false
ModernSpellAlertOptions.OnMenuRequest = ModernSpellAlertSettings.cmdtable

-- Populate additional icon menu options
local args = AceLibrary("FuBarPlugin-2.0"):GetAceOptionsDataTable(ModernSpellAlertOptions)
for k, v in pairs(args) do
    if ModernSpellAlertOptions.OnMenuRequest.args[k] == nil then
        ModernSpellAlertOptions.OnMenuRequest.args[k] = v
    end
end

-- Ensure the minimap icon shows/hides based on settings
function ModernSpellAlertSettings:OnEnable()
    if self.db.profile.showMinimapIcon then
        ModernSpellAlertOptions:Show()
    else
        ModernSpellAlertOptions:Hide()
    end
end

ModernSpellAlertSettings:RegisterChatCommand({"/modern"}, ModernSpellAlertSettings.cmdtable)
ModernSpellAlertSettings:RegisterEvent("PLAYER_LOGIN", function()
    if ModernSpellAlert and ModernSpellAlert.PopulateSpellNames then
        ModernSpellAlert:PopulateSpellNames()
    else
        DEFAULT_CHAT_FRAME:AddMessage("Error: ModernSpellAlert not loaded!")
    end
end)