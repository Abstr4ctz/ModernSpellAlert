-- Isolate the namespace
ModernSpellAlert = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0")

-- ==============================
-- Variables
-- ==============================

local playerGUID, fadeStartTime, isFading, lastCleanupTime = nil, nil, false, 0
local activeCasts, spellNames = {}, {}

-- ==============================
-- Helper Functions
-- ==============================

-- Creates the main message frame for displaying alerts
function ModernSpellAlert:CreateMessageFrame()
    local frame = CreateFrame("Frame", "ModernSpellAlertFrame", UIParent)
    frame:SetWidth(512)
    frame:SetHeight(80)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 200)
    frame:SetFrameStrata("HIGH")

    -- Arrow icon centered in the frame
    frame.arrowIcon = frame:CreateTexture(nil, "OVERLAY")
    frame.arrowIcon:SetWidth(34)
    frame.arrowIcon:SetHeight(34)
    frame.arrowIcon:SetPoint("CENTER", frame, "CENTER", 0, 0)
    frame.arrowIcon:SetTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")

    -- Caster name to the left of the arrow icon
    frame.casterText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.casterText:SetPoint("RIGHT", frame.arrowIcon, "LEFT", -7, 0)
    frame.casterText:SetJustifyH("RIGHT")
    frame.casterText:SetFont("Fonts\\FRIZQT__.TTF", 32, "THINOUTLINE")

    -- Target name to the right of the arrow icon
    frame.targetText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.targetText:SetPoint("LEFT", frame.arrowIcon, "RIGHT", 7, 0)
    frame.targetText:SetJustifyH("LEFT")
    frame.targetText:SetFont("Fonts\\FRIZQT__.TTF", 32, "THINOUTLINE")

    -- Spell icon to the left of the caster name
    frame.spellIcon = frame:CreateTexture(nil, "OVERLAY")
    frame.spellIcon:SetWidth(64)
    frame.spellIcon:SetHeight(64)
    frame.spellIcon:SetPoint("RIGHT", frame.casterText, "LEFT", -10, 0)

    frame:SetAlpha(1)
    frame:Hide()
    return frame
end

-- Fetch player GUID
function ModernSpellAlert:FetchPlayerGUID()
    _, playerGUID = UnitExists("player")
end

-- Start the fade-out effect
function ModernSpellAlert:StartFadeOut()
    fadeStartTime = GetTime()
    isFading = true
    self.frame:SetScript("OnUpdate", function()
        self:OnUpdate()
    end)
end

-- Cleanup the active casts
function ModernSpellAlert:CleanupActiveCasts()
    local currentTime = GetTime()
    for key, data in pairs(activeCasts) do
        if currentTime - data.timestamp > 15 then
            activeCasts[key] = nil
        end
    end
end

-- Populate the spell names from the settings profile
function ModernSpellAlert:PopulateSpellNames()
    local profile = ModernSpellAlertSettings.db.profile
    spellNames = {}
	
    for spellName, settings in pairs(profile) do
        if type(settings) == "table" then
            local profileKeys = {}
            -- Store keys with true values
            for key, value in pairs(settings) do
                if value then
                    profileKeys[key] = true
                end
            end
            if next(profileKeys) then
				spellNames[spellName] = {
				profileKeys = profileKeys,
                }
            end
        end
    end
end

-- Show the alert on screen
function ModernSpellAlert:ShowAlert(casterName, targetName, showTarget, icon)
    self.frame.casterText:SetText(casterName)
    self.frame.spellIcon:SetTexture(icon or "Interface\\Icons\\INV_Misc_QuestionMark")

    if showTarget then
        -- Show target and arrow
        self.frame.targetText:SetText(targetName)
        self.frame.targetText:Show()
        self.frame.arrowIcon:Show()

        -- Restore original positions
        self.frame.casterText:SetPoint("RIGHT", self.frame.arrowIcon, "LEFT", -7, 0)
        self.frame.spellIcon:SetPoint("RIGHT", self.frame.casterText, "LEFT", -10, 0)
    else
        -- Hide target and arrow
        self.frame.targetText:SetText("")
        self.frame.targetText:Hide()
        self.frame.arrowIcon:Hide()

        -- Move caster and icon to the right for centering
        self.frame.casterText:SetPoint("RIGHT", self.frame.arrowIcon, "LEFT", 120, 0)
        self.frame.spellIcon:SetPoint("RIGHT", self.frame.casterText, "LEFT", -10, 0)
    end

    -- Show the alert frame
    self.frame:SetAlpha(1)
    self.frame:Show()
    isFading = false
    self:StartFadeOut()
