-- ModernSpellAlert Settings Addon

ModernSpellAlertSettings = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDebug-2.0", "AceModuleCore-2.0", "AceConsole-2.0", "AceDB-2.0", "AceHook-2.1")
ModernSpellAlertSettings:RegisterDB("ModernSpellAlertSettingsDB")
ModernSpellAlertSettings:RegisterDefaults("profile", {
    showMinimapIcon = true,
})

-- Function to get spell settings
local function getSpellSetting(spellName, settingKey)
    local spellSettings = ModernSpellAlertSettings.db.profile[spellName]
    if spellSettings and spellSettings[settingKey] ~= nil then
        return spellSettings[settingKey]
    end
    return false -- Default to false if the setting is not defined
end

-- Function to set spell settings
local function setSpellSetting(spellName, settingKey, value)
    ModernSpellAlertSettings.db.profile[spellName] = ModernSpellAlertSettings.db.profile[spellName] or {}
    ModernSpellAlertSettings.db.profile[spellName][settingKey] = value and true or nil

    -- Output to chat for debugging
    DEFAULT_CHAT_FRAME:AddMessage(string.format("Updated: %s - %s = %s", spellName, settingKey, value and "enabled" or "disabled"))

    -- Call PopulateSpellNames to synchronize settings
    if ModernSpellAlert and ModernSpellAlert.PopulateSpellNames then
        ModernSpellAlert:PopulateSpellNames()
    else
        DEFAULT_CHAT_FRAME:AddMessage("Error: ModernSpellAlert or PopulateSpellNames not found!")
    end
end

-- Create icon with menu
ModernSpellAlertOptions = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "FuBarPlugin-2.0")
ModernSpellAlertOptions.name = "FuBar - ModernSpellAlert"
ModernSpellAlertOptions.hasIcon = "Interface\\Icons\\Spell_Fire_Flare"
ModernSpellAlertOptions.defaultMinimapPosition = 200
ModernSpellAlertOptions.independentProfile = true
ModernSpellAlertOptions.hideWithoutStandby = false

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
	"Mana Shield",
	"Pyroblast",
	},
    PALADIN = {
	"Hammer of Justice",
	},
    PRIEST = {
	"Psychic Scream",
	},
    ROGUE = {
	"Blind",
	},
    SHAMAN = {
	"Healing Wave",
	},
    WARLOCK = {
	"Drain Life",
	},
    WARRIOR = {
	"Deathwish",
	},
}

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


-- Function to generate subgroup with 8 toggle options
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

-- Function to generate menu structure for all classes and spells
local function generateClassSpellMenu()
    local menu = {}

    for class, spells in pairs(classSpells) do
        -- Sort the spells table alphabetically
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




-- Command table for menu options
ModernSpellAlertSettings.cmdtable = {
    type = "group",
    args = (function()
        -- Generate class spell menu
        local menu = generateClassSpellMenu()

        -- Add a blank space
        menu.blank_space = {
            type = "header",
            name = " ", -- Displayed as a blank line
            order = 1000, -- High order value to ensure it appears after the classes
        }

        -- Add "Show minimap icon" after the blank space
        menu.showMinimapIcon = {
            type = "toggle",
            name = "Show Minimap Icon",
            desc = "Toggle the visibility of the minimap icon.",
            order = 1010,
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


-- Bind the command table to the icon menu
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

-- Register chat command for menu access
ModernSpellAlertSettings:RegisterChatCommand({"/modernspellalertsettings"}, ModernSpellAlertSettings.cmdtable)

-- Synchronize settings with ModernSpellAlert on load
ModernSpellAlertSettings:RegisterEvent("PLAYER_LOGIN", function()
    if ModernSpellAlert and ModernSpellAlert.PopulateSpellNames then
        ModernSpellAlert:PopulateSpellNames()
    else
        DEFAULT_CHAT_FRAME:AddMessage("Error: ModernSpellAlert not loaded!")
    end
end)
