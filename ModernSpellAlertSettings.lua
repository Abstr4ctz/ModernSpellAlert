-- ModernSpellAlert Settings Addon

ModernSpellAlertSettings = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDebug-2.0", "AceModuleCore-2.0", "AceConsole-2.0", "AceDB-2.0", "AceHook-2.1")
ModernSpellAlertSettings:RegisterDB("ModernSpellAlertSettingsDB")
ModernSpellAlertSettings:RegisterDefaults("profile", {
    showMinimapIcon = true,
	-- DRUID
    abolishPoisonEnabled = false,
    barkskinEnabled = false,
    dashEnabled = false,
	-- MAGE
    arcaneExplosionEnabled = false,
    arcaneMissilesEnabled = false,
    blinkEnabled = false,
    blastWaveEnabled = false,
    blizzardEnabled = false,
    coldSnapEnabled = false,
    combustionEnabled = false,
    coneOfColdEnabled = false,
    counterspellEnabled = false,
    fireWardEnabled = false,
    fireballEnabled = false,
    flamestrikeEnabled = false,
    frostWardingEnabled = false,
    iceBarrierEnabled = false,
    iceBlockEnabled = false,
    manaShieldEnabled = false,
    polymorphEnabled = false,
    pyroblastEnabled = false,
    scorchEnabled = false,
    slowFallEnabled = false,
	-- SHAMAN
	healingWaveEnabled = false,
    lesserHealingWaveEnabled = false,
})

-- Create icon with menu
ModernSpellAlertOptions = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "FuBarPlugin-2.0")
ModernSpellAlertOptions.name = "FuBar - ModernSpellAlert"
ModernSpellAlertOptions.hasIcon = "Interface\\Icons\\Spell_Fire_Flare"
ModernSpellAlertOptions.defaultMinimapPosition = 200
ModernSpellAlertOptions.independentProfile = true
ModernSpellAlertOptions.hideWithoutStandby = false