end


-- ==============================
-- Event Handlers
-- ==============================

-- Handle addon events like PLAYER_LOGIN and UNIT_CASTEVENT
function ModernSpellAlert:OnUnitCastEvent(casterGUID, targetGUID, eventType, spellID, castDuration)

   if event == "UNIT_CASTEVENT" then
        local spellName, rank, icon = SpellInfo(spellID)
        local casterName = UnitName(casterGUID) or "Unknown"
        local targetName = targetGUID and UnitName(targetGUID) or "None"

        -- Process the spell if it's tracked
        if spellNames[spellName] then
            local spellData = spellNames[spellName]
            if spellData and spellData.profileKeys then
                local profileKeys = spellData.profileKeys

                if eventType == "START" or eventType == "CHANNEL" then
                    activeCasts[casterGUID .. spellName] = { timestamp = GetTime() }
                    self:HandleAlert(profileKeys, casterGUID, targetGUID, casterName, targetName, icon)

                elseif eventType == "CAST" then
                    if not activeCasts[casterGUID .. spellName] then
                        self:HandleAlert(profileKeys, casterGUID, targetGUID, casterName, targetName, icon)
                    end
                    activeCasts[casterGUID .. spellName] = nil
					
				elseif eventType == "FAIL" then
                    activeCasts[casterGUID .. spellName] = nil
                end
            end
        end
    end
end

-- ==============================
-- Alert Handling
-- ==============================

-- Handle the logic to show alerts based on the profile keys
function ModernSpellAlert:HandleAlert(profileKeys, casterGUID, targetGUID, casterName, targetName, icon)
    if targetGUID == "" then
        if profileKeys["EnabledByPlayer"] and UnitIsUnit("player", casterGUID) then
            self:ShowAlert(casterName, "", false, icon)
        elseif profileKeys["EnabledByTarget"] and UnitIsUnit("target", casterGUID) then
            self:ShowAlert(casterName, "", false, icon)
        elseif profileKeys["EnabledByFriendly"] and not UnitIsUnit("player", casterGUID) and UnitIsFriend("player", casterGUID) then
            self:ShowAlert(casterName, "", false, icon)
        elseif profileKeys["EnabledByHostile"] and UnitCanAttack("player", casterGUID) then
            self:ShowAlert(casterName, "", false, icon)
        end
    else
	
        if profileKeys["EnabledOnPlayer"] and targetGUID == playerGUID then
            self:ShowAlert(casterName, targetName, true, icon)
		elseif profileKeys["EnabledByPlayer"] and UnitIsUnit("player", casterGUID) then
            self:ShowAlert(casterName, targetName, true, icon)
        elseif profileKeys["EnabledOnTarget"] and UnitIsUnit("target", targetGUID) then
            self:ShowAlert(casterName, targetName, true, icon)
        elseif profileKeys["EnabledByTarget"] and UnitIsUnit("target", casterGUID) then
            self:ShowAlert(casterName, targetName, true, icon)
        elseif profileKeys["EnabledOnFriendly"] and UnitIsFriend("player", targetGUID) then
            self:ShowAlert(casterName, targetName, true, icon)
        elseif profileKeys["EnabledByFriendly"] and not UnitIsUnit("player", targetGUID) and UnitIsFriend("player", casterGUID) then
            self:ShowAlert(casterName, targetName, true, icon)
        elseif profileKeys["EnabledOnHostile"] and UnitCanAttack("player", targetGUID) then
            self:ShowAlert(casterName, targetName, true, icon)
        elseif profileKeys["EnabledByHostile"] and UnitCanAttack("player", casterGUID) then
            self:ShowAlert(casterName, targetName, true, icon)
        end
    end
end

-- ==============================
-- OnUpdate Handler
-- ==============================

-- Handle the OnUpdate frame updates
function ModernSpellAlert:OnUpdate()
    if not isFading then return end
    local currentTime = GetTime()
    local progress = (currentTime - fadeStartTime) / 10
    if progress >= 1 then
        self.frame:SetAlpha(0)
        self.frame:Hide()
        isFading = false
        self.frame:SetScript("OnUpdate", nil)
    else
        self.frame:SetAlpha(1 - progress)
    end
	
    -- Cleanup activeCasts table
    if currentTime - lastCleanupTime >= 10 then
        self:CleanupActiveCasts(self)
        lastCleanupTime = currentTime
    end
end

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
    self.frame = self:CreateMessageFrame()
end

function ModernSpellAlert:OnEnable()
    self.frame = self:CreateMessageFrame()
    self:Print("ModernSpellAlert enabled.")
end