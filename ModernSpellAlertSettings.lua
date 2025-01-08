-- ModernSpellAlert Settings Addon

ModernSpellAlertSettings = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDebug-2.0", "AceModuleCore-2.0", "AceConsole-2.0", "AceDB-2.0", "AceHook-2.1")
ModernSpellAlertSettings:RegisterDB("ModernSpellAlertSettingsDB")
ModernSpellAlertSettings:RegisterDefaults("profile", {
    showMinimapIcon = true,
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
        MAGE = {
            type = "group",
            name = "Mage",
            desc = "Settings for Mage spells.",
            order = 2,
            args = {
				manaShield = {
					type = "group",
                    name = "Mana Shield",
                    desc = "Settings for Mana Shield spell.",
                    order = 18,
                    args = {
                        EnabledByTarget = {
                            type = "toggle",
                            name = "Track by Target",
                            desc = "Enable or disable tracking when Mana Shield is cast by your target.",
                            order = 1,
                            get = function() return ModernSpellAlertSettings.db.profile.manaShieldEnabledByTarget end,
                            set = function(value)
                                ModernSpellAlertSettings.db.profile.manaShieldEnabledByTarget = value
                                print("Mana Shield (by Target) tracking is now " .. (value and "enabled" or "disabled"))
                            end,
                        },
                        EnabledByFriendly = {
                            type = "toggle",
                            name = "Track by Friendly",
                            desc = "Enable or disable tracking when Mana Shield is cast by a friendly unit.",
                            order = 2,
                            get = function() return ModernSpellAlertSettings.db.profile.manaShieldEnabledByFriendly end,
                            set = function(value)
                                ModernSpellAlertSettings.db.profile.manaShieldEnabledByFriendly = value
                                print("Mana Shield (by Friendly) tracking is now " .. (value and "enabled" or "disabled"))
                            end,
                        },
                        EnabledByHostile = {
                            type = "toggle",
                            name = "Track by Hostile",
                            desc = "Enable or disable tracking when Mana Shield is cast by a hostile unit.",
                            order = 3,
                            get = function() return ModernSpellAlertSettings.db.profile.manaShieldEnabledByHostile end,
                            set = function(value)
                                ModernSpellAlertSettings.db.profile.manaShieldEnabledByHostile = value
                                print("Mana Shield (by Hostile) tracking is now " .. (value and "enabled" or "disabled"))
                            end,
                        },
					},
                },
				pyroblast = {
					type = "group",
                    name = "Pyroblast",
                    desc = "Settings for Pyroblast spell.",
                    order = 19,
                    args = {
						EnabledPlayer = {
                            type = "toggle",
                            name = "Track on Player",
                            desc = "Enable or disable tracking when Pyroblast is cast on you.",
                            order = 1,
                            get = function() return ModernSpellAlertSettings.db.profile.pyroblastEnabledPlayer end,
                            set = function(value)
                                ModernSpellAlertSettings.db.profile.pyroblastEnabledPlayer = value
                                print("Pyroblast (on Player) tracking is now " .. (value and "enabled" or "disabled"))
                            end,
                        },
                        EnabledOnTarget = {
                            type = "toggle",
                            name = "Track on Target",
                            desc = "Enable or disable tracking when Pyroblast is cast on your target.",
                            order = 2,
                            get = function() return ModernSpellAlertSettings.db.profile.pyroblastEnabledOnTarget end,
                            set = function(value)
                                ModernSpellAlertSettings.db.profile.pyroblastEnabledOnTarget = value
                                print("Pyroblast (on Target) tracking is now " .. (value and "enabled" or "disabled"))
                            end,
                        },
						EnabledByTarget = {
                            type = "toggle",
                            name = "Track by Target",
                            desc = "Enable or disable tracking when Pyroblast is cast by your target.",
                            order = 3,
                            get = function() return ModernSpellAlertSettings.db.profile.pyroblastEnableFromTarget end,
                            set = function(value)
                                ModernSpellAlertSettings.db.profile.pyroblastEnabledByTarget = value
                                print("Pyroblast (by Target) tracking is now " .. (value and "enabled" or "disabled"))
                            end,
                        },
                        EnabledOnFriendly = {
                            type = "toggle",
                            name = "Track on Friendly",
                            desc = "Enable or disable tracking when Pyroblast is cast on a friendly unit.",
                            order = 4,
                            get = function() return ModernSpellAlertSettings.db.profile.pyroblastEnabledOnFriendly end,
                            set = function(value)
                                ModernSpellAlertSettings.db.profile.pyroblastEnabledOnFriendly = value
                                print("Pyroblast (on Friendly) tracking is now " .. (value and "enabled" or "disabled"))
                            end,
                        },
						EnabledByFriendly = {
                            type = "toggle",
                            name = "Track by Friendly",
                            desc = "Enable or disable tracking when Pyroblast is cast by a friendly unit.",
                            order = 5,
                            get = function() return ModernSpellAlertSettings.db.profile.pyroblastEnabledByFriendly end,
                            set = function(value)
                                ModernSpellAlertSettings.db.profile.pyroblastEnabledByFriendly = value
                                print("Pyroblast (by Friendly) tracking is now " .. (value and "enabled" or "disabled"))
                            end,
                        },
                        EnabledOnHostile = {
                            type = "toggle",
                            name = "Track on Hostile",
                            desc = "Enable or disable tracking when Pyroblast is cast on a hostile unit.",
                            order = 6,
                            get = function() return ModernSpellAlertSettings.db.profile.pyroblastEnabledOnHostile end,
                            set = function(value)
                                ModernSpellAlertSettings.db.profile.pyroblastEnabledOnHostile = value
                                print("Pyroblast (on Hostile) tracking is now " .. (value and "enabled" or "disabled"))
                            end,
                        },
						EnabledByHostile = {
                            type = "toggle",
                            name = "Track by Hostile",
                            desc = "Enable or disable tracking when Pyroblast is cast by a hostile unit.",
                            order = 7,
                            get = function() return ModernSpellAlertSettings.db.profile.pyroblastEnabledByHostile end,
                            set = function(value)
                                ModernSpellAlertSettings.db.profile.pyroblastEnabledByHostile = value
                                print("Pyroblast (by Hostile) tracking is now " .. (value and "enabled" or "disabled"))
                            end,
                        },
					},
                },
            },
        },
        SHAMAN = {
            type = "group",
            name = "Shaman",
            desc = "Settings for Shaman spells.",
            order = 3,
            args = {
                healingWave = {
                    type = "group",
                    name = "Healing Wave",
                    desc = "Settings for Healing Wave spell.",
                    order = 1,
                    args = {
						EnabledPlayer = {
                            type = "toggle",
                            name = "Track on Player",
                            desc = "Enable or disable tracking when Healing Wave is cast on you.",
                            order = 1,
                            get = function() return ModernSpellAlertSettings.db.profile.healingWaveEnabledPlayer end,
                            set = function(value)
                                ModernSpellAlertSettings.db.profile.healingWaveEnabledPlayer = value
                                print("Healing Wave (on Player) tracking is now " .. (value and "enabled" or "disabled"))
                            end,
                        },
                        EnabledOnTarget = {
                            type = "toggle",
                            name = "Track on Target",
                            desc = "Enable or disable tracking when Healing Wave is cast on your target.",
                            order = 2,
                            get = function() return ModernSpellAlertSettings.db.profile.healingWaveEnabledOnTarget end,
                            set = function(value)
                                ModernSpellAlertSettings.db.profile.healingWaveEnabledOnTarget = value
                                print("Healing Wave (on Target) tracking is now " .. (value and "enabled" or "disabled"))
                            end,
                        },
						EnabledByTarget = {
                            type = "toggle",
                            name = "Track by Target",
                            desc = "Enable or disable tracking when Healing Wave is cast by your target.",
                            order = 3,
                            get = function() return ModernSpellAlertSettings.db.profile.pyroblastEnableFromTarget end,
                            set = function(value)
                                ModernSpellAlertSettings.db.profile.healingWaveEnabledByTarget = value
                                print("Healing Wave (by Target) tracking is now " .. (value and "enabled" or "disabled"))
                            end,
                        },
                        EnabledOnFriendly = {
                            type = "toggle",
                            name = "Track on Friendly",
                            desc = "Enable or disable tracking when Healing Wave is cast on a friendly unit.",
                            order = 4,
                            get = function() return ModernSpellAlertSettings.db.profile.healingWaveEnabledOnFriendly end,
                            set = function(value)
                                ModernSpellAlertSettings.db.profile.healingWaveEnabledOnFriendly = value
                                print("Healing Wave (on Friendly) tracking is now " .. (value and "enabled" or "disabled"))
                            end,
                        },
						EnabledByFriendly = {
                            type = "toggle",
                            name = "Track by Friendly",
                            desc = "Enable or disable tracking when Healing Wave is cast by a friendly unit.",
                            order = 5,
                            get = function() return ModernSpellAlertSettings.db.profile.healingWaveEnabledByFriendly end,
                            set = function(value)
                                ModernSpellAlertSettings.db.profile.healingWaveEnabledByFriendly = value
                                print("Healing Wave (by Friendly) tracking is now " .. (value and "enabled" or "disabled"))
                            end,
                        },
                        EnabledOnHostile = {
                            type = "toggle",
                            name = "Track on Hostile",
                            desc = "Enable or disable tracking when Healing Wave is cast on a hostile unit.",
                            order = 6,
                            get = function() return ModernSpellAlertSettings.db.profile.healingWaveEnabledOnHostile end,
                            set = function(value)
                                ModernSpellAlertSettings.db.profile.healingWaveEnabledOnHostile = value
                                print("Healing Wave (on Hostile) tracking is now " .. (value and "enabled" or "disabled"))
                            end,
                        },
						EnabledByHostile = {
                            type = "toggle",
                            name = "Track by Hostile",
                            desc = "Enable or disable tracking when Healing Wave is cast by a hostile unit.",
                            order = 7,
                            get = function() return ModernSpellAlertSettings.db.profile.healingWaveEnabledByHostile end,
                            set = function(value)
                                ModernSpellAlertSettings.db.profile.healingWaveEnabledByHostile = value
                                print("Healing Wave (by Hostile) tracking is now " .. (value and "enabled" or "disabled"))
                            end,
                        },
					},
                },
            },
        },
        showMinimapIcon = {
            type = "toggle",
            name = "Show Minimap Icon",
            desc = "Toggle the visibility of the minimap icon.",
            order = 10,
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
