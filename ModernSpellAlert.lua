local ModernSpellAlert = {}

-- Variables
local playerGUID = nil
local fadeStartTime = nil 
local isFading = false    

-- Tracked spells and their icons
local spellNames = {
-- DRUID
    ["Abolish Poison"] = { icon = "Interface\\Icons\\Spell_Nature_NullifyPoison", profileKey = "abolishPoisonEnabled" },
    ["Barkskin"] = { icon = "Interface\\Icons\\Spell_Nature_StoneClawTotem", profileKey = "barkskinEnabled" },
    ["Dash"] = { icon = "Interface\\Icons\\Ability_Druid_Dash", profileKey = "dashEnabled" },
    ["Enrage"] = { icon = "Interface\\Icons\\Ability_Druid_Enrage", profileKey = "enrageEnabled" },
    ["Entangling Roots"] = { icon = "Interface\\Icons\\Spell_Nature_StrangleVines", profileKey = "entanglingRootsEnabled" },
    ["Frenzied Regeneration"] = { icon = "Interface\\Icons\\Ability_Bullrush", profileKey = "frenziedRegenEnabled" },
    ["Healing Touch"] = { icon = "Interface\\Icons\\Spell_Nature_HealingTouch", profileKey = "healingTouchEnabled" },
    ["Hibernate"] = { icon = "Interface\\Icons\\Spell_Nature_Sleep", profileKey = "hibernateEnabled" },
    ["Hurricane"] = { icon = "Interface\\Icons\\Spell_Nature_Cyclone", profileKey = "hurricaneEnabled" },
    ["Insect Swarm"] = { icon = "Interface\\Icons\\Spell_Nature_InsectSwarm", profileKey = "insectSwarmEnabled" },
    ["Moonfire"] = { icon = "Interface\\Icons\\Spell_Nature_StarFall", profileKey = "moonfireEnabled" },
    ["Nature's Grasp"] = { icon = "Interface\\Icons\\Spell_Nature_NaturesWrath", profileKey = "naturesGraspEnabled" },
    ["Rebirth"] = { icon = "Interface\\Icons\\Spell_Nature_Reincarnation", profileKey = "rebirthEnabled" },
    ["Regrowth"] = { icon = "Interface\\Icons\\Spell_Nature_ResistNature", profileKey = "regrowthEnabled" },
    ["Rejuvenation"] = { icon = "Interface\\Icons\\Spell_Nature_Rejuvenation", profileKey = "rejuvenationEnabled" },
    ["Starfire"] = { icon = "Interface\\Icons\\Spell_Arcane_StarFire", profileKey = "starfireEnabled" },
    ["Tranquility"] = { icon = "Interface\\Icons\\Spell_Nature_Tranquility", profileKey = "tranquilityEnabled" },
    ["Wrath"] = { icon = "Interface\\Icons\\Spell_Nature_AbolishMagic", profileKey = "wrathEnabled" },

	
-- HUNTER
	
-- MAGE
    ["Arcane Explosion"] = { icon = "Interface\\Icons\\Spell_Nature_WispSplode", profileKey = "arcaneExplosionEnabled" },
    ["Arcane Missiles"] = { icon = "Interface\\Icons\\Spell_Nature_StarFall", profileKey = "arcaneMissilesEnabled" },
    ["Blast Wave"] = { icon = "Interface\\Icons\\Spell_Holy_Excorcism_02", profileKey = "blastWaveEnabled" },
    ["Blink"] = { icon = "Interface\\Icons\\Spell_Arcane_Blink", profileKey = "blinkEnabled" },
    ["Blizzard"] = { icon = "Interface\\Icons\\Spell_Frost_IceStorm", profileKey = "blizzardEnabled" },
    ["Cold Snap"] = { icon = "Interface\\Icons\\Spell_Frost_WizardMark", profileKey = "coldSnapEnabled" },
    ["Combustion"] = { icon = "Interface\\Icons\\Spell_Fire_SealOfFire", profileKey = "combustionEnabled" },
    ["Cone of Cold"] = { icon = "Interface\\Icons\\Spell_Frost_Glacier", profileKey = "coneOfColdEnabled" },
    ["Counterspell"] = { icon = "Interface\\Icons\\Spell_Frost_IceShock", profileKey = "counterspellEnabled" },
    ["Fire Ward"] = { icon = "Interface\\Icons\\Spell_Fire_FireArmor", profileKey = "fireWardEnabled" },
    ["Fireball"] = { icon = "Interface\\Icons\\Spell_Fire_FlameBolt", profileKey = "fireballEnabled" },
    ["Flamestrike"] = { icon = "Interface\\Icons\\Spell_Fire_SelfDestruct", profileKey = "flamestrikeEnabled" },
    ["Frost Warding"] = { icon = "Interface\\Icons\\Spell_Frost_FrostWard", profileKey = "frostWardingEnabled" },
    ["Ice Barrier"] = { icon = "Interface\\Icons\\Spell_Ice_Lament", profileKey = "iceBarrierEnabled" },
    ["Ice Block"] = { icon = "Interface\\Icons\\Spell_Frost_Frost", profileKey = "iceBlockEnabled" },
    ["Mana Shield"] = { icon = "Interface\\Icons\\Spell_Shadow_DetectLesserInvisibility", profileKey = "manaShieldEnabled" },
    ["Polymorph"] = { icon = "Interface\\Icons\\Spell_Nature_Polymorph", profileKey = "polymorphEnabled" },
    ["Pyroblast"] = { icon = "Interface\\Icons\\Spell_Fire_Fireball02", profileKey = "pyroblastEnabled" },
    ["Scorch"] = { icon = "Interface\\Icons\\Spell_Fire_SoulBurn", profileKey = "scorchEnabled" },
    ["Slow Fall"] = { icon = "Interface\\Icons\\Spell_Magic_FeatherFall", profileKey = "slowFallEnabled" },
	
-- PALADIN
    ["Blessing of Freedom"] = { icon = "Interface\\Icons\\Spell_Holy_SealOfValor", profileKey = "blessingFreedomEnabled" },
    ["Blessing of Protection"] = { icon = "Interface\\Icons\\Spell_Holy_SealOfProtection", profileKey = "blessingProtectionEnabled" },
    ["Blessing of Sacrifice"] = { icon = "Interface\\Icons\\Spell_Holy_SealOfSacrifice", profileKey = "blessingSacrificeEnabled" },
    ["Cleanse"] = { icon = "Interface\\Icons\\Spell_Holy_Purify", profileKey = "cleanseEnabled" },
    ["Consecration"] = { icon = "Interface\\Icons\\Spell_Holy_InnerFire", profileKey = "consecrationEnabled" },
    ["Divine Protection"] = { icon = "Interface\\Icons\\Spell_Holy_Restoration", profileKey = "divineProtectionEnabled" },
    ["Divine Shield"] = { icon = "Interface\\Icons\\Spell_Holy_DivineIntervention", profileKey = "divineShieldEnabled" },
    ["Flash of Light"] = { icon = "Interface\\Icons\\Spell_Holy_FlashHeal", profileKey = "flashOfLightEnabled" },
    ["Hammer of Justice"] = { icon = "Interface\\Icons\\Spell_Holy_SealOfMight", profileKey = "hammerOfJusticeEnabled" },
    ["Hammer of Wrath"] = { icon = "Interface\\Icons\\Ability_ThunderClap", profileKey = "hammerOfWrathEnabled" },
    ["Holy Light"] = { icon = "Interface\\Icons\\Spell_Holy_HolyBolt", profileKey = "holyLightEnabled" },
    ["Holy Shock"] = { icon = "Interface\\Icons\\Spell_Holy_SearingLight", profileKey = "holyShockEnabled" },
    ["Lay on Hands"] = { icon = "Interface\\Icons\\Spell_Holy_LayOnHands", profileKey = "layOnHandsEnabled" },
    ["Purify"] = { icon = "Interface\\Icons\\Spell_Holy_Purify", profileKey = "purifyEnabled" },
    ["Redemption"] = { icon = "Interface\\Icons\\Spell_Holy_Resurrection", profileKey = "redemptionEnabled" },
    ["Repentance"] = { icon = "Interface\\Icons\\Spell_Holy_PrayerOfHealing", profileKey = "repentanceEnabled" },
	
-- PRIEST
    ["Abolish Disease"] = { icon = "Interface\\Icons\\Spell_Nature_NullifyDisease", profileKey = "abolishDiseaseEnabled" },
    ["Desperate Prayer"] = { icon = "Interface\\Icons\\Spell_Holy_Restoration", profileKey = "desperatePrayerEnabled" },
    ["Devouring Plague"] = { icon = "Interface\\Icons\\Spell_Shadow_BlackPlague", profileKey = "devouringPlagueEnabled" },
    ["Dispel Magic"] = { icon = "Interface\\Icons\\Spell_Holy_DispelMagic", profileKey = "dispelMagicEnabled" },
    ["Fear Ward"] = { icon = "Interface\\Icons\\Spell_Holy_Excorcism", profileKey = "fearWardEnabled" },
    ["Flash Heal"] = { icon = "Interface\\Icons\\Spell_Holy_FlashHeal", profileKey = "flashHealEnabled" },
    ["Greater Heal"] = { icon = "Interface\\Icons\\Spell_Holy_GreaterHeal", profileKey = "greaterHealEnabled" },
    ["Heal"] = { icon = "Interface\\Icons\\Spell_Holy_Heal", profileKey = "healEnabled" },
    ["Holy Fire"] = { icon = "Interface\\Icons\\Spell_Holy_SearingLight", profileKey = "holyFireEnabled" },
    ["Holy Nova"] = { icon = "Interface\\Icons\\Spell_Holy_HolyNova", profileKey = "holyNovaEnabled" },
    ["Levitate"] = { icon = "Interface\\Icons\\Spell_Holy_Leyward", profileKey = "levitateEnabled" },
    ["Mana Burn"] = { icon = "Interface\\Icons\\Spell_Shadow_ManaBurn", profileKey = "manaBurnEnabled" },
    ["Mind Blast"] = { icon = "Interface\\Icons\\Spell_Shadow_UnholyFrenzy", profileKey = "mindBlastEnabled" },
    ["Mind Flay"] = { icon = "Interface\\Icons\\Spell_Shadow_SiphonMana", profileKey = "mindFlayEnabled" },
    ["Power Word: Shield"] = { icon = "Interface\\Icons\\Spell_Holy_PowerWordShield", profileKey = "powerWordShieldEnabled" },
    ["Prayer of Healing"] = { icon = "Interface\\Icons\\Spell_Holy_PrayerOfHealing02", profileKey = "prayerOfHealingEnabled" },
    ["Psychic Scream"] = { icon = "Interface\\Icons\\Spell_Shadow_PsychicScream", profileKey = "psychicScreamEnabled" },
    ["Renew"] = { icon = "Interface\\Icons\\Spell_Holy_Renew", profileKey = "renewEnabled" },
    ["Resurrection"] = { icon = "Interface\\Icons\\Spell_Holy_Resurrection", profileKey = "resurrectionEnabled" },
    ["Shadow Word: Pain"] = { icon = "Interface\\Icons\\Spell_Shadow_ShadowWordPain", profileKey = "shadowWordPainEnabled" },
    ["Smite"] = { icon = "Interface\\Icons\\Spell_Holy_HolySmite", profileKey = "smiteEnabled" },
	
-- ROGUE
	
-- SHAMAN (with proper 1.12 icons)
    ["Healing Wave"] = { icon = "Interface\\Icons\\Spell_Nature_MagicImmunity", profileKey = "healingWaveEnabled" },
    ["Lesser Healing Wave"] = { icon = "Interface\\Icons\\Spell_Nature_HealingWaveLesser", profileKey = "lesserHealingWaveEnabled" },
    ["Chain Heal"] = { icon = "Interface\\Icons\\Spell_Nature_HealingWaveGreater", profileKey = "chainHealEnabled" },
    ["Lightning Bolt"] = { icon = "Interface\\Icons\\Spell_Nature_Lightning", profileKey = "lightningBoltEnabled" },
    ["Earth Shock"] = { icon = "Interface\\Icons\\Spell_Nature_EarthShock", profileKey = "earthShockEnabled" },
    ["Flame Shock"] = { icon = "Interface\\Icons\\Spell_Fire_FlameShock", profileKey = "flameShockEnabled" },
    ["Frost Shock"] = { icon = "Interface\\Icons\\Spell_Frost_FrostShock", profileKey = "frostShockEnabled" },
    ["Grounding Totem"] = { icon = "Interface\\Icons\\Spell_Nature_GroundingTotem", profileKey = "groundingTotemEnabled" },
	
-- WARLOCK
	
-- WARRIOR
}