-- Command table for menu options
ModernSpellAlertSettings.cmdtable = {
    type = "group",
    args = {
        DRUID = {
            type = "group",
            name = "Druid",
            desc = "Settings for Druid spells.",
            order = 1,
            args = {
                abolishPoisonEnabled = {
                    type = "toggle",
                    name = "Enable Abolish Poison",
                    desc = "Enable or disable Abolish Poison.",
                    order = 1,
                    get = function() return ModernSpellAlertSettings.db.profile.abolishPoisonEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.abolishPoisonEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Abolish Poison is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                barkskinEnabled = {
                    type = "toggle",
                    name = "Enable Barkskin",
                    desc = "Enable or disable Barkskin.",
                    order = 2,
                    get = function() return ModernSpellAlertSettings.db.profile.barkskinEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.barkskinEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Barkskin is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                dashEnabled = {
                    type = "toggle",
                    name = "Enable Dash",
                    desc = "Enable or disable Dash.",
                    order = 3,
                    get = function() return ModernSpellAlertSettings.db.profile.dashEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.dashEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Dash is now " .. (value and "enabled" or "disabled"))
                    end,
                },
            },
        },
        MAGE = {
            type = "group",
            name = "Mage",
            desc = "Settings for Mage spells.",
            order = 2,
            args = {
                arcaneExplosionEnabled = {
                    type = "toggle",
                    name = "Enable Arcane Explosion",
                    desc = "Enable or disable Arcane Explosion.",
                    order = 1,
                    get = function() return ModernSpellAlertSettings.db.profile.arcaneExplosionEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.arcaneExplosionEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Arcane Explosion is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                arcaneMissilesEnabled = {
                    type = "toggle",
                    name = "Enable Arcane Missiles",
                    desc = "Enable or disable Arcane Missiles.",
                    order = 2,
                    get = function() return ModernSpellAlertSettings.db.profile.arcaneMissilesEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.arcaneMissilesEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Arcane Missiles is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                blinkEnabled = {
                    type = "toggle",
                    name = "Enable Blink",
                    desc = "Enable or disable Blink.",
                    order = 3,
                    get = function() return ModernSpellAlertSettings.db.profile.blinkEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.blinkEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Blink is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                blastWaveEnabled = {
                    type = "toggle",
                    name = "Enable Blast Wave",
                    desc = "Enable or disable Blast Wave.",
                    order = 4,
                    get = function() return ModernSpellAlertSettings.db.profile.blastWaveEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.blastWaveEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Blast Wave is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                blizzardEnabled = {
                    type = "toggle",
                    name = "Enable Blizzard",
                    desc = "Enable or disable Blizzard.",
                    order = 5,
                    get = function() return ModernSpellAlertSettings.db.profile.blizzardEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.blizzardEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Blizzard is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                coldSnapEnabled = {
                    type = "toggle",
                    name = "Enable Cold Snap",
                    desc = "Enable or disable Cold Snap.",
                    order = 6,
                    get = function() return ModernSpellAlertSettings.db.profile.coldSnapEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.coldSnapEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Cold Snap is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                combustionEnabled = {
                    type = "toggle",
                    name = "Enable Combustion",
                    desc = "Enable or disable Combustion.",
                    order = 7,
                    get = function() return ModernSpellAlertSettings.db.profile.combustionEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.combustionEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Combustion is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                coneOfColdEnabled = {
                    type = "toggle",
                    name = "Enable Cone of Cold",
                    desc = "Enable or disable Cone of Cold.",
                    order = 8,
                    get = function() return ModernSpellAlertSettings.db.profile.coneOfColdEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.coneOfColdEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Cone of Cold is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                counterspellEnabled = {
                    type = "toggle",
                    name = "Enable Counterspell",
                    desc = "Enable or disable Counterspell.",
                    order = 9,
                    get = function() return ModernSpellAlertSettings.db.profile.counterspellEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.counterspellEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Counterspell is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                fireWardEnabled = {
                    type = "toggle",
                    name = "Enable Fire Ward",
                    desc = "Enable or disable Fire Ward.",
                    order = 10,
                    get = function() return ModernSpellAlertSettings.db.profile.fireWardEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.fireWardEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Fire Ward is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                fireballEnabled = {
                    type = "toggle",
                    name = "Enable Fireball",
                    desc = "Enable or disable Fireball.",
                    order = 11,
                    get = function() return ModernSpellAlertSettings.db.profile.fireballEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.fireballEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Fireball is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                flamestrikeEnabled = {
                    type = "toggle",
                    name = "Enable Flamestrike",
                    desc = "Enable or disable Flamestrike.",
                    order = 12,
                    get = function() return ModernSpellAlertSettings.db.profile.flamestrikeEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.flamestrikeEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Flamestrike is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                frostWardingEnabled = {
                    type = "toggle",
                    name = "Enable Frost Warding",
                    desc = "Enable or disable Frost Warding.",
                    order = 13,
                    get = function() return ModernSpellAlertSettings.db.profile.frostWardingEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.frostWardingEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Frost Warding is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                iceBarrierEnabled = {
                    type = "toggle",
                    name = "Enable Ice Barrier",
                    desc = "Enable or disable Ice Barrier.",
                    order = 14,
                    get = function() return ModernSpellAlertSettings.db.profile.iceBarrierEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.iceBarrierEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Ice Barrier is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                iceBlockEnabled = {
                    type = "toggle",
                    name = "Enable Ice Block",
                    desc = "Enable or disable Ice Block.",
                    order = 15,
                    get = function() return ModernSpellAlertSettings.db.profile.iceBlockEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.iceBlockEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Ice Block is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                manaShieldEnabled = {
                    type = "toggle",
                    name = "Enable Mana Shield",
                    desc = "Enable or disable Mana Shield.",
                    order = 16,
                    get = function() return ModernSpellAlertSettings.db.profile.manaShieldEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.manaShieldEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Mana Shield is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                polymorphEnabled = {
                    type = "toggle",
                    name = "Enable Polymorph",
                    desc = "Enable or disable Polymorph.",
                    order = 17,
                    get = function() return ModernSpellAlertSettings.db.profile.polymorphEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.polymorphEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Polymorph is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                pyroblastEnabled = {
                    type = "toggle",
                    name = "Enable Pyroblast",
                    desc = "Enable or disable Pyroblast.",
                    order = 18,
                    get = function() return ModernSpellAlertSettings.db.profile.pyroblastEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.pyroblastEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Pyroblast is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                scorchEnabled = {
                    type = "toggle",
                    name = "Enable Scorch",
                    desc = "Enable or disable Scorch.",
                    order = 19,
                    get = function() return ModernSpellAlertSettings.db.profile.scorchEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.scorchEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Scorch is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                slowFallEnabled = {
                    type = "toggle",
                    name = "Enable Slow Fall",
                    desc = "Enable or disable Slow Fall.",
                    order = 20,
                    get = function() return ModernSpellAlertSettings.db.profile.slowFallEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.slowFallEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Slow Fall is now " .. (value and "enabled" or "disabled"))
                    end,
                },
            },
        },
        SHAMAN = {
            type = "group",
            name = "Shaman",
            desc = "Settings for Shaman spells.",
            order = 3,
            args = {
                healingWaveEnabled = {
                    type = "toggle",
                    name = "Enable Healing Wave",
                    desc = "Enable or disable Healing Wave.",
                    order = 1,
                    get = function() return ModernSpellAlertSettings.db.profile.healingWaveEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.healingWaveEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Healing Wave is now " .. (value and "enabled" or "disabled"))
                    end,
                },
                lesserHealingWaveEnabled = {
                    type = "toggle",
                    name = "Enable Lesser Healing Wave",
                    desc = "Enable or disable Lesser Healing Wave.",
                    order = 2,
                    get = function() return ModernSpellAlertSettings.db.profile.lesserHealingWaveEnabled end,
                    set = function(value)
                        ModernSpellAlertSettings.db.profile.lesserHealingWaveEnabled = value
                        ModernSpellAlert_ApplySettings()
                        print("Lesser Healing Wave is now " .. (value and "enabled" or "disabled"))
                    end,
                },
            },
        },
        showMinimapIcon = {
            type = "toggle",
            name = "Show Minimap Icon",
            desc = "Toggle the visibility of the minimap icon.",
            order = 4,
            get = function() return ModernSpellAlertSettings.db.profile.showMinimapIcon end,
            set = function(value)
                ModernSpellAlertSettings.db.profile.showMinimapIcon = value
                if value then
                    ModernSpellAlertOptions:Show()
                else
                    ModernSpellAlertOptions:Hide()
                end
            end,
        },
    },
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
