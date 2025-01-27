-- ==============================
-- ModernSpellAlert Addon
-- Main Script for Tracking Spell Casts and Showing Alerts
-- ==============================

-- ==============================
-- Namespace and Dependencies
-- ==============================
ModernSpellAlert = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0")

-- ==============================
-- Bindings
-- ==============================
BINDING_HEADER_MODERNSPELLALERT = "Modern Spell Alert"

-- ==============================
-- Variables
-- ==============================
local playerGUID, fadeStartTime, lastCasterName, lastTargetName, isFading, lastCleanupTime = nil, nil, nil, nil, false, 0
local spellNames, activeCasts, recentAoECasts, recentTraps, recentTotems  = {}, {}, {}, {}, {}
local specialAoESpells = {
    ["Swipe"] = true,
    ["Multi-Shot"] = true,
    ["Chain Lightning"] = true,
    ["Chain Heal"] = true,
    ["Intimidating Shout"] = true,
    ["Cleave"] = true,
}
local totemDurations = {
    ["Earthbind Totem"] = 45,
    ["Fire Nova Totem"] = 5.5,
    ["Magma Totem"] = 20,
    ["Searing Totem"] = 55,
}

-- ==============================
-- Sound Alerts Paths
-- ==============================
local ModernSpellAlertSounds = {
    ["Adrenaline Rush"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\AdrenalineRush.ogg",
    ["Arcane Power"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\ArcanePower.ogg",
    ["Banish"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Banish.ogg",
    ["Barskin"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Barkskin.ogg",
    ["Battle Stance"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\BattleStance.ogg",
    ["Berserk"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Berserk.ogg",
    ["Berserker Rage"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\BerserkerRage.ogg",
    ["Berserker Stance"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\BerserkerStance.ogg",
    ["Bestial Wrath"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\BestialWrath.ogg",
    ["Blade Flurry"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\BladeFlurry.ogg",
    ["Blessing of Freedom"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\BlessingofFreedom.ogg",
    ["Blessing of Protection"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\BlessingofProtectiondown.ogg",
    ["Blessing of Sacrifice"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Sacrifice.ogg",
    ["Blind"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Blind.ogg",
    ["Cannibalize"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Cannibalize.ogg",
    ["Cold Blood"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\ColdBlood.ogg",
    ["Cold Snap"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\ColdSnap.ogg",
    ["Combustion"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Combustion.ogg",
    ["Concussion Blow"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\ConcussionBlow.ogg",
    ["Counterspell"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Counterspell-Silenced.ogg",
    ["Dash"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Dash.ogg",
    ["Death Coil"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\DeathCoil.ogg",
    ["Death Wish"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\DeathWish.ogg",
    ["Defense Stance"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\DefenseStance.ogg",
    ["Deterrence"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Deterrence.ogg",
    ["Disarm"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Disarm.ogg",
    ["Divine Favor"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\DivineFavor.ogg",
    ["Divine Shield"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\DivineShield.ogg",
    ["Drink"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Drink.ogg",
    ["Earthbind Totem"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\EarthbindTotem.ogg",
    ["Elemental Mastery"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\ElementalMastery.ogg",
    ["Enrage"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Enrage.ogg",
    ["Entangling Roots"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\EntanglingRoots.ogg",
    ["Escape Artist"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\EscapeArtist.ogg",
    ["Evasion"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Evasion.ogg",
    ["Evocation"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Evocation.ogg",
    ["Fear"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Fear.ogg",
    ["Fear Ward"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\FearWard.ogg",
    ["First Aid"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\FirstAid.ogg",
    ["Freezing Trap"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\FreezingTrap.ogg",
    ["Frenzied Regeneration"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\FrenziedRegeneration.ogg",
    ["Grounding Totem"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\GroundingTotem.ogg",
    ["Hammer of Justice"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\HammerofJustice.ogg",
    ["Hand of Freedom"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\BlessingofFreedom.ogg",
    ["Hand of Protection"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\BlessingofProtectiondown.ogg",
    ["Hand of Sacrifice"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Sacrifice.ogg",
    ["Hearthstone"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Hearthstone.ogg",
    ["Hibernate"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Hibernate.ogg",
    ["Howl of Terror"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\HowlofTerror.ogg",
    ["Ice Block"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\IceBlock.ogg",
    ["Inner Focus"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\InnerFocus.ogg",
    ["Innervate"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Innervate.ogg",
    ["Intimidating Shout"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\IntimidatingShout.ogg",
    ["Intimidation"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Intimidation.ogg",
    ["Kick"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Kick.ogg",
    ["Last Stand"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\LastStand.ogg",
    ["Mana Burn"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\ManaBurn.ogg",
    ["Mana Tide Totem"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\ManaTideTotem.ogg",
    ["Mind Control"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\MindControl.ogg",
    ["Nature's Grasp"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Nature'sGrasp.ogg",
    ["Nature's Swiftness"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Nature'sSwiftness.ogg",
    ["Polymorph"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Polymorph.ogg",
    ["Power Infusion"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\PowerInfusion.ogg",
    ["Preparation"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Preparation.ogg",
    ["Presence of Mind"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\PresenceofMind.ogg",
    ["Psychic Scream"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\PsychicScream.ogg",
    ["Pummel"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Pummel.ogg",
    ["Rapid Fire"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\RapidFire.ogg",
    ["Recklessness"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Recklessness.ogg",
    ["Reflector"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Reflector.ogg",
    ["Repentance"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Repentance.ogg",
    ["Ressurection"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Resurrection.ogg",
    ["Retaliation"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Retaliation.ogg",
    ["Revive Pet"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\RevivePet.ogg",
    ["Scare Beast"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\ScareBeast.ogg",
    ["Scatter Shot"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\ScatterShot.ogg",
    ["Seduction"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Seduction.ogg",
    ["Shield Wall"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\ShieldWall.ogg",
    ["Silence"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Silence.ogg",
    ["Spell Lock"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\SpellLock.ogg",
    ["Sprint"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Sprint.ogg",
    ["Stoneform"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Stoneform.ogg",
    ["Summon Felhunter"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\summondemon.ogg",
    ["Summon Succubus"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\summondemon.ogg",
    ["Summon Voidwalker"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\summondemon.ogg",
    ["Summon Imp"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\summondemon.ogg",
    ["Sweeping Strikes"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\SweepingStrikes.ogg",
    ["Tranquility"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Tranquility.ogg",
    ["Tremor Totem"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\TremorTotem.ogg",
    ["Trinket"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Trinket.ogg",
    ["Vanish"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\Vanish.ogg",
    ["War Stomp"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\WarStomp.ogg",
    ["Will of the Forsaken"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\WilloftheForsaken.ogg",
    ["Wyvern Sting"] = "Interface\\AddOns\\ModernSpellAlert\\sounds\\WyvernSting.ogg",
}
-- ==============================
-- Font Paths
-- ==============================
local availableFonts = {
    "Interface\\AddOns\\ModernSpellAlert\\fonts\\BalooBhaina.ttf",
    "Interface\\AddOns\\ModernSpellAlert\\fonts\\Bungee.ttf",
    "Interface\\AddOns\\ModernSpellAlert\\fonts\\CaesarDressing.ttf",
    "Interface\\AddOns\\ModernSpellAlert\\fonts\\CoveredByYourGrace.ttf",
    "Interface\\AddOns\\ModernSpellAlert\\fonts\\JotiOne.ttf",
    "Interface\\AddOns\\ModernSpellAlert\\fonts\\LondrinaSolid.ttf",
    "Interface\\AddOns\\ModernSpellAlert\\fonts\\NovaFlat.ttf",
    "Interface\\AddOns\\ModernSpellAlert\\fonts\\Roboto.ttf",
    "Interface\\AddOns\\ModernSpellAlert\\fonts\\RobotoMono.ttf",
    "Interface\\AddOns\\ModernSpellAlert\\fonts\\SedgwickAveDisplay.ttf",
    "Interface\\AddOns\\ModernSpellAlert\\fonts\\Share.ttf",
    "Interface\\AddOns\\ModernSpellAlert\\fonts\\ShareBold.ttf",
    "Interface\\AddOns\\ModernSpellAlert\\fonts\\Sniglet.ttf",
    "Interface\\AddOns\\ModernSpellAlert\\fonts\\SquadaOne.ttf",
}

-- ==============================
-- Custom Icons
-- ==============================
local customIcons = {
    ["Arcanite Dragonling"] = "Interface\\Icons\\INV_Misc_Head_Dragon_01",
    ["Advanced Target Dummy"] = "Interface\\Icons\\INV_Crate_06",
    ["Battle Chicken"] = "Interface\\Icons\\Spell_Magic_PolymorphChicken",
    ["Cloaking"] = "Interface\\Icons\\INV_Gizmo_01",
    ["Defibrillate"] = "Interface\\Icons\\INV_Misc_EngGizmos_10",
    ["Discombobulate"] = "Interface\\Icons\\INV_Misc_SpyGlass_02",
    ["Everlook Transporter"] = "Interface\\Icons\\INV_Misc_EngGizmos_07",
    ["Explosive Sheep"] = "Interface\\Icons\\Spell_Nature_Polymorph",
    ["Field Repair Bot 74A"] = "Interface\\Icons\\INV_Egg_05",
    ["Fire Resistance"] = "Interface\\Icons\\INV_Gizmo_01",
    ["Fire Reflector"] = "Interface\\Icons\\INV_Misc_EngGizmos_04",
    ["Frost Resistance"] = "Interface\\Icons\\INV_Gizmo_01",
    ["Frost Reflector"] = "Interface\\Icons\\INV_Misc_EngGizmos_02",
    ["Gnomish Death Ray"] = "Interface\\Icons\\INV_Gizmo_08",
    ["Gnomish Mind Control Cap"] = "Interface\\Icons\\INV_Helmet_49",
    ["Gnomish Rocket Boots"] = "Interface\\Icons\\INV_Boots_02",
    ["Gnomish Transporter"] = "Interface\\Icons\\INV_Misc_EngGizmos_12",
    ["Goblin Land Mine"] = "Interface\\Icons\\INV_Shield_08",
    ["Goblin Rocket Boots"] = "Interface\\Icons\\INV_Gizmo_RocketBoot_01",
    ["Goblin Mortar"] = "Interface\\Icons\\INV_Musket_01",
    ["Invisibility"] = "Interface\\Icons\\INV_Potion_25",
    ["Lesser Invisibility"] = "Interface\\Icons\\INV_Potion_18",
    ["Masterwork Target Dummy"] = "Interface\\Icons\\INV_Crate_06",
    ["Mithril Mechanical Dragonling"] = "Interface\\Icons\\INV_Misc_Head_Dragon_01",
    ["Mechanical Dragonling"] = "Interface\\Icons\\INV_Misc_Head_Dragon_01",
    ["Net-o-Matic"] = "Interface\\Icons\\INV_Misc_Net_01",
    ["Reckless Charge"] = "Interface\\Icons\\INV_Helmet_49",
    ["Rocket Boots"] = "Interface\\Icons\\INV_Boots_05",
    ["Shrink Ray"] = "Interface\\Icons\\INV_Gizmo_09",
    ["Target Dummy"] = "Interface\\Icons\\INV_Crate_06",
    ["Harm Prevention Belt"] = "Interface\\Icons\\INV_Belt_06",
    ["Shadow Reflector"] = "Interface\\Icons\\INV_Misc_EngGizmos_16",
    ["Rough Dynamite"] = "Interface\\Icons\\INV_Misc_Bomb_06",
    ["Rough Copper Bomb"] = "Interface\\Icons\\INV_Misc_Bomb_09",
    ["Coarse Dynamite"] = "Interface\\Icons\\INV_Misc_Bomb_06",
    ["Ez-Thro Dynamite"] = "Interface\\Icons\\INV_Misc_Bomb_06",
    ["Large Copper Bomb"] = "Interface\\Icons\\INV_Misc_Bomb_01",
    ["Small Bronze Bomb"] = "Interface\\Icons\\INV_Misc_Bomb_09",
    ["Heavy Dynamite"] = "Interface\\Icons\\INV_Misc_Bomb_06",
    ["Big Bronze Bomb"] = "Interface\\Icons\\INV_Misc_Bomb_05",
    ["Solid Dynamite"] = "Interface\\Icons\\INV_Misc_Bomb_06",
    ["Iron Grenade"] = "Interface\\Icons\\INV_Misc_Bomb_08",
    ["Flash Bomb"] = "Interface\\Icons\\INV_Misc_Ammo_Bullet_01",
    ["Big Iron Bomb"] = "Interface\\Icons\\INV_Misc_Bomb_01",
    ["Mithril Frag Bomb"] = "Interface\\Icons\\INV_Misc_Bomb_02",
    ["Hi-Explosive Bomb"] = "Interface\\Icons\\INV_Misc_Bomb_07",
    ["The Big One"] = "Interface\\Icons\\INV_Misc_Bomb_04",
    ["Dense Dynamite"] = "Interface\\Icons\\INV_Misc_Bomb_06",
    ["Thorium Grenade"] = "Interface\\Icons\\INV_Misc_Bomb_08",
    ["Dark Iron Bomb"] = "Interface\\Icons\\INV_Misc_Bomb_05",
    ["Arcane Bomb"] = "Interface\\Icons\\Spell_Shadow_MindBomb",
    ["Fire Protection"] = "Interface\\Icons\\INV_Potion_24",
    ["Shadow Protection"] = "Interface\\Icons\\INV_Potion_23",
    ["Frost Protection"] = "Interface\\Icons\\INV_Potion_20",
    ["Arcane Protection"] = "Interface\\Icons\\INV_Potion_83",
    ["Nature Protection "] = "Interface\\Icons\\INV_Potion_22",
    ["Holy Protection"] = "Interface\\Icons\\INV_Potion_09",
    ["Invulnerability"] = "Interface\\Icons\\INV_Potion_62",
    ["Free Action"] = "Interface\\Icons\\INV_Potion_04",
    ["Living Free Action"] = "Interface\\Icons\\INV_Potion_07",
    ["Tidal Charm"] = "Interface\\Icons\\INV_Misc_Rune_01",
    ["Flee"] = "Interface\\Icons\\INV_Misc_Bone_ElfSkull_01",
    ["Speed"] = "Interface\\Icons\\INV_Misc_PocketWatch_01",
    ["First Aid"] = "Interface\\Icons\\INV_Misc_Bandage_12",
    ["Sleep"] = "Interface\\Icons\\INV_Misc_Dust_02",
    ["Restoration"] = "Interface\\Icons\\INV_Potion_01",
    ["Stealth Detection"] = "Interface\\Icons\\INV_Potion_36",
    ["Immune Root"] = "Interface\\Icons\\INV_Belt_25",
    ["Aura of Protection"] = "Interface\\Icons\\INV_Misc_ArmorKit_04",
    ["Emerald Transformation"] = "Interface\\Icons\\INV_Shield_23",
    ["Trap"] = "Interface\\Icons\\INV_Misc_Net_01",
    ["Insignia"] = "Interface\\Icons\\INV_Jewelry_TrinketPvp_02",
    ["Immune Root/Snare/Stun"] = "Interface\\Icons\\INV_Jewelry_TrinketPvp_02",
    ["Immune Charm/Fear/Polymorph"] = "Interface\\Icons\\INV_Jewelry_TrinketPvp_02",
    ["Immune Fear/Polymorph/Snare"] = "Interface\\Icons\\INV_Jewelry_TrinketPvp_02",
    ["Immune Charm/Fear/Stun"] = "Interface\\Icons\\INV_Jewelry_TrinketPvp_02",
    ["Immune Fear/Polymorph/Stun"] = "Interface\\Icons\\INV_Jewelry_TrinketPvp_02",
}
-- ==============================
-- Frame Management
-- ==============================
function ModernSpellAlert:CreateMessageFrame()
    local frame = CreateFrame("Frame", "ModernSpellAlertFrame", UIParent)
    frame:SetWidth(512)
    frame:SetHeight(80)

    local x = ModernSpellAlertSettings.db.profile.framePosX or 0
    local y = ModernSpellAlertSettings.db.profile.framePosY or 200
    frame:SetPoint("CENTER", UIParent, "CENTER", x, y)
    frame:SetFrameStrata("HIGH")

    frame.arrowIcon = frame:CreateTexture(nil, "OVERLAY")
    frame.arrowIcon:SetWidth(34)
    frame.arrowIcon:SetHeight(34)
    frame.arrowIcon:SetPoint("CENTER", frame, "CENTER", 0, 0)
    frame.arrowIcon:SetTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")

    local selectedFont = self:GetSelectedFont()

    frame.casterText = frame:CreateFontString(nil, "OVERLAY")
    frame.casterText:SetPoint("RIGHT", frame.arrowIcon, "LEFT", -7, 0)
    frame.casterText:SetJustifyH("RIGHT")
    frame.casterText:SetFont(selectedFont, 32, "THINOUTLINE")

    frame.targetText = frame:CreateFontString(nil, "OVERLAY")
    frame.targetText:SetPoint("LEFT", frame.arrowIcon, "RIGHT", 7, 0)
    frame.targetText:SetJustifyH("LEFT")
    frame.targetText:SetFont(selectedFont, 32, "THINOUTLINE")

    frame.spellIcon = frame:CreateTexture(nil, "OVERLAY")
    frame.spellIcon:SetWidth(64)
    frame.spellIcon:SetHeight(64)
    frame.spellIcon:SetPoint("RIGHT", frame.casterText, "LEFT", -10, 0)

    frame:SetAlpha(1)
    frame:Hide()
    return frame
end

function ModernSpellAlert:RefreshMessageFrame()
    if not self.frame then return end

    self.frame.casterText:Hide()
    self.frame.casterText = nil
    self.frame.targetText:Hide()
    self.frame.targetText = nil

    local selectedFont = self:GetSelectedFont()

    self.frame.casterText = self.frame:CreateFontString(nil, "OVERLAY")
    self.frame.casterText:SetPoint("RIGHT", self.frame.arrowIcon, "LEFT", -7, 0)
    self.frame.casterText:SetJustifyH("RIGHT")
    self.frame.casterText:SetFont(selectedFont, 32, "THINOUTLINE")

    self.frame.targetText = self.frame:CreateFontString(nil, "OVERLAY")
    self.frame.targetText:SetPoint("LEFT", self.frame.arrowIcon, "RIGHT", 7, 0)
    self.frame.targetText:SetJustifyH("LEFT")
    self.frame.targetText:SetFont(selectedFont, 32, "THINOUTLINE")
end

function ModernSpellAlert:ShowTestFrame()
    if not self.frame then
        self.frame = self:CreateMessageFrame()
    end

    local selectedFont = self:GetSelectedFont()
    self.frame.casterText:SetFont(selectedFont, 32, "THINOUTLINE")
    self.frame.targetText:SetFont(selectedFont, 32, "THINOUTLINE")

    self.frame.casterText:SetText("Test Caster")
    self.frame.targetText:SetText("Test Target")
    self.frame.spellIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")

    self.frame.spellIcon:ClearAllPoints()
    self.frame.spellIcon:SetPoint("RIGHT", self.frame.casterText, "LEFT", -10, 0)

    self.frame.arrowIcon:ClearAllPoints()
    self.frame.arrowIcon:SetPoint("CENTER", self.frame, "CENTER", 0, 0)

    self.frame.casterText:ClearAllPoints()
    self.frame.casterText:SetPoint("RIGHT", self.frame.arrowIcon, "LEFT", -7, 0)

    self.frame.targetText:ClearAllPoints()
    self.frame.targetText:SetPoint("LEFT", self.frame.arrowIcon, "RIGHT", 7, 0)

    self.frame.arrowIcon:Show()
    self.frame.targetText:Show()

    self.frame:SetPoint("CENTER", UIParent, "CENTER", ModernSpellAlertSettings.db.profile.framePosX,
        ModernSpellAlertSettings.db.profile.framePosY)
    self.frame:SetAlpha(1)
    self.frame:Show()
end

function ModernSpellAlert:HideTestFrame()
    if self.frame then
        self.frame:Hide()
    end
end

function ModernSpellAlert:StartFadeOut()
    fadeStartTime = GetTime()
    isFading = true
    self.frame:SetScript("OnUpdate", function()
        self:OnUpdate()
    end)
end

-- ==============================
-- Fonts
-- ==============================
function ModernSpellAlert:GetSelectedFont()
    local index = ModernSpellAlertSettings.db.profile.fontIndex or 2
    return availableFonts[index] or availableFonts[2]
end

function ModernSpellAlert:UpdateFont()
    if not self.frame then return end
    local selectedFont = self:GetSelectedFont()
    self.frame.casterText:SetFont(selectedFont, 32, "THINOUTLINE")
    self.frame.targetText:SetFont(selectedFont, 32, "THINOUTLINE")
end

function ModernSpellAlert:OnFontChanged(newFontIndex)
    ModernSpellAlertSettings.db.profile.fontIndex = newFontIndex
    self:RefreshMessageFrame()
end

-- ==============================
-- Utility
-- ==============================
function ModernSpellAlert:FetchPlayerGUID()
    _, playerGUID = UnitExists("player")
end

function ModernSpellAlert:CleanupTrackingTables()
    local currentTime = GetTime()

    local function cleanTable(table, maxAge)
        for key, data in pairs(table) do
            if currentTime - data.timestamp > maxAge then
                table[key] = nil
            end
        end
    end

    cleanTable(activeCasts, 15)
    cleanTable(recentAoECasts, 10)
    cleanTable(recentTraps, 60)

    for key, data in pairs(recentTotems) do
        if currentTime - data.timestamp > (data.duration or 0) then
            recentTotems[key] = nil
        end
    end
end


function ModernSpellAlert:TrimSpellName(spellName)
    if not spellName then return nil end
    return string.gsub(spellName, "^%s*(.-)%s*$", "%1")
end

-- ==============================
-- List of Tracked Spells
-- ==============================
function ModernSpellAlert:PopulateSpellNames()
    local profile = ModernSpellAlertSettings.db.profile
    spellNames = {}

    for spellName, settings in pairs(profile) do
        if type(settings) == "table" then
            local profileKeys = {}
            for key, value in pairs(settings) do
                if value then
                    profileKeys[key] = true
                end
            end
            if next(profileKeys) then
                spellNames[spellName] = { profileKeys = profileKeys }
            end
        end
    end
end

-- ==============================
-- Play Sounds
-- ==============================
function ModernSpellAlert:PlaySoundForSpell(spellName)
    local soundFilePath = ModernSpellAlertSounds[spellName]
    if ModernSpellAlertSettings.db.profile.playSoundForSpell and soundFilePath then
        PlaySoundFile(soundFilePath)
    end
end

-- ==============================
-- Targeting
-- ==============================
function MSACaster()
    if lastCasterName then
        TargetByName(lastCasterName, true)
    end
end

function MSATarget()
    if lastTargetName then
        TargetByName(lastTargetName, true)
    end
end

-- ==============================
-- Alert Display
-- ==============================
function ModernSpellAlert:ShowAlert(casterName, targetName, showTarget, icon, spellName)
    lastCasterName = (casterName and casterName ~= "" and casterName) or targetName
    lastTargetName = (targetName and targetName ~= "" and targetName) or casterName

    if self.frame and self.frame:IsVisible() and ModernSpellAlert.frame and ModernSpellAlert.frame:IsVisible() then
        if ModernSpellAlertSettings.cmdtable.args.frameSettings.args.testMode.get() then
            ModernSpellAlertSettings.cmdtable.args.frameSettings.args.testMode.set(false)
        end
    end

    self.frame.casterText:SetText(casterName)
    self.frame.spellIcon:SetTexture(customIcons[spellName] or icon or "Interface\\Icons\\INV_Misc_QuestionMark")

    if showTarget then
        self.frame.targetText:SetText(targetName)
        self.frame.targetText:Show()
        self.frame.arrowIcon:Show()
        self.frame.casterText:SetPoint("RIGHT", self.frame.arrowIcon, "LEFT", -7, 0)
        self.frame.spellIcon:SetPoint("RIGHT", self.frame.casterText, "LEFT", -10, 0)
    else
        self.frame.targetText:SetText("")
        self.frame.targetText:Hide()
        self.frame.arrowIcon:Hide()
        self.frame.casterText:SetPoint("RIGHT", self.frame.arrowIcon, "LEFT", 120, 0)
        self.frame.spellIcon:SetPoint("RIGHT", self.frame.casterText, "LEFT", -10, 0)
    end

    self.frame:SetAlpha(1)
    self.frame:Show()
    isFading = false
    self:StartFadeOut()

    if spellName then
        self:PlaySoundForSpell(spellName)
    end
end

function ModernSpellAlert:HandleAlert(profileKeys, casterGUID, targetGUID, casterName, targetName, icon, spellName)
    if targetGUID == "" then
        if profileKeys["EnabledByPlayer"] and UnitIsUnit("player", casterGUID) then
            self:ShowAlert(casterName, "", false, icon, spellName)
        elseif profileKeys["EnabledByTarget"] and UnitIsUnit("target", casterGUID) then
            self:ShowAlert(casterName, "", false, icon, spellName)
        elseif profileKeys["EnabledByFriendly"] and not UnitIsUnit("player", casterGUID) and UnitIsFriend("player", casterGUID) then
            self:ShowAlert(casterName, "", false, icon, spellName)
        elseif profileKeys["EnabledByHostile"] and UnitCanAttack("player", casterGUID) then
            self:ShowAlert(casterName, "", false, icon, spellName)
        end
    else
        if profileKeys["EnabledOnPlayer"] and targetGUID == playerGUID then
            self:ShowAlert(casterName, targetName, true, icon, spellName)
        elseif profileKeys["EnabledByPlayer"] and UnitIsUnit("player", casterGUID) then
            self:ShowAlert(casterName, targetName, true, icon, spellName)
        elseif profileKeys["EnabledOnTarget"] and UnitIsUnit("target", targetGUID) then
            self:ShowAlert(casterName, targetName, true, icon, spellName)
        elseif profileKeys["EnabledByTarget"] and UnitIsUnit("target", casterGUID) then
            self:ShowAlert(casterName, targetName, true, icon, spellName)
        elseif profileKeys["EnabledOnFriendly"] and UnitIsFriend("player", targetGUID) then
            self:ShowAlert(casterName, targetName, true, icon, spellName)
        elseif profileKeys["EnabledByFriendly"] and not UnitIsUnit("player", targetGUID) and UnitIsFriend("player", casterGUID) then
            self:ShowAlert(casterName, targetName, true, icon, spellName)
        elseif profileKeys["EnabledOnHostile"] and UnitCanAttack("player", targetGUID) then
            self:ShowAlert(casterName, targetName, true, icon, spellName)
        elseif profileKeys["EnabledByHostile"] and UnitCanAttack("player", casterGUID) then
            self:ShowAlert(casterName, targetName, true, icon, spellName)
        end
    end
end

-- ==============================
-- Event Handlers
-- ==============================
function ModernSpellAlert:OnUnitCastEvent(casterGUID, targetGUID, eventType, spellID, castDuration)
    if event == "UNIT_CASTEVENT" then
        local spellName, _, icon = SpellInfo(spellID)
        spellName = self:TrimSpellName(spellName)
        local casterName = UnitName(casterGUID) or "Unknown"
        local targetName = targetGUID and UnitName(targetGUID) or "None"

        -- DEFAULT_CHAT_FRAME:AddMessage("  Caster GUID: " .. tostring(casterName))
        -- DEFAULT_CHAT_FRAME:AddMessage("  Target GUID: " .. tostring(targetName))
        -- DEFAULT_CHAT_FRAME:AddMessage("  Event Type: " .. tostring(eventType))
        -- DEFAULT_CHAT_FRAME:AddMessage("  Spell ID: " .. tostring(spellID))
        -- DEFAULT_CHAT_FRAME:AddMessage("  Spell Name:" .. tostring(spellName) .. ".")
        -- if eventType == "CAST" then
        -- DEFAULT_CHAT_FRAME:AddMessage("  Cast Duration: " .. tostring(castDuration))
        -- end

        -- We're skipping the Magma Totem spam.
        if string.find(casterName, "^Magma Totem%s*%s*([IVXLCDM]*)$") then
            return
        end

        if eventType == "CAST" and string.find(spellName, "Trap") then
            recentTraps[spellName] = {
                casterName = casterName,
                icon = icon,
                timestamp = GetTime(),
            }
        end

        if eventType == "CAST" and totemDurations[spellName] then
            recentTotems[spellName] = {
                casterName = casterName,
                icon = icon,
                timestamp = GetTime(),
                duration = totemDurations[spellName],
            }
        end

        if spellNames[spellName] then
            local spellData = spellNames[spellName]
            if spellData and spellData.profileKeys then
                local profileKeys = spellData.profileKeys
                if eventType == "START" then
                    activeCasts[casterGUID .. spellName] = { timestamp = GetTime() }
                    self:HandleAlert(profileKeys, casterGUID, targetGUID, casterName, targetName, icon, spellName)
                elseif eventType == "CAST" or eventType == "CHANNEL" then
                    if specialAoESpells[spellName] and profileKeys["EnabledOnPlayer"] and targetGUID ~= playerGUID then
                        recentAoECasts[spellName] = { casterGUID = casterGUID, timestamp = GetTime(), icon = icon }
                    elseif targetGUID == "" then
                        recentAoECasts[spellName] = { casterGUID = casterGUID, timestamp = GetTime(), icon = icon }
                    end
                    if not activeCasts[casterGUID .. spellName] then
                        self:HandleAlert(profileKeys, casterGUID, targetGUID, casterName, targetName, icon, spellName)
                    end
                    activeCasts[casterGUID .. spellName] = nil
                elseif eventType == "FAIL" then
                    activeCasts[casterGUID .. spellName] = nil
                end
            end
        end
    elseif event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or
        event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE" or
        event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or
        event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE" or
        event == "CHAT_MSG_SPELL_SELF_DAMAGE" or
        event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or
        event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS" or
        event == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF" or
        event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" or
        event == "CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS" or
        event == "CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF" or
        event == "CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS" or
        event == "CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS" or
        event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS" or
        event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" then
        local relevant = string.find(arg1, "Trap") or string.find(arg1, "Sap") or string.find(arg1, "Distract") or
        string.find(arg1, "Totem") or string.find(arg1, "You") or string.find(arg1, "you")

        if not relevant then
            return
        end

        -- Traps are special case.
        for trapName, trapData in pairs(recentTraps) do
            local spellData = spellNames[trapName]
            if spellData and spellData.profileKeys and spellData.profileKeys["EnabledOnPlayer"] then
                if (GetTime() - trapData.timestamp) <= 60 and string.find(arg1, trapName) and (string.find(arg1, "%f[%a]You[%A,.!?]*%f[%A]") or string.find(arg1, "%f[%a]you[%A,.!?]*%f[%A]")) then
                    self:ShowAlert(trapData.casterName, UnitName("player"), true, trapData.icon, trapName)
                    recentTraps[trapName] = nil
                    break
                end
            end
        end

        -- Totems are special case.
        for totemName, totemData in pairs(recentTotems) do
            local spellData = spellNames[totemName]
            if spellData and spellData.profileKeys and spellData.profileKeys["EnabledOnPlayer"] then
                if string.find(arg1, "You are afflicted by Earthbind") then
                    local earthbindCasters = {}
                    for name, data in pairs(recentTotems) do
                        if name == "Earthbind Totem" and (GetTime() - data.timestamp) <= data.duration then
                            table.insert(earthbindCasters, data.casterName)
                        end
                    end

                    local casterName = "Unknown"
                    if table.getn(earthbindCasters) == 1 then
                        casterName = earthbindCasters[1]
                    end

                    self:ShowAlert(casterName, UnitName("player"), true,
                        "Interface\\Icons\\Spell_Nature_StrengthofEarthTotem02", totemName)
                    break
                end

                if (GetTime() - totemData.timestamp) <= totemData.duration then
                    local pattern
                    if totemName == "Magma Totem" then
                        pattern = totemName .. " %((%S+)%)'s"
                    else
                        pattern = "^" .. totemName .. "%s*[IVXLCDM]* %((%S+)%)'s"
                    end

                    local startPos, endPos, combatLogCasterName = string.find(arg1, pattern)
                    if combatLogCasterName then
                        if combatLogCasterName == totemData.casterName then
                            self:ShowAlert(combatLogCasterName, UnitName("player"), true,
                                totemData.icon or "Interface\\Icons\\INV_Misc_QuestionMark", totemName)
                            recentTotems[totemName] = nil
                            break
                        end
                    end
                end
            end
        end

        -- Distract is special case.
        local distractSpellData = spellNames["Distract"]
        if distractSpellData and distractSpellData.profileKeys and distractSpellData.profileKeys["EnabledOnPlayer"] then
            if arg1 then
                local startPos, endPos, combatLogCasterName = string.find(arg1, "(.+)%s+performs Distract on you.")
                if combatLogCasterName then
                    local playerName = UnitName("player") or "Unknown"
                    self:ShowAlert(combatLogCasterName, playerName, true, "Interface\\Icons\\Ability_Rogue_Distract",
                        "Distract")
                end
            end
        end

        -- Sap is special case.
        local sapSpellData = spellNames["Sap"]
        if sapSpellData and sapSpellData.profileKeys then
            if arg1 and string.find(arg1, "You are afflicted by Sap.") and sapSpellData.profileKeys["EnabledOnPlayer"] then
                local playerName = UnitName("player") or "Unknown"
                self:ShowAlert(playerName, "", false, "Interface\\Icons\\Ability_Sap", "Sap")
                -- elseif arg1 then
                -- local startPos, endPos, combatLogCasterName = string.find(arg1, "(.+)%s+is afflicted by Sap.")
                -- if combatLogCasterName then
                -- if sapSpellData.profileKeys["EnabledOnTarget"] or
                -- sapSpellData.profileKeys["EnabledOnFriendly"] or
                -- sapSpellData.profileKeys["EnabledOnHostile"] then
                -- self:ShowAlert(combatLogCasterName, "", false, "Interface\\Icons\\Ability_Sap", "Sap")
                -- end
                -- end
            end
        end
    end

    -- Check if combat log event matches an AoE spell in recentAoECasts
    for spellName, data in pairs(recentAoECasts) do
        local spellData = spellNames[spellName]
        if spellData and spellData.profileKeys then
            local casterName = UnitName(data.casterGUID) or "Unknown"

            if (GetTime() - data.timestamp) <= 1 and string.find(arg1, spellName) then
                if spellData.profileKeys["EnabledOnPlayer"] and (string.find(arg1, "%f[%a]You[%A,.!?]*%f[%A]") or string.find(arg1, "%f[%a]you[%A,.!?]*%f[%A]")) then
                    local playerName = UnitName("player") or "Player"
                    self:ShowAlert(casterName, playerName, true, data.icon, spellName)
                    recentAoECasts[spellName] = nil
                    break
                    -- else
                    -- local startPos, endPos, targetName = string.find(arg1, "^(%S+)")
                    -- if targetName then
                    -- local _, targetGUID = UnitExists(targetName)
                    -- if targetGUID then
                    -- if spellData.profileKeys["EnabledOnFriendly"] and UnitIsFriend("player", targetGUID) then
                    -- self:ShowAlert(casterName, targetName, true, data.icon, spellName)
                    -- recentAoECasts[spellName] = nil
                    -- break
                    -- end
                    -- if spellData.profileKeys["EnabledOnHostile"] and UnitCanAttack("player", targetGUID) then
                    -- self:ShowAlert(casterName, targetName, true, data.icon, spellName)
                    -- recentAoECasts[spellName] = nil
                    -- break
                    -- end
                    -- end
                    -- end
                end
            end
        end
    end
end
-- ==============================
-- OnUpdate Handler
-- ==============================
function ModernSpellAlert:OnUpdate()
    if not isFading then return end
    local currentTime = GetTime()
    local fadeTime = ModernSpellAlertSettings.db.profile.fadeTime or 3
    local progress = (currentTime - fadeStartTime) / fadeTime

    if progress >= 1 then
        self.frame:SetAlpha(0)
        self.frame:Hide()
        isFading = false
        self.frame:SetScript("OnUpdate", nil)
    else
        self.frame:SetAlpha(1 - progress)
    end

    if currentTime - lastCleanupTime >= 10 then
        self:CleanupTrackingTables()
        lastCleanupTime = currentTime
    end
end

-- ==============================
-- Slash Commands
-- ==============================
SLASH_MSACASTER1 = "/msacaster"
SlashCmdList["MSACASTER"] = MSACaster

SLASH_MSATARGET1 = "/msatarget"
SlashCmdList["MSATARGET"] = MSATarget

-- ==============================
-- Addon Initialization
-- ==============================
function ModernSpellAlert:OnPlayerLogin()
    if not playerGUID then
        self:FetchPlayerGUID()
    end
    self:PopulateSpellNames()
end

function ModernSpellAlert:OnInitialize()
    self:RegisterEvent("PLAYER_LOGIN", "OnPlayerLogin")
    self:RegisterEvent("UNIT_CASTEVENT", "OnUnitCastEvent")
    self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "OnUnitCastEvent")
    self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "OnUnitCastEvent")
    self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE", "OnUnitCastEvent")
    self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE", "OnUnitCastEvent")
    self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", "OnUnitCastEvent")
    self:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE", "OnUnitCastEvent")
    self:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE", "OnUnitCastEvent")
    self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS", "OnUnitCastEvent")
    self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS", "OnUnitCastEvent")
    self:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF", "OnUnitCastEvent")
    self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS", "OnUnitCastEvent")
    self:RegisterEvent("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS", "OnUnitCastEvent")
    self:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS", "OnUnitCastEvent")
    self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS", "OnUnitCastEvent")
end

function ModernSpellAlert:OnEnable()
    self.frame = self:CreateMessageFrame()
    self:UpdateFont()
    self.frame:SetPoint("CENTER", UIParent, "CENTER", ModernSpellAlertSettings.db.profile.framePosX,
        ModernSpellAlertSettings.db.profile.framePosY)
    self:Print("ModernSpellAlert enabled.")
end