-- Get saved toggles for spellNames table.
function ModernSpellAlert_ApplySettings()
    for spell, data in pairs(spellNames) do
        data.enabled = ModernSpellAlertSettings.db.profile[data.profileKey] or false
    end
end


-- Create the main message frame
local function ModernSpellAlert_CreateMessageFrame()
    local frame = CreateFrame("Frame", "ModernSpellAlertFrame", UIParent)
    frame:SetWidth(512)
    frame:SetHeight(80)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 200)
    frame:SetFrameStrata("HIGH")

    -- Texture for the arrow icon (centered in the frame)
    frame.arrowIcon = frame:CreateTexture(nil, "OVERLAY")
    frame.arrowIcon:SetWidth(34)
    frame.arrowIcon:SetHeight(34)
    frame.arrowIcon:SetPoint("CENTER", frame, "CENTER", 0, 0)
    frame.arrowIcon:SetTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up") -- Arrow icon

    -- Text for the caster name (to the left of the arrow icon, centered vertically)
    frame.casterText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.casterText:SetPoint("RIGHT", frame.arrowIcon, "LEFT", -7, 0)
    frame.casterText:SetJustifyH("RIGHT")
    frame.casterText:SetFont("Fonts\\FRIZQT__.TTF", 32, "THINOUTLINE")

    -- Text for the target name (to the right of the arrow icon, centered vertically)
    frame.targetText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.targetText:SetPoint("LEFT", frame.arrowIcon, "RIGHT", 7, 0)
    frame.targetText:SetJustifyH("LEFT")
    frame.targetText:SetFont("Fonts\\FRIZQT__.TTF", 32, "THINOUTLINE")

    -- Texture for the spell icon (to the left of the caster name, centered vertically)
    frame.spellIcon = frame:CreateTexture(nil, "OVERLAY")
    frame.spellIcon:SetWidth(64)
    frame.spellIcon:SetHeight(64)
    frame.spellIcon:SetPoint("RIGHT", frame.casterText, "LEFT", -10, 0)

    frame:SetAlpha(1)
    frame:Hide()

    return frame
end

ModernSpellAlert.frame = ModernSpellAlert_CreateMessageFrame()

-- Find player GUID
local function FetchPlayerGUID()
    _, playerGUID = UnitExists("player")
end

-- Start fade-out
local function StartFadeOut()
    fadeStartTime = GetTime()
    isFading = true
end

-- Event Handler
local function ModernSpellAlert_OnEvent()
    if event == "PLAYER_ENTERING_WORLD" then
        if not playerGUID then
            FetchPlayerGUID() -- Fetch GUID if not available
        end
        ModernSpellAlert_ApplySettings()
        print("ModernSpellAlert initialized.")

    elseif event == "UNIT_CASTEVENT" then
        local casterGUID = arg1  -- Caster's GUID
        local targetGUID = arg2  -- Target's GUID
        local eventType = arg3   -- Event type (START, CAST, FAIL, MAINHAND, OFFHAND)
        local spellID = arg4     -- Spell ID
        local spellName = SpellInfo(spellID)

        -- Fetch caster and target names
        local casterName = UnitName(casterGUID) or "Unknown"
        local targetName = UnitName(targetGUID) or "Unknown"

        -- Check if the spell is in the spellNames table
        if targetGUID == playerGUID and eventType == "START" and spellNames[spellName] and spellNames[spellName].enabled then
            -- Fetch the hardcoded icon for the spell
            local spellIcon = spellNames[spellName].icon

            -- Update the frame
            ModernSpellAlert.frame.casterText:SetText(casterName)
            ModernSpellAlert.frame.targetText:SetText(targetName)
            ModernSpellAlert.frame.spellIcon:SetTexture(spellIcon or "Interface\\Icons\\INV_Misc_QuestionMark") -- Fallback icon

            -- Display the frame
            ModernSpellAlert.frame:SetAlpha(1) -- Ensure fully visible
            ModernSpellAlert.frame:Show()

            -- Cancel any ongoing fade-out
            isFading = false

            -- Start fade-out
            StartFadeOut()
        end
    end
end

-- OnUpdate handler for fade-out logic
local function OnUpdateHandler(self, elapsed)
    if isFading then
        local currentTime = GetTime()
        local progress = (currentTime - fadeStartTime) / 2.5 -- 2.5-second fade duration
        if progress >= 1 then
            ModernSpellAlert.frame:SetAlpha(0)
            ModernSpellAlert.frame:Hide()
            isFading = false
        else
            ModernSpellAlert.frame:SetAlpha(1 - progress)
        end
    end
end

-- Attach the OnUpdate script to the frame
ModernSpellAlert.frame:SetScript("OnUpdate", OnUpdateHandler)

-- Initialize the addon
local function InitializeAddon()
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("UNIT_CASTEVENT")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:SetScript("OnEvent", ModernSpellAlert_OnEvent)
end

InitializeAddon()
