local ModernSpellAlert = {}

-- Variables
local playerGUID = nil
local fadeStartTime = nil 
local isFading = false   
-- Tracked spells with cast time
local lastStartedSpell = {}
-- Tracked spells and their icons
modernSpellAlertSpellNames = {

-----------
-- DRUID --
-----------

["Abolish Poison"]        = { class = "DRUID", icon = "Interface\\Icons\\Spell_Nature_NullifyPoison", 					  profileKeys = { EnabledPlayer = "abolishPoisonEnabledPlayer", EnabledOnTarget = "abolishPoisonEnabledOnTarget", EnabledByTarget = "abolishPoisonEnabledByTarget", EnabledOnFriendly = "abolishPoisonEnabledOnFriendly", EnabledByFriendly = "abolishPoisonEnabledByFriendly", EnabledOnHostile = "abolishPoisonEnabledOnHostile", EnabledByHostile = "abolishPoisonEnabledByHostile", }},
["Barkskin"]              = { class = "DRUID", icon = "Interface\\Icons\\Spell_Nature_StoneClawTotem", CasterOnly = true, profileKeys = { EnabledPlayer = "barkskinEnabledPlayer", EnabledOnTarget = "barkskinEnabledOnTarget", EnabledByTarget = "barkskinEnabledByTarget", EnabledOnFriendly = "barkskinEnabledOnFriendly", EnabledByFriendly = "barkskinEnabledByFriendly", EnabledOnHostile = "barkskinEnabledOnHostile", EnabledByHostile = "barkskinEnabledByHostile", }},
["Dash"]                  = { class = "DRUID", icon = "Interface\\Icons\\Ability_Druid_Dash", 		   CasterOnly = true, profileKeys = { EnabledPlayer = "dashEnabledPlayer", EnabledOnTarget = "dashEnabledOnTarget", EnabledByTarget = "dashEnabledByTarget", EnabledOnFriendly = "dashEnabledOnFriendly", EnabledByFriendly = "dashEnabledByFriendly", EnabledOnHostile = "dashEnabledOnHostile", EnabledByHostile = "dashEnabledByHostile", }},
["Enrage"]                = { class = "DRUID", icon = "Interface\\Icons\\Ability_Druid_Enrage",		   CasterOnly = true, profileKeys = { EnabledPlayer = "enrageEnabledPlayer", EnabledOnTarget = "enrageEnabledOnTarget", EnabledByTarget = "enrageEnabledByTarget", EnabledOnFriendly = "enrageEnabledOnFriendly", EnabledByFriendly = "enrageEnabledByFriendly", EnabledOnHostile = "enrageEnabledOnHostile", EnabledByHostile = "enrageEnabledByHostile", }},
["Entangling Roots"]      = { class = "DRUID", icon = "Interface\\Icons\\Spell_Nature_StrangleVines",					  profileKeys = { EnabledPlayer = "entanglingRootsEnabledPlayer", EnabledOnTarget = "entanglingRootsEnabledOnTarget", EnabledByTarget = "entanglingRootsEnabledByTarget", EnabledOnFriendly = "entanglingRootsEnabledOnFriendly", EnabledByFriendly = "entanglingRootsEnabledByFriendly", EnabledOnHostile = "entanglingRootsEnabledOnHostile", EnabledByHostile = "entanglingRootsEnabledByHostile", }},
["Frenzied Regeneration"] = { class = "DRUID", icon = "Interface\\Icons\\Ability_Bullrush",			   CasterOnly = true, profileKeys = { EnabledPlayer = "frenziedRegenEnabledPlayer", EnabledOnTarget = "frenziedRegenEnabledOnTarget", EnabledByTarget = "frenziedRegenEnabledByTarget", EnabledOnFriendly = "frenziedRegenEnabledOnFriendly", EnabledByFriendly = "frenziedRegenEnabledByFriendly", EnabledOnHostile = "frenziedRegenEnabledOnHostile", EnabledByHostile = "frenziedRegenEnabledByHostile", }},
["Healing Touch"]         = { class = "DRUID", icon = "Interface\\Icons\\Spell_Nature_HealingTouch", 				      profileKeys = { EnabledPlayer = "healingTouchEnabledPlayer", EnabledOnTarget = "healingTouchEnabledOnTarget", EnabledByTarget = "healingTouchEnabledByTarget", EnabledOnFriendly = "healingTouchEnabledOnFriendly", EnabledByFriendly = "healingTouchEnabledByFriendly", EnabledOnHostile = "healingTouchEnabledOnHostile", EnabledByHostile = "healingTouchEnabledByHostile", }},
["Hibernate"]             = { class = "DRUID", icon = "Interface\\Icons\\Spell_Nature_Sleep", 						 	  profileKeys = { EnabledPlayer = "hibernateEnabledPlayer", EnabledOnTarget = "hibernateEnabledOnTarget", EnabledByTarget = "hibernateEnabledByTarget", EnabledOnFriendly = "hibernateEnabledOnFriendly", EnabledByFriendly = "hibernateEnabledByFriendly", EnabledOnHostile = "hibernateEnabledOnHostile", EnabledByHostile = "hibernateEnabledByHostile", }},
["Hurricane"]             = { class = "DRUID", icon = "Interface\\Icons\\Spell_Nature_Cyclone", 	   CasterOnly = true, profileKeys = { EnabledPlayer = "hurricaneEnabledPlayer", EnabledOnTarget = "hurricaneEnabledOnTarget", EnabledByTarget = "hurricaneEnabledByTarget", EnabledOnFriendly = "hurricaneEnabledOnFriendly", EnabledByFriendly = "hurricaneEnabledByFriendly", EnabledOnHostile = "hurricaneEnabledOnHostile", EnabledByHostile = "hurricaneEnabledByHostile", }},
["Insect Swarm"]          = { class = "DRUID", icon = "Interface\\Icons\\Spell_Nature_InsectSwarm", 				      profileKeys = { EnabledPlayer = "insectSwarmEnabledPlayer", EnabledOnTarget = "insectSwarmEnabledOnTarget", EnabledByTarget = "insectSwarmEnabledByTarget", EnabledOnFriendly = "insectSwarmEnabledOnFriendly", EnabledByFriendly = "insectSwarmEnabledByFriendly", EnabledOnHostile = "insectSwarmEnabledOnHostile", EnabledByHostile = "insectSwarmEnabledByHostile", }},
["Moonfire"]              = { class = "DRUID", icon = "Interface\\Icons\\Spell_Nature_StarFall", 					      profileKeys = { EnabledPlayer = "moonfireEnabledPlayer", EnabledOnTarget = "moonfireEnabledOnTarget", EnabledByTarget = "moonfireEnabledByTarget", EnabledOnFriendly = "moonfireEnabledOnFriendly", EnabledByFriendly = "moonfireEnabledByFriendly", EnabledOnHostile = "moonfireEnabledOnHostile", EnabledByHostile = "moonfireEnabledByHostile", }},
["Nature's Grasp"]        = { class = "DRUID", icon = "Interface\\Icons\\Spell_Nature_NaturesWrath",   CasterOnly = true, profileKeys = { EnabledPlayer = "naturesGraspEnabledPlayer", EnabledOnTarget = "naturesGraspEnabledOnTarget", EnabledByTarget = "naturesGraspEnabledByTarget", EnabledOnFriendly = "naturesGraspEnabledOnFriendly", EnabledByFriendly = "naturesGraspEnabledByFriendly", EnabledOnHostile = "naturesGraspEnabledOnHostile", EnabledByHostile = "naturesGraspEnabledByHostile", }},
["Rebirth"]               = { class = "DRUID", icon = "Interface\\Icons\\Spell_Nature_Reincarnation", 				      profileKeys = { EnabledPlayer = "rebirthEnabledPlayer", EnabledOnTarget = "rebirthEnabledOnTarget", EnabledByTarget = "rebirthEnabledByTarget", EnabledOnFriendly = "rebirthEnabledOnFriendly", EnabledByFriendly = "rebirthEnabledByFriendly", EnabledOnHostile = "rebirthEnabledOnHostile", EnabledByHostile = "rebirthEnabledByHostile", }},
["Regrowth"]              = { class = "DRUID", icon = "Interface\\Icons\\Spell_Nature_ResistNature", 				      profileKeys = { EnabledPlayer = "regrowthEnabledPlayer", EnabledOnTarget = "regrowthEnabledOnTarget", EnabledByTarget = "regrowthEnabledByTarget", EnabledOnFriendly = "regrowthEnabledOnFriendly", EnabledByFriendly = "regrowthEnabledByFriendly", EnabledOnHostile = "regrowthEnabledOnHostile", EnabledByHostile = "regrowthEnabledByHostile", }},
["Rejuvenation"]          = { class = "DRUID", icon = "Interface\\Icons\\Spell_Nature_Rejuvenation", 					  profileKeys = { EnabledPlayer = "rejuvenationEnabledPlayer", EnabledOnTarget = "rejuvenationEnabledOnTarget", EnabledByTarget = "rejuvenationEnabledByTarget", EnabledOnFriendly = "rejuvenationEnabledOnFriendly", EnabledByFriendly = "rejuvenationEnabledByFriendly", EnabledOnHostile = "rejuvenationEnabledOnHostile", EnabledByHostile = "rejuvenationEnabledByHostile", }},
["Starfire"]              = { class = "DRUID", icon = "Interface\\Icons\\Spell_Arcane_StarFire", 					 	  profileKeys = { EnabledPlayer = "starfireEnabledPlayer", EnabledOnTarget = "starfireEnabledOnTarget", EnabledByTarget = "starfireEnabledByTarget", EnabledOnFriendly = "starfireEnabledOnFriendly", EnabledByFriendly = "starfireEnabledByFriendly", EnabledOnHostile = "starfireEnabledOnHostile", EnabledByHostile = "starfireEnabledByHostile", }},
["Tranquility"]           = { class = "DRUID", icon = "Interface\\Icons\\Spell_Nature_Tranquility",	   CasterOnly = true, profileKeys = { EnabledPlayer = "tranquilityEnabledPlayer", EnabledOnTarget = "tranquilityEnabledOnTarget", EnabledByTarget = "tranquilityEnabledByTarget", EnabledOnFriendly = "tranquilityEnabledOnFriendly", EnabledByFriendly = "tranquilityEnabledByFriendly", EnabledOnHostile = "tranquilityEnabledOnHostile", EnabledByHostile = "tranquilityEnabledByHostile", }},
["Wrath"]                 = { class = "DRUID", icon = "Interface\\Icons\\Spell_Nature_AbolishMagic",					  profileKeys = { EnabledPlayer = "wrathEnabledPlayer", EnabledOnTarget = "wrathEnabledOnTarget", EnabledByTarget = "wrathEnabledByTarget", EnabledOnFriendly = "wrathEnabledOnFriendly", EnabledByFriendly = "wrathEnabledByFriendly", EnabledOnHostile = "wrathEnabledOnHostile", EnabledByHostile = "wrathEnabledByHostile", }},



------------	
-- HUNTER --
------------

["Aimed Shot"]            = { class = "HUNTER", icon = "Interface\\Icons\\Ability_SteelMelee",							        profileKeys = { EnabledPlayer = "aimedShotEnabledPlayer", EnabledOnTarget = "aimedShotEnabledOnTarget", EnabledByTarget = "aimedShotEnabledByTarget", EnabledOnFriendly = "aimedShotEnabledOnFriendly", EnabledByFriendly = "aimedShotEnabledByFriendly", EnabledOnHostile = "aimedShotEnabledOnHostile", EnabledByHostile = "aimedShotEnabledByHostile", }},
["Arcane Shot"]           = { class = "HUNTER", icon = "Interface\\Icons\\Spell_Nature_ArcaneBolt",						        profileKeys = { EnabledPlayer = "arcaneShotEnabledPlayer", EnabledOnTarget = "arcaneShotEnabledOnTarget", EnabledByTarget = "arcaneShotEnabledByTarget", EnabledOnFriendly = "arcaneShotEnabledOnFriendly", EnabledByFriendly = "arcaneShotEnabledByFriendly", EnabledOnHostile = "arcaneShotEnabledOnHostile", EnabledByHostile = "arcaneShotEnabledByHostile", }},
["Aspect of the Cheetah"] = { class = "HUNTER", icon = "Interface\\Icons\\Spell_Nature_Swiftness", 			 CasterOnly = true, profileKeys = { EnabledPlayer = "aspectCheetahEnabledPlayer", EnabledOnTarget = "aspectCheetahEnabledOnTarget", EnabledByTarget = "aspectCheetahEnabledByTarget", EnabledOnFriendly = "aspectCheetahEnabledOnFriendly", EnabledByFriendly = "aspectCheetahEnabledByFriendly", EnabledOnHostile = "aspectCheetahEnabledOnHostile", EnabledByHostile = "aspectCheetahEnabledByHostile", }},
["Aspect of the Hawk"]    = { class = "HUNTER", icon = "Interface\\Icons\\Ability_Hunter_SwiftStrike", 		 CasterOnly = true, profileKeys = { EnabledPlayer = "aspectHawkEnabledPlayer", EnabledOnTarget = "aspectHawkEnabledOnTarget", EnabledByTarget = "aspectHawkEnabledByTarget", EnabledOnFriendly = "aspectHawkEnabledOnFriendly", EnabledByFriendly = "aspectHawkEnabledByFriendly", EnabledOnHostile = "aspectHawkEnabledOnHostile", EnabledByHostile = "aspectHawkEnabledByHostile", }},
["Aspect of the Monkey"]  = { class = "HUNTER", icon = "Interface\\Icons\\Ability_Hunter_ASpectOfTheMonkey", CasterOnly = true, profileKeys = { EnabledPlayer = "aspectMonkeyEnabledPlayer", EnabledOnTarget = "aspectMonkeyEnabledOnTarget", EnabledByTarget = "aspectMonkeyEnabledByTarget", EnabledOnFriendly = "aspectMonkeyEnabledOnFriendly", EnabledByFriendly = "aspectMonkeyEnabledByFriendly", EnabledOnHostile = "aspectMonkeyEnabledOnHostile", EnabledByHostile = "aspectMonkeyEnabledByHostile", }},
["Aspect of the Pack"]    = { class = "HUNTER", icon = "Interface\\Icons\\Ability_Hunter_AspectOfThePack", 	 CasterOnly = true, profileKeys = { EnabledPlayer = "aspectPackEnabledPlayer", EnabledOnTarget = "aspectPackEnabledOnTarget", EnabledByTarget = "aspectPackEnabledByTarget", EnabledOnFriendly = "aspectPackEnabledOnFriendly", EnabledByFriendly = "aspectPackEnabledByFriendly", EnabledOnHostile = "aspectPackEnabledOnHostile", EnabledByHostile = "aspectPackEnabledByHostile", }},
["Aspect of the Wild"]    = { class = "HUNTER", icon = "Interface\\Icons\\Spell_Nature_AspectoftheWild", 	 CasterOnly = true, profileKeys = { EnabledPlayer = "aspectWildEnabledPlayer", EnabledOnTarget = "aspectWildEnabledOnTarget", EnabledByTarget = "aspectWildEnabledByTarget", EnabledOnFriendly = "aspectWildEnabledOnFriendly", EnabledByFriendly = "aspectWildEnabledByFriendly", EnabledOnHostile = "aspectWildEnabledOnHostile", EnabledByHostile = "aspectWildEnabledByHostile", }},
["Bestial Wrath"]         = { class = "HUNTER", icon = "Interface\\Icons\\Ability_Hunter_BestialWrath",		 CasterOnly = true, profileKeys = { EnabledPlayer = "bestialWrathEnabledPlayer", EnabledOnTarget = "bestialWrathEnabledOnTarget", EnabledByTarget = "bestialWrathEnabledByTarget", EnabledOnFriendly = "bestialWrathEnabledOnFriendly", EnabledByFriendly = "bestialWrathEnabledByFriendly", EnabledOnHostile = "bestialWrathEnabledOnHostile", EnabledByHostile = "bestialWrathEnabledByHostile", }},
["Concussive Shot"]       = { class = "HUNTER", icon = "Interface\\Icons\\Spell_Frost_Stun",								    profileKeys = { EnabledPlayer = "concussiveShotEnabledPlayer", EnabledOnTarget = "concussiveShotEnabledOnTarget", EnabledByTarget = "concussiveShotEnabledByTarget", EnabledOnFriendly = "concussiveShotEnabledOnFriendly", EnabledByFriendly = "concussiveShotEnabledByFriendly", EnabledOnHostile = "concussiveShotEnabledOnHostile", EnabledByHostile = "concussiveShotEnabledByHostile", }},
["Feign Death"]           = { class = "HUNTER", icon = "Interface\\Icons\\Ability_Rogue_FeignDeath", 		 CasterOnly = true, profileKeys = { EnabledPlayer = "feignDeathEnabledPlayer", EnabledOnTarget = "feignDeathEnabledOnTarget", EnabledByTarget = "feignDeathEnabledByTarget", EnabledOnFriendly = "feignDeathEnabledOnFriendly", EnabledByFriendly = "feignDeathEnabledByFriendly", EnabledOnHostile = "feignDeathEnabledOnHostile", EnabledByHostile = "feignDeathEnabledByHostile", }},
["Hunter's Mark"]         = { class = "HUNTER", icon = "Interface\\Icons\\Ability_Hunter_SniperShot",						    profileKeys = { EnabledPlayer = "huntersMarkEnabledPlayer", EnabledOnTarget = "huntersMarkEnabledOnTarget", EnabledByTarget = "huntersMarkEnabledByTarget", EnabledOnFriendly = "huntersMarkEnabledOnFriendly", EnabledByFriendly = "huntersMarkEnabledByFriendly", EnabledOnHostile = "huntersMarkEnabledOnHostile", EnabledByHostile = "huntersMarkEnabledByHostile", }},
["Multi-Shot"]            = { class = "HUNTER", icon = "Interface\\Icons\\Ability_MultiShot",								    profileKeys = { EnabledPlayer = "multiShotEnabledPlayer", EnabledOnTarget = "multiShotEnabledOnTarget", EnabledByTarget = "multiShotEnabledByTarget", EnabledOnFriendly = "multiShotEnabledOnFriendly", EnabledByFriendly = "multiShotEnabledByFriendly", EnabledOnHostile = "multiShotEnabledOnHostile", EnabledByHostile = "multiShotEnabledByHostile", }},
["Raptor Strike"]         = { class = "HUNTER", icon = "Interface\\Icons\\Ability_Hunter_RaptorStrike",					        profileKeys = { EnabledPlayer = "raptorStrikeEnabledPlayer", EnabledOnTarget = "raptorStrikeEnabledOnTarget", EnabledByTarget = "raptorStrikeEnabledByTarget", EnabledOnFriendly = "raptorStrikeEnabledOnFriendly", EnabledByFriendly = "raptorStrikeEnabledByFriendly", EnabledOnHostile = "raptorStrikeEnabledOnHostile", EnabledByHostile = "raptorStrikeEnabledByHostile", }},
["Revive Pet"]            = { class = "HUNTER", icon = "Interface\\Icons\\Spell_Nature_SpiritLink", 		 CasterOnly = true, profileKeys = { EnabledPlayer = "revivePetEnabledPlayer", EnabledOnTarget = "revivePetEnabledOnTarget", EnabledByTarget = "revivePetEnabledByTarget", EnabledOnFriendly = "revivePetEnabledOnFriendly", EnabledByFriendly = "revivePetEnabledByFriendly", EnabledOnHostile = "revivePetEnabledOnHostile", EnabledByHostile = "revivePetEnabledByHostile", }},
["Scorpid Sting"]         = { class = "HUNTER", icon = "Interface\\Icons\\Ability_Hunter_ScorpidSting",					        profileKeys = { EnabledPlayer = "scorpidStingEnabledPlayer", EnabledOnTarget = "scorpidStingEnabledOnTarget", EnabledByTarget = "scorpidStingEnabledByTarget", EnabledOnFriendly = "scorpidStingEnabledOnFriendly", EnabledByFriendly = "scorpidStingEnabledByFriendly", EnabledOnHostile = "scorpidStingEnabledOnHostile", EnabledByHostile = "scorpidStingEnabledByHostile", }},
["Serpent Sting"]         = { class = "HUNTER", icon = "Interface\\Icons\\Ability_Hunter_SerpentSting",       					profileKeys = { EnabledPlayer = "serpentStingEnabledPlayer", EnabledOnTarget = "serpentStingEnabledOnTarget", EnabledByTarget = "serpentStingEnabledByTarget", EnabledOnFriendly = "serpentStingEnabledOnFriendly", EnabledByFriendly = "serpentStingEnabledByFriendly", EnabledOnHostile = "serpentStingEnabledOnHostile", EnabledByHostile = "serpentStingEnabledByHostile" }},  
["Volley"]                = { class = "HUNTER", icon = "Interface\\Icons\\Ability_Hunter_Volley",            CasterOnly = true, profileKeys = { EnabledPlayer = "volleyEnabledPlayer", EnabledOnTarget = "volleyEnabledOnTarget", EnabledByTarget = "volleyEnabledByTarget", EnabledOnFriendly = "volleyEnabledOnFriendly", EnabledByFriendly = "volleyEnabledByFriendly", EnabledOnHostile = "volleyEnabledOnHostile", EnabledByHostile = "volleyEnabledByHostile" }},



----------
-- MAGE --
----------

["Arcane Explosion"]  = { class = "MAGE", icon = "Interface\\Icons\\Spell_Nature_WispSplode",               CasterOnly = true, profileKeys = { EnabledPlayer = "arcaneExplosionEnabledPlayer", EnabledOnTarget = "arcaneExplosionEnabledOnTarget", EnabledByTarget = "arcaneExplosionEnabledByTarget", EnabledOnFriendly = "arcaneExplosionEnabledOnFriendly", EnabledByFriendly = "arcaneExplosionEnabledByFriendly", EnabledOnHostile = "arcaneExplosionEnabledOnHostile", EnabledByHostile = "arcaneExplosionEnabledByHostile" }},  
["Arcane Missiles"]   = { class = "MAGE", icon = "Interface\\Icons\\Spell_Nature_StarFall",                            		   profileKeys = { EnabledPlayer = "arcaneMissilesEnabledPlayer", EnabledOnTarget = "arcaneMissilesEnabledOnTarget", EnabledByTarget = "arcaneMissilesEnabledByTarget", EnabledOnFriendly = "arcaneMissilesEnabledOnFriendly", EnabledByFriendly = "arcaneMissilesEnabledByFriendly", EnabledOnHostile = "arcaneMissilesEnabledOnHostile", EnabledByHostile = "arcaneMissilesEnabledByHostile" }},  
["Blast Wave"]        = { class = "MAGE", icon = "Interface\\Icons\\Spell_Holy_Excorcism_02",               CasterOnly = true, profileKeys = { EnabledPlayer = "blastWaveEnabledPlayer", EnabledOnTarget = "blastWaveEnabledOnTarget", EnabledByTarget = "blastWaveEnabledByTarget", EnabledOnFriendly = "blastWaveEnabledOnFriendly", EnabledByFriendly = "blastWaveEnabledByFriendly", EnabledOnHostile = "blastWaveEnabledOnHostile", EnabledByHostile = "blastWaveEnabledByHostile" }},  
["Blink"]             = { class = "MAGE", icon = "Interface\\Icons\\Spell_Arcane_Blink",                    CasterOnly = true, profileKeys = { EnabledPlayer = "blinkEnabledPlayer", EnabledOnTarget = "blinkEnabledOnTarget", EnabledByTarget = "blinkEnabledByTarget", EnabledOnFriendly = "blinkEnabledOnFriendly", EnabledByFriendly = "blinkEnabledByFriendly", EnabledOnHostile = "blinkEnabledOnHostile", EnabledByHostile = "blinkEnabledByHostile" }},  
["Blizzard"]          = { class = "MAGE", icon = "Interface\\Icons\\Spell_Frost_IceStorm",                  CasterOnly = true, profileKeys = { EnabledPlayer = "blizzardEnabledPlayer", EnabledOnTarget = "blizzardEnabledOnTarget", EnabledByTarget = "blizzardEnabledByTarget", EnabledOnFriendly = "blizzardEnabledOnFriendly", EnabledByFriendly = "blizzardEnabledByFriendly", EnabledOnHostile = "blizzardEnabledOnHostile", EnabledByHostile = "blizzardEnabledByHostile" }},  
["Cold Snap"]         = { class = "MAGE", icon = "Interface\\Icons\\Spell_Frost_WizardMark",                CasterOnly = true, profileKeys = { EnabledPlayer = "coldSnapEnabledPlayer", EnabledOnTarget = "coldSnapEnabledOnTarget", EnabledByTarget = "coldSnapEnabledByTarget", EnabledOnFriendly = "coldSnapEnabledOnFriendly", EnabledByFriendly = "coldSnapEnabledByFriendly", EnabledOnHostile = "coldSnapEnabledOnHostile", EnabledByHostile = "coldSnapEnabledByHostile" }},  
["Combustion"]        = { class = "MAGE", icon = "Interface\\Icons\\Spell_Fire_SealOfFire",                 CasterOnly = true, profileKeys = { EnabledPlayer = "combustionEnabledPlayer", EnabledOnTarget = "combustionEnabledOnTarget", EnabledByTarget = "combustionEnabledByTarget", EnabledOnFriendly = "combustionEnabledOnFriendly", EnabledByFriendly = "combustionEnabledByFriendly", EnabledOnHostile = "combustionEnabledOnHostile", EnabledByHostile = "combustionEnabledByHostile" }},  
["Cone of Cold"]      = { class = "MAGE", icon = "Interface\\Icons\\Spell_Frost_Glacier",                   CasterOnly = true, profileKeys = { EnabledPlayer = "coneOfColdEnabledPlayer", EnabledOnTarget = "coneOfColdEnabledOnTarget", EnabledByTarget = "coneOfColdEnabledByTarget", EnabledOnFriendly = "coneOfColdEnabledOnFriendly", EnabledByFriendly = "coneOfColdEnabledByFriendly", EnabledOnHostile = "coneOfColdEnabledOnHostile", EnabledByHostile = "coneOfColdEnabledByHostile" }},  
["Counterspell"]      = { class = "MAGE", icon = "Interface\\Icons\\Spell_Frost_IceShock",                            		   profileKeys = { EnabledPlayer = "counterspellEnabledPlayer", EnabledOnTarget = "counterspellEnabledOnTarget", EnabledByTarget = "counterspellEnabledByTarget", EnabledOnFriendly = "counterspellEnabledOnFriendly", EnabledByFriendly = "counterspellEnabledByFriendly", EnabledOnHostile = "counterspellEnabledOnHostile", EnabledByHostile = "counterspellEnabledByHostile" }},  
["Fire Ward"]         = { class = "MAGE", icon = "Interface\\Icons\\Spell_Fire_FireArmor",                  CasterOnly = true, profileKeys = { EnabledPlayer = "fireWardEnabledPlayer", EnabledOnTarget = "fireWardEnabledOnTarget", EnabledByTarget = "fireWardEnabledByTarget", EnabledOnFriendly = "fireWardEnabledOnFriendly", EnabledByFriendly = "fireWardEnabledByFriendly", EnabledOnHostile = "fireWardEnabledOnHostile", EnabledByHostile = "fireWardEnabledByHostile" }},  
["Fireball"]          = { class = "MAGE", icon = "Interface\\Icons\\Spell_Fire_FlameBolt",                             		   profileKeys = { EnabledPlayer = "fireballEnabledPlayer", EnabledOnTarget = "fireballEnabledOnTarget", EnabledByTarget = "fireballEnabledByTarget", EnabledOnFriendly = "fireballEnabledOnFriendly", EnabledByFriendly = "fireballEnabledByFriendly", EnabledOnHostile = "fireballEnabledOnHostile", EnabledByHostile = "fireballEnabledByHostile" }},  
["Flamestrike"]       = { class = "MAGE", icon = "Interface\\Icons\\Spell_Fire_SelfDestruct",				CasterOnly = true, profileKeys = { EnabledPlayer = "flamestrikeEnabledPlayer", EnabledOnTarget = "flamestrikeEnabledOnTarget", EnabledByTarget = "flamestrikeEnabledByTarget", EnabledOnFriendly = "flamestrikeEnabledOnFriendly", EnabledByFriendly = "flamestrikeEnabledByFriendly", EnabledOnHostile = "flamestrikeEnabledOnHostile", EnabledByHostile = "flamestrikeEnabledByHostile" }},  
["Frost Warding"]     = { class = "MAGE", icon = "Interface\\Icons\\Spell_Frost_FrostWard",					CasterOnly = true, profileKeys = { EnabledPlayer = "frostWardingEnabledPlayer", EnabledOnTarget = "frostWardingEnabledOnTarget", EnabledByTarget = "frostWardingEnabledByTarget", EnabledOnFriendly = "frostWardingEnabledOnFriendly", EnabledByFriendly = "frostWardingEnabledByFriendly", EnabledOnHostile = "frostWardingEnabledOnHostile", EnabledByHostile = "frostWardingEnabledByHostile" }},  
["Ice Barrier"]       = { class = "MAGE", icon = "Interface\\Icons\\Spell_Ice_Lament",						CasterOnly = true, profileKeys = { EnabledPlayer = "iceBarrierEnabledPlayer", EnabledOnTarget = "iceBarrierEnabledOnTarget", EnabledByTarget = "iceBarrierEnabledByTarget", EnabledOnFriendly = "iceBarrierEnabledOnFriendly", EnabledByFriendly = "iceBarrierEnabledByFriendly", EnabledOnHostile = "iceBarrierEnabledOnHostile", EnabledByHostile = "iceBarrierEnabledByHostile" }},  
["Ice Block"]         = { class = "MAGE", icon = "Interface\\Icons\\Spell_Frost_Frost",						CasterOnly = true, profileKeys = { EnabledPlayer = "iceBlockEnabledPlayer", EnabledOnTarget = "iceBlockEnabledOnTarget", EnabledByTarget = "iceBlockEnabledByTarget", EnabledOnFriendly = "iceBlockEnabledOnFriendly", EnabledByFriendly = "iceBlockEnabledByFriendly", EnabledOnHostile = "iceBlockEnabledOnHostile", EnabledByHostile = "iceBlockEnabledByHostile" }},  
["Mana Shield"]       = { class = "MAGE", icon = "Interface\\Icons\\Spell_Shadow_DetectLesserInvisibility", CasterOnly = true, profileKeys = { EnabledPlayer = "manaShieldEnabledPlayer", EnabledOnTarget = "manaShieldEnabledOnTarget", EnabledByTarget = "manaShieldEnabledByTarget", EnabledOnFriendly = "manaShieldEnabledOnFriendly", EnabledByFriendly = "manaShieldEnabledByFriendly", EnabledOnHostile = "manaShieldEnabledOnHostile", EnabledByHostile = "manaShieldEnabledByHostile" }},  
["Polymorph"]         = { class = "MAGE", icon = "Interface\\Icons\\Spell_Nature_Polymorph",								   profileKeys = { EnabledPlayer = "polymorphEnabledPlayer", EnabledOnTarget = "polymorphEnabledOnTarget", EnabledByTarget = "polymorphEnabledByTarget", EnabledOnFriendly = "polymorphEnabledOnFriendly", EnabledByFriendly = "polymorphEnabledByFriendly", EnabledOnHostile = "polymorphEnabledOnHostile", EnabledByHostile = "polymorphEnabledByHostile" }},  
["Pyroblast"]         = { class = "MAGE", icon = "Interface\\Icons\\Spell_Fire_Fireball02",									   profileKeys = { EnabledPlayer = "pyroblastEnabledPlayer", EnabledOnTarget = "pyroblastEnabledOnTarget", EnabledByTarget = "pyroblastEnabledByTarget", EnabledOnFriendly = "pyroblastEnabledOnFriendly", EnabledByFriendly = "pyroblastEnabledByFriendly", EnabledOnHostile = "pyroblastEnabledOnHostile", EnabledByHostile = "pyroblastEnabledByHostile" }},  
["Scorch"]            = { class = "MAGE", icon = "Interface\\Icons\\Spell_Fire_SoulBurn",									   profileKeys = { EnabledPlayer = "scorchEnabledPlayer", EnabledOnTarget = "scorchEnabledOnTarget", EnabledByTarget = "scorchEnabledByTarget", EnabledOnFriendly = "scorchEnabledOnFriendly", EnabledByFriendly = "scorchEnabledByFriendly", EnabledOnHostile = "scorchEnabledOnHostile", EnabledByHostile = "scorchEnabledByHostile" }},  
["Slow Fall"]         = { class = "MAGE", icon = "Interface\\Icons\\Spell_Magic_FeatherFall",				CasterOnly = true, profileKeys = { EnabledPlayer = "slowFallEnabledPlayer", EnabledOnTarget = "slowFallEnabledOnTarget", EnabledByTarget = "slowFallEnabledByTarget", EnabledOnFriendly = "slowFallEnabledOnFriendly", EnabledByFriendly = "slowFallEnabledByFriendly", EnabledOnHostile = "slowFallEnabledOnHostile", EnabledByHostile = "slowFallEnabledByHostile" }},  

-------------
-- PALADIN --
-------------

["Blessing of Freedom"]    = { class = "PALADIN", icon = "Interface\\Icons\\Spell_Holy_SealOfValor",         				   profileKeys = { EnabledPlayer = "blessingFreedomEnabledPlayer", EnabledOnTarget = "blessingFreedomEnabledOnTarget", EnabledByTarget  = "blessingFreedomEnabledByTarget", EnabledOnFriendly  = "blessingFreedomEnabledOnFriendly", EnabledByFriendly= "blessingFreedomEnabledByFriendly", EnabledOnHostile   = "blessingFreedomEnabledOnHostile", EnabledByHostile = "blessingFreedomEnabledByHostile" }},
["Blessing of Protection"] = { class = "PALADIN", icon = "Interface\\Icons\\Spell_Holy_SealOfProtection",    				   profileKeys = { EnabledPlayer = "blessingProtectionEnabledPlayer", EnabledOnTarget = "blessingProtectionEnabledOnTarget", EnabledByTarget  = "blessingProtectionEnabledByTarget", EnabledOnFriendly  = "blessingProtectionEnabledOnFriendly", EnabledByFriendly= "blessingProtectionEnabledByFriendly", EnabledOnHostile   = "blessingProtectionEnabledOnHostile", EnabledByHostile = "blessingProtectionEnabledByHostile" }},
["Blessing of Sacrifice"]  = { class = "PALADIN", icon = "Interface\\Icons\\Spell_Holy_SealOfSacrifice",     				   profileKeys = { EnabledPlayer = "blessingSacrificeEnabledPlayer", EnabledOnTarget = "blessingSacrificeEnabledOnTarget", EnabledByTarget  = "blessingSacrificeEnabledByTarget", EnabledOnFriendly  = "blessingSacrificeEnabledOnFriendly", EnabledByFriendly= "blessingSacrificeEnabledByFriendly", EnabledOnHostile   = "blessingSacrificeEnabledOnHostile", EnabledByHostile = "blessingSacrificeEnabledByHostile" }},
["Cleanse"]                = { class = "PALADIN", icon = "Interface\\Icons\\Spell_Holy_Purify",			  				       profileKeys = { EnabledPlayer = "cleanseEnabledPlayer", EnabledOnTarget = "cleanseEnabledOnTarget", EnabledByTarget  = "cleanseEnabledByTarget", EnabledOnFriendly  = "cleanseEnabledOnFriendly", EnabledByFriendly= "cleanseEnabledByFriendly", EnabledOnHostile   = "cleanseEnabledOnHostile", EnabledByHostile = "cleanseEnabledByHostile" }},
["Consecration"]           = { class = "PALADIN", icon = "Interface\\Icons\\Spell_Holy_InnerFire", 			CasterOnly = true, profileKeys = { EnabledPlayer = "consecrationEnabledPlayer", EnabledOnTarget = "consecrationEnabledOnTarget", EnabledByTarget  = "consecrationEnabledByTarget", EnabledOnFriendly  = "consecrationEnabledOnFriendly", EnabledByFriendly= "consecrationEnabledByFriendly", EnabledOnHostile   = "consecrationEnabledOnHostile", EnabledByHostile = "consecrationEnabledByHostile" }},
["Divine Protection"]      = { class = "PALADIN", icon = "Interface\\Icons\\Spell_Holy_Restoration", 	    CasterOnly = true, profileKeys = { EnabledPlayer = "divineProtectionEnabledPlayer", EnabledOnTarget = "divineProtectionEnabledOnTarget", EnabledByTarget  = "divineProtectionEnabledByTarget", EnabledOnFriendly  = "divineProtectionEnabledOnFriendly", EnabledByFriendly= "divineProtectionEnabledByFriendly", EnabledOnHostile   = "divineProtectionEnabledOnHostile", EnabledByHostile = "divineProtectionEnabledByHostile" }},
["Divine Shield"]          = { class = "PALADIN", icon = "Interface\\Icons\\Spell_Holy_DivineIntervention", CasterOnly = true, profileKeys = { EnabledPlayer = "divineShieldEnabledPlayer", EnabledOnTarget = "divineShieldEnabledOnTarget", EnabledByTarget  = "divineShieldEnabledByTarget", EnabledOnFriendly  = "divineShieldEnabledOnFriendly", EnabledByFriendly= "divineShieldEnabledByFriendly", EnabledOnHostile   = "divineShieldEnabledOnHostile", EnabledByHostile = "divineShieldEnabledByHostile" }},
["Flash of Light"]         = { class = "PALADIN", icon = "Interface\\Icons\\Spell_Holy_FlashHeal",         					   profileKeys = { EnabledPlayer = "flashOfLightEnabledPlayer", EnabledOnTarget = "flashOfLightEnabledOnTarget", EnabledByTarget  = "flashOfLightEnabledByTarget", EnabledOnFriendly  = "flashOfLightEnabledOnFriendly", EnabledByFriendly= "flashOfLightEnabledByFriendly", EnabledOnHostile   = "flashOfLightEnabledOnHostile", EnabledByHostile = "flashOfLightEnabledByHostile" }},
["Hammer of Justice"]      = { class = "PALADIN", icon = "Interface\\Icons\\Spell_Holy_SealOfMight",       					   profileKeys = { EnabledPlayer = "hammerOfJusticeEnabledPlayer", EnabledOnTarget = "hammerOfJusticeEnabledOnTarget", EnabledByTarget  = "hammerOfJusticeEnabledByTarget", EnabledOnFriendly  = "hammerOfJusticeEnabledOnFriendly", EnabledByFriendly= "hammerOfJusticeEnabledByFriendly", EnabledOnHostile   = "hammerOfJusticeEnabledOnHostile", EnabledByHostile = "hammerOfJusticeEnabledByHostile" }},
["Hammer of Wrath"]        = { class = "PALADIN", icon = "Interface\\Icons\\Ability_ThunderClap",          					   profileKeys = { EnabledPlayer = "hammerOfWrathEnabledPlayer", EnabledOnTarget = "hammerOfWrathEnabledOnTarget", EnabledByTarget  = "hammerOfWrathEnabledByTarget", EnabledOnFriendly  = "hammerOfWrathEnabledOnFriendly", EnabledByFriendly= "hammerOfWrathEnabledByFriendly", EnabledOnHostile   = "hammerOfWrathEnabledOnHostile", EnabledByHostile = "hammerOfWrathEnabledByHostile" }},
["Holy Light"]             = { class = "PALADIN", icon = "Interface\\Icons\\Spell_Holy_HolyBolt",          					   profileKeys = { EnabledPlayer = "holyLightEnabledPlayer", EnabledOnTarget = "holyLightEnabledOnTarget", EnabledByTarget = "holyLightEnabledByTarget", EnabledOnFriendly = "holyLightEnabledOnFriendly", EnabledByFriendly = "holyLightEnabledByFriendly", EnabledOnHostile = "holyLightEnabledOnHostile", EnabledByHostile = "holyLightEnabledByHostile" }},
["Holy Shock"]             = { class = "PALADIN", icon = "Interface\\Icons\\Spell_Holy_SearingLight",       				   profileKeys = { EnabledPlayer = "holyShockEnabledPlayer", EnabledOnTarget = "holyShockEnabledOnTarget", EnabledByTarget = "holyShockEnabledByTarget", EnabledOnFriendly = "holyShockEnabledOnFriendly", EnabledByFriendly = "holyShockEnabledByFriendly", EnabledOnHostile = "holyShockEnabledOnHostile", EnabledByHostile = "holyShockEnabledByHostile" }},
["Lay on Hands"]           = { class = "PALADIN", icon = "Interface\\Icons\\Spell_Holy_LayOnHands",       					   profileKeys = { EnabledPlayer = "layOnHandsEnabledPlayer", EnabledOnTarget = "layOnHandsEnabledOnTarget", EnabledByTarget = "layOnHandsEnabledByTarget", EnabledOnFriendly = "layOnHandsEnabledOnFriendly", EnabledByFriendly = "layOnHandsEnabledByFriendly", EnabledOnHostile = "layOnHandsEnabledOnHostile", EnabledByHostile = "layOnHandsEnabledByHostile" }},
["Purify"]                 = { class = "PALADIN", icon = "Interface\\Icons\\Spell_Holy_Purify",             				   profileKeys = { EnabledPlayer = "purifyEnabledPlayer", EnabledOnTarget = "purifyEnabledOnTarget", EnabledByTarget = "purifyEnabledByTarget", EnabledOnFriendly = "purifyEnabledOnFriendly", EnabledByFriendly = "purifyEnabledByFriendly", EnabledOnHostile = "purifyEnabledOnHostile", EnabledByHostile = "purifyEnabledByHostile" }},
["Redemption"]             = { class = "PALADIN", icon = "Interface\\Icons\\Spell_Holy_Resurrection",       				   profileKeys = { EnabledPlayer = "redemptionEnabledPlayer", EnabledOnTarget = "redemptionEnabledOnTarget", EnabledByTarget = "redemptionEnabledByTarget", EnabledOnFriendly = "redemptionEnabledOnFriendly", EnabledByFriendly = "redemptionEnabledByFriendly", EnabledOnHostile = "redemptionEnabledOnHostile", EnabledByHostile = "redemptionEnabledByHostile" }},
["Repentance"]             = { class = "PALADIN", icon = "Interface\\Icons\\Spell_Holy_PrayerOfHealing",    				   profileKeys = { EnabledPlayer = "repentanceEnabledPlayer", EnabledOnTarget = "repentanceEnabledOnTarget", EnabledByTarget = "repentanceEnabledByTarget", EnabledOnFriendly = "repentanceEnabledOnFriendly", EnabledByFriendly = "repentanceEnabledByFriendly", EnabledOnHostile = "repentanceEnabledOnHostile", EnabledByHostile = "repentanceEnabledByHostile" }},
	
------------
-- PRIEST --
------------

["Abolish Disease"]    = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Nature_NullifyDisease",   				     profileKeys = { EnabledPlayer = "abolishDiseaseEnabledPlayer", EnabledOnTarget = "abolishDiseaseEnabledOnTarget", EnabledOnFriendly = "abolishDiseaseEnabledOnFriendly", EnabledOnHostile = "abolishDiseaseEnabledOnHostile", EnabledByTarget = "abolishDiseaseEnabledByTarget", EnabledByFriendly = "abolishDiseaseEnabledByFriendly", EnabledByHostile = "abolishDiseaseEnabledByHostile" }},
["Desperate Prayer"]   = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Holy_Restoration",       CasterOnly = true, profileKeys = { EnabledPlayer = "desperatePrayerEnabledPlayer", EnabledOnTarget = "desperatePrayerEnabledOnTarget", EnabledOnFriendly = "desperatePrayerEnabledOnFriendly", EnabledOnHostile = "desperatePrayerEnabledOnHostile", EnabledByTarget = "desperatePrayerEnabledByTarget", EnabledByFriendly = "desperatePrayerEnabledByFriendly", EnabledByHostile = "desperatePrayerEnabledByHostile" }},
["Devouring Plague"]   = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Shadow_BlackPlague",     				     profileKeys = { EnabledPlayer = "devouringPlagueEnabledPlayer", EnabledOnTarget = "devouringPlagueEnabledOnTarget", EnabledOnFriendly = "devouringPlagueEnabledOnFriendly", EnabledOnHostile = "devouringPlagueEnabledOnHostile", EnabledByTarget = "devouringPlagueEnabledByTarget", EnabledByFriendly = "devouringPlagueEnabledByFriendly", EnabledByHostile = "devouringPlagueEnabledByHostile" }},
["Dispel Magic"]       = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Holy_DispelMagic",     					 profileKeys = { EnabledPlayer = "dispelMagicEnabledPlayer", EnabledOnTarget = "dispelMagicEnabledOnTarget", EnabledOnFriendly = "dispelMagicEnabledOnFriendly", EnabledOnHostile = "dispelMagicEnabledOnHostile", EnabledByTarget = "dispelMagicEnabledByTarget", EnabledByFriendly = "dispelMagicEnabledByFriendly", EnabledByHostile = "dispelMagicEnabledByHostile" }},
["Fear Ward"]          = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Holy_Excorcism",        					 profileKeys = { EnabledPlayer = "fearWardEnabledPlayer", EnabledOnTarget = "fearWardEnabledOnTarget", EnabledOnFriendly = "fearWardEnabledOnFriendly", EnabledOnHostile = "fearWardEnabledOnHostile", EnabledByTarget = "fearWardEnabledByTarget", EnabledByFriendly = "fearWardEnabledByFriendly", EnabledByHostile = "fearWardEnabledByHostile" }},
["Flash Heal"]         = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Holy_FlashHeal",         				     profileKeys = { EnabledPlayer = "flashHealEnabledPlayer", EnabledOnTarget = "flashHealEnabledOnTarget", EnabledOnFriendly = "flashHealEnabledOnFriendly", EnabledOnHostile = "flashHealEnabledOnHostile", EnabledByTarget = "flashHealEnabledByTarget", EnabledByFriendly = "flashHealEnabledByFriendly", EnabledByHostile = "flashHealEnabledByHostile" }},
["Greater Heal"]       = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Holy_GreaterHeal",     					 profileKeys = { EnabledPlayer = "greaterHealEnabledPlayer", EnabledOnTarget = "greaterHealEnabledOnTarget", EnabledOnFriendly = "greaterHealEnabledOnFriendly", EnabledOnHostile = "greaterHealEnabledOnHostile", EnabledByTarget = "greaterHealEnabledByTarget", EnabledByFriendly = "greaterHealEnabledByFriendly", EnabledByHostile = "greaterHealEnabledByHostile" }},
["Heal"]               = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Holy_Heal",               				     profileKeys = { EnabledPlayer = "healEnabledPlayer", EnabledOnTarget = "healEnabledOnTarget", EnabledOnFriendly = "healEnabledOnFriendly", EnabledOnHostile = "healEnabledOnHostile", EnabledByTarget = "healEnabledByTarget", EnabledByFriendly = "healEnabledByFriendly", EnabledByHostile = "healEnabledByHostile" }},
["Holy Fire"]          = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Holy_SearingLight",       				     profileKeys = { EnabledPlayer = "holyFireEnabledPlayer", EnabledOnTarget = "holyFireEnabledOnTarget", EnabledOnFriendly = "holyFireEnabledOnFriendly", EnabledOnHostile = "holyFireEnabledOnHostile", EnabledByTarget = "holyFireEnabledByTarget", EnabledByFriendly = "holyFireEnabledByFriendly", EnabledByHostile = "holyFireEnabledByHostile" }},
["Holy Nova"]          = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Holy_HolyNova",          CasterOnly = true, profileKeys = { EnabledPlayer = "holyNovaEnabledPlayer", EnabledOnTarget = "holyNovaEnabledOnTarget", EnabledOnFriendly = "holyNovaEnabledOnFriendly", EnabledOnHostile = "holyNovaEnabledOnHostile", EnabledByTarget = "holyNovaEnabledByTarget", EnabledByFriendly = "holyNovaEnabledByFriendly", EnabledByHostile = "holyNovaEnabledByHostile" }},
["Levitate"]           = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Holy_Leyward",           CasterOnly = true, profileKeys = { EnabledPlayer = "levitateEnabledPlayer", EnabledOnTarget = "levitateEnabledOnTarget", EnabledOnFriendly = "levitateEnabledOnFriendly", EnabledOnHostile = "levitateEnabledOnHostile", EnabledByTarget = "levitateEnabledByTarget", EnabledByFriendly = "levitateEnabledByFriendly", EnabledByHostile = "levitateEnabledByHostile" }},
["Mana Burn"]          = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Shadow_ManaBurn",         				     profileKeys = { EnabledPlayer = "manaBurnEnabledPlayer", EnabledOnTarget = "manaBurnEnabledOnTarget", EnabledOnFriendly = "manaBurnEnabledOnFriendly", EnabledOnHostile = "manaBurnEnabledOnHostile", EnabledByTarget = "manaBurnEnabledByTarget", EnabledByFriendly = "manaBurnEnabledByFriendly", EnabledByHostile = "manaBurnEnabledByHostile" }},
["Mind Blast"]         = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Shadow_UnholyFrenzy",     				     profileKeys = { EnabledPlayer = "mindBlastEnabledPlayer", EnabledOnTarget = "mindBlastEnabledOnTarget", EnabledOnFriendly = "mindBlastEnabledOnFriendly", EnabledOnHostile = "mindBlastEnabledOnHostile", EnabledByTarget = "mindBlastEnabledByTarget", EnabledByFriendly = "mindBlastEnabledByFriendly", EnabledByHostile = "mindBlastEnabledByHostile" }},
["Mind Flay"]          = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Shadow_SiphonMana",       			 	     profileKeys = { EnabledPlayer = "mindFlayEnabledPlayer", EnabledOnTarget = "mindFlayEnabledOnTarget", EnabledOnFriendly = "mindFlayEnabledOnFriendly", EnabledOnHostile = "mindFlayEnabledOnHostile", EnabledByTarget = "mindFlayEnabledByTarget", EnabledByFriendly = "mindFlayEnabledByFriendly", EnabledByHostile = "mindFlayEnabledByHostile" }},
["Power Word: Shield"] = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Holy_PowerWordShield",   				     profileKeys = { EnabledPlayer = "powerWordShieldEnabledPlayer", EnabledOnTarget = "powerWordShieldEnabledOnTarget", EnabledOnFriendly = "powerWordShieldEnabledOnFriendly", EnabledOnHostile = "powerWordShieldEnabledOnHostile", EnabledByTarget = "powerWordShieldEnabledByTarget", EnabledByFriendly = "powerWordShieldEnabledByFriendly", EnabledByHostile = "powerWordShieldEnabledByHostile" }},
["Prayer of Healing"]  = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Holy_PrayerOfHealing02", CasterOnly = true, profileKeys = { EnabledPlayer = "prayerOfHealingEnabledPlayer", EnabledOnTarget = "prayerOfHealingEnabledOnTarget", EnabledOnFriendly = "prayerOfHealingEnabledOnFriendly", EnabledOnHostile = "prayerOfHealingEnabledOnHostile", EnabledByTarget = "prayerOfHealingEnabledByTarget", EnabledByFriendly = "prayerOfHealingEnabledByFriendly", EnabledByHostile = "prayerOfHealingEnabledByHostile" }},
["Psychic Scream"]     = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Shadow_PsychicScream",   CasterOnly = true, profileKeys = { EnabledPlayer = "psychicScreamEnabledPlayer", EnabledOnTarget = "psychicScreamEnabledOnTarget", EnabledOnFriendly = "psychicScreamEnabledOnFriendly", EnabledOnHostile = "psychicScreamEnabledOnHostile", EnabledByTarget = "psychicScreamEnabledByTarget", EnabledByFriendly = "psychicScreamEnabledByFriendly", EnabledByHostile = "psychicScreamEnabledByHostile" }},
["Renew"]              = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Holy_Renew",              				     profileKeys = { EnabledPlayer = "renewEnabledPlayer", EnabledOnTarget = "renewEnabledOnTarget", EnabledOnFriendly = "renewEnabledOnFriendly", EnabledOnHostile = "renewEnabledOnHostile", EnabledByTarget = "renewEnabledByTarget", EnabledByFriendly = "renewEnabledByFriendly", EnabledByHostile = "renewEnabledByHostile" }},
["Resurrection"]       = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Holy_Resurrection",      				     profileKeys = { EnabledPlayer = "resurrectionEnabledPlayer", EnabledOnTarget = "resurrectionEnabledOnTarget", EnabledOnFriendly = "resurrectionEnabledOnFriendly", EnabledOnHostile = "resurrectionEnabledOnHostile", EnabledByTarget = "resurrectionEnabledByTarget", EnabledByFriendly = "resurrectionEnabledByFriendly", EnabledByHostile = "resurrectionEnabledByHostile" }},
["Shadow Word: Pain"]  = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Shadow_ShadowWordPain",   			         profileKeys = { EnabledPlayer = "shadowWordPainEnabledPlayer", EnabledOnTarget = "shadowWordPainEnabledOnTarget", EnabledOnFriendly = "shadowWordPainEnabledOnFriendly", EnabledOnHostile = "shadowWordPainEnabledOnHostile", EnabledByTarget = "shadowWordPainEnabledByTarget", EnabledByFriendly = "shadowWordPainEnabledByFriendly", EnabledByHostile = "shadowWordPainEnabledByHostile" }},
["Smite"]              = { class = "PRIEST", icon = "Interface\\Icons\\Spell_Holy_HolySmite",         				     profileKeys = { EnabledPlayer = "smiteEnabledPlayer", EnabledOnTarget = "smiteEnabledOnTarget", EnabledOnFriendly = "smiteEnabledOnFriendly", EnabledOnHostile = "smiteEnabledOnHostile", EnabledByTarget = "smiteEnabledByTarget", EnabledByFriendly = "smiteEnabledByFriendly", EnabledByHostile = "smiteEnabledByHostile" }},

-----------	
-- ROGUE --
-----------

["Ambush"]              = { class = "ROGUE", icon = "Interface\\Icons\\Ability_Ambush", 							  profileKeys = { EnabledPlayer = "ambushEnabledPlayer", EnabledOnTarget = "ambushEnabledOnTarget", EnabledByTarget = "ambushEnabledByTarget", EnabledOnFriendly = "ambushEnabledOnFriendly", EnabledByFriendly = "ambushEnabledByFriendly", EnabledOnHostile = "ambushEnabledOnHostile", EnabledByHostile = "ambushEnabledByHostile" }},
["Backstab"]            = { class = "ROGUE", icon = "Interface\\Icons\\Ability_BackStab", 							  profileKeys = { EnabledPlayer = "backstabEnabledPlayer", EnabledOnTarget = "backstabEnabledOnTarget", EnabledByTarget = "backstabEnabledByTarget", EnabledOnFriendly = "backstabEnabledOnFriendly", EnabledByFriendly = "backstabEnabledByFriendly", EnabledOnHostile = "backstabEnabledOnHostile", EnabledByHostile = "backstabEnabledByHostile" }},
["Blind"]               = { class = "ROGUE", icon = "Interface\\Icons\\Spell_Shadow_MindSteal", 					  profileKeys = { EnabledPlayer = "blindEnabledPlayer", EnabledOnTarget = "blindEnabledOnTarget", EnabledByTarget = "blindEnabledByTarget", EnabledOnFriendly = "blindEnabledOnFriendly", EnabledByFriendly = "blindEnabledByFriendly", EnabledOnHostile = "blindEnabledOnHostile", EnabledByHostile = "blindEnabledByHostile" }},
["Eviscerate"]          = { class = "ROGUE", icon = "Interface\\Icons\\Ability_Rogue_Eviscerate", 					  profileKeys = { EnabledPlayer = "eviscerateEnabledPlayer", EnabledOnTarget = "eviscerateEnabledOnTarget", EnabledByTarget = "eviscerateEnabledByTarget", EnabledOnFriendly = "eviscerateEnabledOnFriendly", EnabledByFriendly = "eviscerateEnabledByFriendly", EnabledOnHostile = "eviscerateEnabledOnHostile", EnabledByHostile = "eviscerateEnabledByHostile" }},
["Expose Armor"]        = { class = "ROGUE", icon = "Interface\\Icons\\Ability_Rogue_ExposeArmor", 					  profileKeys = { EnabledPlayer = "exposeArmorEnabledPlayer", EnabledOnTarget = "exposeArmorEnabledOnTarget", EnabledByTarget = "exposeArmorEnabledByTarget", EnabledOnFriendly = "exposeArmorEnabledOnFriendly", EnabledByFriendly = "exposeArmorEnabledByFriendly", EnabledOnHostile = "exposeArmorEnabledOnHostile", EnabledByHostile = "exposeArmorEnabledByHostile" }},
["Gouge"]               = { class = "ROGUE", icon = "Interface\\Icons\\Ability_Gouge",								  profileKeys = { EnabledPlayer = "gougeEnabledPlayer", EnabledOnTarget = "gougeEnabledOnTarget", EnabledByTarget = "gougeEnabledByTarget", EnabledOnFriendly = "gougeEnabledOnFriendly", EnabledByFriendly = "gougeEnabledByFriendly", EnabledOnHostile = "gougeEnabledOnHostile", EnabledByHostile = "gougeEnabledByHostile" }},
["Kick"]                = { class = "ROGUE", icon = "Interface\\Icons\\Ability_Kick", 								  profileKeys = { EnabledPlayer = "kickEnabledPlayer", EnabledOnTarget = "kickEnabledOnTarget", EnabledByTarget = "kickEnabledByTarget", EnabledOnFriendly = "kickEnabledOnFriendly", EnabledByFriendly = "kickEnabledByFriendly", EnabledOnHostile = "kickEnabledOnHostile", EnabledByHostile = "kickEnabledByHostile" }},
["Kidney Shot"]         = { class = "ROGUE", icon = "Interface\\Icons\\Ability_Rogue_KidneyShot", 					  profileKeys = { EnabledPlayer = "kidneyShotEnabledPlayer", EnabledOnTarget = "kidneyShotEnabledOnTarget", EnabledByTarget = "kidneyShotEnabledByTarget", EnabledOnFriendly = "kidneyShotEnabledOnFriendly", EnabledByFriendly = "kidneyShotEnabledByFriendly", EnabledOnHostile = "kidneyShotEnabledOnHostile", EnabledByHostile = "kidneyShotEnabledByHostile" }},
["Mutilate"]            = { class = "ROGUE", icon = "Interface\\Icons\\Ability_Rogue_Mutilate", 					  profileKeys = { EnabledPlayer = "mutilateEnabledPlayer", EnabledOnTarget = "mutilateEnabledOnTarget", EnabledByTarget = "mutilateEnabledByTarget", EnabledOnFriendly = "mutilateEnabledOnFriendly", EnabledByFriendly = "mutilateEnabledByFriendly", EnabledOnHostile = "mutilateEnabledOnHostile", EnabledByHostile = "mutilateEnabledByHostile" }},
["Preparation"]         = { class = "ROGUE", icon = "Interface\\Icons\\Ability_Rogue_Preparation", CasterOnly = true, profileKeys = { EnabledPlayer = "preparationEnabledPlayer", EnabledOnTarget = "preparationEnabledOnTarget", EnabledByTarget = "preparationEnabledByTarget", EnabledOnFriendly = "preparationEnabledOnFriendly", EnabledByFriendly = "preparationEnabledByFriendly", EnabledOnHostile = "preparationEnabledOnHostile", EnabledByHostile = "preparationEnabledByHostile" }},
["Rupture"]             = { class = "ROGUE", icon = "Interface\\Icons\\Ability_Rogue_Rupture", 						  profileKeys = { EnabledPlayer = "ruptureEnabledPlayer", EnabledOnTarget = "ruptureEnabledOnTarget", EnabledByTarget = "ruptureEnabledByTarget", EnabledOnFriendly = "ruptureEnabledOnFriendly", EnabledByFriendly = "ruptureEnabledByFriendly", EnabledOnHostile = "ruptureEnabledOnHostile", EnabledByHostile = "ruptureEnabledByHostile" }},
["Sap"]                 = { class = "ROGUE", icon = "Interface\\Icons\\Spell_Shadow_SoulLeech", 					  profileKeys = { EnabledPlayer = "sapEnabledPlayer", EnabledOnTarget = "sapEnabledOnTarget", EnabledByTarget = "sapEnabledByTarget", EnabledOnFriendly = "sapEnabledOnFriendly", EnabledByFriendly = "sapEnabledByFriendly", EnabledOnHostile = "sapEnabledOnHostile", EnabledByHostile = "sapEnabledByHostile" }},
["Slice and Dice"]      = { class = "ROGUE", icon = "Interface\\Icons\\Ability_Rogue_SliceDice",   CasterOnly = true, profileKeys = { EnabledPlayer = "sliceAndDiceEnabledPlayer", EnabledOnTarget = "sliceAndDiceEnabledOnTarget", EnabledByTarget = "sliceAndDiceEnabledByTarget", EnabledOnFriendly = "sliceAndDiceEnabledOnFriendly", EnabledByFriendly = "sliceAndDiceEnabledByFriendly", EnabledOnHostile = "sliceAndDiceEnabledOnHostile", EnabledByHostile = "sliceAndDiceEnabledByHostile" }},
["Sprint"]              = { class = "ROGUE", icon = "Interface\\Icons\\Ability_Rogue_Sprint", 	   CasterOnly = true, profileKeys = { EnabledPlayer = "sprintEnabledPlayer", EnabledOnTarget = "sprintEnabledOnTarget", EnabledByTarget = "sprintEnabledByTarget", EnabledOnFriendly = "sprintEnabledOnFriendly", EnabledByFriendly = "sprintEnabledByFriendly", EnabledOnHostile = "sprintEnabledOnHostile", EnabledByHostile = "sprintEnabledByHostile" }},
["Stealth"]             = { class = "ROGUE", icon = "Interface\\Icons\\Ability_Stealth", 		   CasterOnly = true, profileKeys = { EnabledPlayer = "stealthEnabledPlayer", EnabledOnTarget = "stealthEnabledOnTarget", EnabledByTarget = "stealthEnabledByTarget", EnabledOnFriendly = "stealthEnabledOnFriendly", EnabledByFriendly = "stealthEnabledByFriendly", EnabledOnHostile = "stealthEnabledOnHostile", EnabledByHostile = "stealthEnabledByHostile" }},
["Vanish"]              = { class = "ROGUE", icon = "Interface\\Icons\\Ability_Vanish", 		   CasterOnly = true, profileKeys = { EnabledPlayer = "vanishEnabledPlayer", EnabledOnTarget = "vanishEnabledOnTarget", EnabledByTarget = "vanishEnabledByTarget", EnabledOnFriendly = "vanishEnabledOnFriendly", EnabledByFriendly = "vanishEnabledByFriendly", EnabledOnHostile = "vanishEnabledOnHostile", EnabledByHostile = "vanishEnabledByHostile" }},



------------
-- SHAMAN --
------------

["Ancestral Spirit"]       = { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Nature_Regenerate",                                 profileKeys = { EnabledPlayer = "ancestralSpiritEnabledPlayer", EnabledOnTarget = "ancestralSpiritEnabledOnTarget", EnabledByTarget = "ancestralSpiritEnabledByTarget", EnabledOnFriendly = "ancestralSpiritEnabledOnFriendly", EnabledByFriendly = "ancestralSpiritEnabledByFriendly", EnabledOnHostile = "ancestralSpiritEnabledOnHostile", EnabledByHostile = "ancestralSpiritEnabledByHostile" }},
["Chain Heal"]             = { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Nature_HealingWaveGreater",                         profileKeys = { EnabledPlayer = "chainHealEnabledPlayer", EnabledOnTarget = "chainHealEnabledOnTarget", EnabledByTarget = "chainHealEnabledByTarget", EnabledOnFriendly = "chainHealEnabledOnFriendly", EnabledByFriendly = "chainHealEnabledByFriendly", EnabledOnHostile = "chainHealEnabledOnHostile", EnabledByHostile = "chainHealEnabledByHostile" }},
["Chain Lightning"]        = { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Nature_ChainLightning",                             profileKeys = { EnabledPlayer = "chainLightningEnabledPlayer", EnabledOnTarget = "chainLightningEnabledOnTarget", EnabledByTarget = "chainLightningEnabledByTarget", EnabledOnFriendly = "chainLightningEnabledOnFriendly", EnabledByFriendly = "chainLightningEnabledByFriendly", EnabledOnHostile = "chainLightningEnabledOnHostile", EnabledByHostile = "chainLightningEnabledByHostile" }},
["Cure Disease"]           = { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Nature_RemoveDisease",                              profileKeys = { EnabledPlayer = "cureDiseaseEnabledPlayer", EnabledOnTarget = "cureDiseaseEnabledOnTarget", EnabledByTarget = "cureDiseaseEnabledByTarget", EnabledOnFriendly = "cureDiseaseEnabledOnFriendly", EnabledByFriendly = "cureDiseaseEnabledByFriendly", EnabledOnHostile = "cureDiseaseEnabledOnHostile", EnabledByHostile = "cureDiseaseEnabledByHostile" }},
["Cure Poison"]            = { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Nature_NullifyPoison",                              profileKeys = { EnabledPlayer = "curePoisonEnabledPlayer", EnabledOnTarget = "curePoisonEnabledOnTarget", EnabledByTarget = "curePoisonEnabledByTarget", EnabledOnFriendly = "curePoisonEnabledOnFriendly", EnabledByFriendly = "curePoisonEnabledByFriendly", EnabledOnHostile = "curePoisonEnabledOnHostile", EnabledByHostile = "curePoisonEnabledByHostile" }},
["Earth Shock"]            = { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Nature_EarthShock",                                 profileKeys = { EnabledPlayer = "earthShockEnabledPlayer", EnabledOnTarget = "earthShockEnabledOnTarget", EnabledByTarget = "earthShockEnabledByTarget", EnabledOnFriendly = "earthShockEnabledOnFriendly", EnabledByFriendly = "earthShockEnabledByFriendly", EnabledOnHostile = "earthShockEnabledOnHostile", EnabledByHostile = "earthShockEnabledByHostile" }},
["Earthbind Totem"]        = { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Nature_StrengthOfEarthTotem02",  CasterOnly = true, profileKeys = { EnabledPlayer = "earthbindTotemEnabledPlayer", EnabledOnTarget = "earthbindTotemEnabledOnTarget", EnabledByTarget = "earthbindTotemEnabledByTarget", EnabledOnFriendly = "earthbindTotemEnabledOnFriendly", EnabledByFriendly = "earthbindTotemEnabledByFriendly", EnabledOnHostile = "earthbindTotemEnabledOnHostile", EnabledByHostile = "earthbindTotemEnabledByHostile" }},
["Fire Nova Totem"]        = { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Fire_SealOfFire",                CasterOnly = true, profileKeys = { EnabledPlayer = "fireNovaTotemEnabledPlayer", EnabledOnTarget = "fireNovaTotemEnabledOnTarget", EnabledByTarget = "fireNovaTotemEnabledByTarget", EnabledOnFriendly = "fireNovaTotemEnabledOnFriendly", EnabledByFriendly = "fireNovaTotemEnabledByFriendly", EnabledOnHostile = "fireNovaTotemEnabledOnHostile", EnabledByHostile = "fireNovaTotemEnabledByHostile" }},
["Fire Resistance Totem"]  = { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Fire_ResistanceTotem",           CasterOnly = true, profileKeys = { EnabledPlayer = "fireResistanceTotemEnabledPlayer", EnabledOnTarget = "fireResistanceTotemEnabledOnTarget", EnabledByTarget = "fireResistanceTotemEnabledByTarget", EnabledOnFriendly = "fireResistanceTotemEnabledOnFriendly", EnabledByFriendly = "fireResistanceTotemEnabledByFriendly", EnabledOnHostile = "fireResistanceTotemEnabledOnHostile", EnabledByHostile = "fireResistanceTotemEnabledByHostile" }},
["Flame Shock"]            = { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Fire_FlameShock",                                   profileKeys = { EnabledPlayer = "flameShockEnabledPlayer", EnabledOnTarget = "flameShockEnabledOnTarget", EnabledByTarget = "flameShockEnabledByTarget", EnabledOnFriendly = "flameShockEnabledOnFriendly", EnabledByFriendly = "flameShockEnabledByFriendly", EnabledOnHostile = "flameShockEnabledOnHostile", EnabledByHostile = "flameShockEnabledByHostile" }},
["Frost Resistance Totem"] = { class = "SHAMAN", icon = "Interface\\Icons\\Spell_FrostResistanceTotem_01",        CasterOnly = true, profileKeys = { EnabledPlayer = "frostResistanceTotemEnabledPlayer", EnabledOnTarget = "frostResistanceTotemEnabledOnTarget", EnabledByTarget = "frostResistanceTotemEnabledByTarget", EnabledOnFriendly = "frostResistanceTotemEnabledOnFriendly", EnabledByFriendly = "frostResistanceTotemEnabledByFriendly", EnabledOnHostile = "frostResistanceTotemEnabledOnHostile", EnabledByHostile = "frostResistanceTotemEnabledByHostile" }},
["Frost Shock"] 			= { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Frost_FrostShock",								 profileKeys = { EnabledPlayer = "frostShockEnabledPlayer", EnabledOnTarget = "frostShockEnabledOnTarget", EnabledByTarget = "frostShockEnabledByTarget", EnabledOnFriendly = "frostShockEnabledOnFriendly", EnabledByFriendly = "frostShockEnabledByFriendly", EnabledOnHostile = "frostShockEnabledOnHostile", EnabledByHostile = "frostShockEnabledByHostile" }},
["Grounding Totem"] 		= { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Nature_GroundingTotem",		  CasterOnly = true, profileKeys = { EnabledPlayer = "groundingTotemEnabledPlayer", EnabledOnTarget = "groundingTotemEnabledOnTarget", EnabledByTarget = "groundingTotemEnabledByTarget", EnabledOnFriendly = "groundingTotemEnabledOnFriendly", EnabledByFriendly = "groundingTotemEnabledByFriendly", EnabledOnHostile = "groundingTotemEnabledOnHostile", EnabledByHostile = "groundingTotemEnabledByHostile" }},
["Healing Wave"]			= { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Nature_MagicImmunity", 							 profileKeys = { EnabledPlayer = "healingWaveEnabledPlayer", EnabledOnTarget = "healingWaveEnabledOnTarget", EnabledByTarget = "healingWaveEnabledByTarget", EnabledOnFriendly = "healingWaveEnabledOnFriendly", EnabledByFriendly = "healingWaveEnabledByFriendly", EnabledOnHostile = "healingWaveEnabledOnHostile", EnabledByHostile = "healingWaveEnabledByHostile" }},
["Lesser Healing Wave"]     = { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Nature_HealingWaveLesser",						 profileKeys = { EnabledPlayer = "lesserHealingWaveEnabledPlayer", EnabledOnTarget = "lesserHealingWaveEnabledOnTarget", EnabledByTarget = "lesserHealingWaveEnabledByTarget", EnabledOnFriendly = "lesserHealingWaveEnabledOnFriendly", EnabledByFriendly = "lesserHealingWaveEnabledByFriendly", EnabledOnHostile = "lesserHealingWaveEnabledOnHostile", EnabledByHostile = "lesserHealingWaveEnabledByHostile" }},
["Lightning Bolt"] 			= { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Nature_Lightning",								 profileKeys = { EnabledPlayer = "lightningBoltEnabledPlayer", EnabledOnTarget = "lightningBoltEnabledOnTarget", EnabledByTarget = "lightningBoltEnabledByTarget", EnabledOnFriendly = "lightningBoltEnabledOnFriendly", EnabledByFriendly = "lightningBoltEnabledByFriendly", EnabledOnHostile = "lightningBoltEnabledOnHostile", EnabledByHostile = "lightningBoltEnabledByHostile" }},
["Magma Totem"] 			= { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Fire_SelfDestruct",			  CasterOnly = true, profileKeys = { EnabledPlayer = "magmaTotemEnabledPlayer", EnabledOnTarget = "magmaTotemEnabledOnTarget", EnabledByTarget = "magmaTotemEnabledByTarget", EnabledOnFriendly = "magmaTotemEnabledOnFriendly", EnabledByFriendly = "magmaTotemEnabledByFriendly", EnabledOnHostile = "magmaTotemEnabledOnHostile", EnabledByHostile = "magmaTotemEnabledByHostile" }},
["Nature Resistance Totem"] = { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Nature_NatureResistanceTotem",  CasterOnly = true, profileKeys = { EnabledPlayer = "natureResistanceTotemEnabledPlayer", EnabledOnTarget = "natureResistanceTotemEnabledOnTarget", EnabledByTarget = "natureResistanceTotemEnabledByTarget", EnabledOnFriendly = "natureResistanceTotemEnabledOnFriendly", EnabledByFriendly = "natureResistanceTotemEnabledByFriendly", EnabledOnHostile = "natureResistanceTotemEnabledOnHostile", EnabledByHostile = "natureResistanceTotemEnabledByHostile" }},
["Poison Cleansing Totem"]  = { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Nature_PoisonCleansingTotem",   CasterOnly = true, profileKeys = { EnabledPlayer = "poisonCleansingTotemEnabledPlayer", EnabledOnTarget = "poisonCleansingTotemEnabledOnTarget", EnabledByTarget = "poisonCleansingTotemEnabledByTarget", EnabledOnFriendly = "poisonCleansingTotemEnabledOnFriendly", EnabledByFriendly = "poisonCleansingTotemEnabledByFriendly", EnabledOnHostile = "poisonCleansingTotemEnabledOnHostile", EnabledByHostile = "poisonCleansingTotemEnabledByHostile" }},
["Purge"]				    = { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Nature_Purge",									 profileKeys = { EnabledPlayer = "purgeEnabledPlayer", EnabledOnTarget = "purgeEnabledOnTarget", EnabledByTarget = "purgeEnabledByTarget", EnabledOnFriendly = "purgeEnabledOnFriendly", EnabledByFriendly = "purgeEnabledByFriendly", EnabledOnHostile = "purgeEnabledOnHostile", EnabledByHostile = "purgeEnabledByHostile" }},
["Reincarnation"]		    = { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Nature_Reincarnation",		  CasterOnly = true, profileKeys = { EnabledPlayer = "reincarnationEnabledPlayer", EnabledOnTarget = "reincarnationEnabledOnTarget", EnabledByTarget = "reincarnationEnabledByTarget", EnabledOnFriendly = "reincarnationEnabledOnFriendly", EnabledByFriendly = "reincarnationEnabledByFriendly", EnabledOnHostile = "reincarnationEnabledOnHostile", EnabledByHostile = "reincarnationEnabledByHostile" }},
["Searing Totem"] 			= { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Fire_SearingTotem",								 profileKeys = { EnabledPlayer = "searingTotemEnabledPlayer", EnabledOnTarget = "searingTotemEnabledOnTarget", EnabledByTarget = "searingTotemEnabledByTarget", EnabledOnFriendly = "searingTotemEnabledOnFriendly", EnabledByFriendly = "searingTotemEnabledByFriendly", EnabledOnHostile = "searingTotemEnabledOnHostile", EnabledByHostile = "searingTotemEnabledByHostile" }},
["Tremor Totem"] 			= { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Nature_TremorTotem",			  CasterOnly = true, profileKeys = { EnabledPlayer = "tremorTotemEnabledPlayer", EnabledOnTarget = "tremorTotemEnabledOnTarget", EnabledByTarget = "tremorTotemEnabledByTarget", EnabledOnFriendly = "tremorTotemEnabledOnFriendly", EnabledByFriendly = "tremorTotemEnabledByFriendly", EnabledOnHostile = "tremorTotemEnabledOnHostile", EnabledByHostile = "tremorTotemEnabledByHostile" }},
["Water Breathing"] 		= { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Shadow_DemonBreath",							     profileKeys = { EnabledPlayer = "waterBreathingEnabledPlayer", EnabledOnTarget = "waterBreathingEnabledOnTarget", EnabledByTarget = "waterBreathingEnabledByTarget", EnabledOnFriendly = "waterBreathingEnabledOnFriendly", EnabledByFriendly = "waterBreathingEnabledByFriendly", EnabledOnHostile = "waterBreathingEnabledOnHostile", EnabledByHostile = "waterBreathingEnabledByHostile" }},
["Windwall Totem"]		    = { class = "SHAMAN", icon = "Interface\\Icons\\Spell_Nature_EarthBind",			  CasterOnly = true, profileKeys = { EnabledPlayer = "windwallTotemEnabledPlayer", EnabledOnTarget = "windwallTotemEnabledOnTarget", EnabledByTarget = "windwallTotemEnabledByTarget", EnabledOnFriendly = "windwallTotemEnabledOnFriendly", EnabledByFriendly = "windwallTotemEnabledByFriendly", EnabledOnHostile = "windwallTotemEnabledOnHostile", EnabledByHostile = "windwallTotemEnabledByHostile" }},

-------------	
-- WARLOCK --
-------------

["Banish"]                = { class = "WARLOCK", icon = "Interface\\Icons\\Spell_Shadow_Cripple", 							profileKeys = { EnabledPlayer = "banishEnabledPlayer", EnabledOnTarget = "banishEnabledOnTarget", EnabledByTarget = "banishEnabledByTarget", EnabledOnFriendly = "banishEnabledOnFriendly", EnabledByFriendly = "banishEnabledByFriendly", EnabledOnHostile = "banishEnabledOnHostile", EnabledByHostile = "banishEnabledByHostile" }},
["Corruption"]            = { class = "WARLOCK", icon = "Interface\\Icons\\Spell_Shadow_AbominationExplosion", 				profileKeys = { EnabledPlayer = "corruptionEnabledPlayer", EnabledOnTarget = "corruptionEnabledOnTarget", EnabledByTarget = "corruptionEnabledByTarget", EnabledOnFriendly = "corruptionEnabledOnFriendly", EnabledByFriendly = "corruptionEnabledByFriendly", EnabledOnHostile = "corruptionEnabledOnHostile", EnabledByHostile = "corruptionEnabledByHostile" }},
["Curse of Agony"]        = { class = "WARLOCK", icon = "Interface\\Icons\\Spell_Shadow_CurseOfSargeras", 					profileKeys = { EnabledPlayer = "curseOfAgonyEnabledPlayer", EnabledOnTarget = "curseOfAgonyEnabledOnTarget", EnabledByTarget = "curseOfAgonyEnabledByTarget", EnabledOnFriendly = "curseOfAgonyEnabledOnFriendly", EnabledByFriendly = "curseOfAgonyEnabledByFriendly", EnabledOnHostile = "curseOfAgonyEnabledOnHostile", EnabledByHostile = "curseOfAgonyEnabledByHostile" }},
["Curse of Doom"]         = { class = "WARLOCK", icon = "Interface\\Icons\\Spell_Shadow_CurseOfDoom", 					 	profileKeys = { EnabledPlayer = "curseOfDoomEnabledPlayer", EnabledOnTarget = "curseOfDoomEnabledOnTarget", EnabledByTarget = "curseOfDoomEnabledByTarget", EnabledOnFriendly = "curseOfDoomEnabledOnFriendly", EnabledByFriendly = "curseOfDoomEnabledByFriendly", EnabledOnHostile = "curseOfDoomEnabledOnHostile", EnabledByHostile = "curseOfDoomEnabledByHostile" }},
["Curse of Recklessness"] = { class = "WARLOCK", icon = "Interface\\Icons\\Spell_Shadow_CurseOfSargeras", 					profileKeys = { EnabledPlayer = "curseOfRecklessnessEnabledPlayer", EnabledOnTarget = "curseOfRecklessnessEnabledOnTarget", EnabledByTarget = "curseOfRecklessnessEnabledByTarget", EnabledOnFriendly = "curseOfRecklessnessEnabledOnFriendly", EnabledByFriendly = "curseOfRecklessnessEnabledByFriendly", EnabledOnHostile = "curseOfRecklessnessEnabledOnHostile", EnabledByHostile = "curseOfRecklessnessEnabledByHostile" }},
["Curse of Weakness"]     = { class = "WARLOCK", icon = "Interface\\Icons\\Spell_Shadow_CurseOfWeakness", 					profileKeys = { EnabledPlayer = "curseOfWeaknessEnabledPlayer", EnabledOnTarget = "curseOfWeaknessEnabledOnTarget", EnabledByTarget = "curseOfWeaknessEnabledByTarget", EnabledOnFriendly = "curseOfWeaknessEnabledOnFriendly", EnabledByFriendly = "curseOfWeaknessEnabledByFriendly", EnabledOnHostile = "curseOfWeaknessEnabledOnHostile", EnabledByHostile = "curseOfWeaknessEnabledByHostile" }},
["Death Coil"]            = { class = "WARLOCK", icon = "Interface\\Icons\\Spell_Shadow_DeathCoil", 						profileKeys = { EnabledPlayer = "deathCoilEnabledPlayer", EnabledOnTarget = "deathCoilEnabledOnTarget", EnabledByTarget = "deathCoilEnabledByTarget", EnabledOnFriendly = "deathCoilEnabledOnFriendly", EnabledByFriendly = "deathCoilEnabledByFriendly", EnabledOnHostile = "deathCoilEnabledOnHostile", EnabledByHostile = "deathCoilEnabledByHostile" }},
["Drain Life"]            = { class = "WARLOCK", icon = "Interface\\Icons\\Spell_Shadow_LifeDrain02", 						profileKeys = { EnabledPlayer = "drainLifeEnabledPlayer", EnabledOnTarget = "drainLifeEnabledOnTarget", EnabledByTarget = "drainLifeEnabledByTarget", EnabledOnFriendly = "drainLifeEnabledOnFriendly", EnabledByFriendly = "drainLifeEnabledByFriendly", EnabledOnHostile = "drainLifeEnabledOnHostile", EnabledByHostile = "drainLifeEnabledByHostile" }},
["Drain Mana"]            = { class = "WARLOCK", icon = "Interface\\Icons\\Spell_Shadow_SiphonMana", 						profileKeys = { EnabledPlayer = "drainManaEnabledPlayer", EnabledOnTarget = "drainManaEnabledOnTarget", EnabledByTarget = "drainManaEnabledByTarget", EnabledOnFriendly = "drainManaEnabledOnFriendly", EnabledByFriendly = "drainManaEnabledByFriendly", EnabledOnHostile = "drainManaEnabledOnHostile", EnabledByHostile = "drainManaEnabledByHostile" }},
["Drain Soul"]            = { class = "WARLOCK", icon = "Interface\\Icons\\Spell_Shadow_Requiem", 							profileKeys = { EnabledPlayer = "drainSoulEnabledPlayer", EnabledOnTarget = "drainSoulEnabledOnTarget", EnabledByTarget = "drainSoulEnabledByTarget", EnabledOnFriendly = "drainSoulEnabledOnFriendly", EnabledByFriendly = "drainSoulEnabledByFriendly", EnabledOnHostile = "drainSoulEnabledOnHostile", EnabledByHostile = "drainSoulEnabledByHostile" }},
["Fear"]                  = { class = "WARLOCK", icon = "Interface\\Icons\\Spell_Shadow_Possession", 						profileKeys = { EnabledPlayer = "fearEnabledPlayer", EnabledOnTarget = "fearEnabledOnTarget", EnabledByTarget = "fearEnabledByTarget", EnabledOnFriendly = "fearEnabledOnFriendly", EnabledByFriendly = "fearEnabledByFriendly", EnabledOnHostile = "fearEnabledOnHostile", EnabledByHostile = "fearEnabledByHostile" }},
["Fel Domination"]        = { class = "WARLOCK", icon = "Interface\\Icons\\Spell_Shadow_SummonFelGuard", CasterOnly = true, profileKeys = { EnabledPlayer = "felDominationEnabledPlayer", EnabledOnTarget = "felDominationEnabledOnTarget", EnabledByTarget = "felDominationEnabledByTarget", EnabledOnFriendly = "felDominationEnabledOnFriendly", EnabledByFriendly = "felDominationEnabledByFriendly", EnabledOnHostile = "felDominationEnabledOnHostile", EnabledByHostile = "felDominationEnabledByHostile" }},
["Health Funnel"]         = { class = "WARLOCK", icon = "Interface\\Icons\\Spell_Shadow_LifeDrain", 						profileKeys = { EnabledPlayer = "healthFunnelEnabledPlayer", EnabledOnTarget = "healthFunnelEnabledOnTarget", EnabledByTarget = "healthFunnelEnabledByTarget", EnabledOnFriendly = "healthFunnelEnabledOnFriendly", EnabledByFriendly = "healthFunnelEnabledByFriendly", EnabledOnHostile = "healthFunnelEnabledOnHostile", EnabledByHostile = "healthFunnelEnabledByHostile" }},
["Hellfire"]              = { class = "WARLOCK", icon = "Interface\\Icons\\Spell_Fire_SelfDestruct", 	 CasterOnly = true, profileKeys = { EnabledPlayer = "hellfireEnabledPlayer", EnabledOnTarget = "hellfireEnabledOnTarget", EnabledByTarget = "hellfireEnabledByTarget", EnabledOnFriendly = "hellfireEnabledOnFriendly", EnabledByFriendly = "hellfireEnabledByFriendly", EnabledOnHostile = "hellfireEnabledOnHostile", EnabledByHostile = "hellfireEnabledByHostile" }},
["Life Tap"]              = { class = "WARLOCK", icon = "Interface\\Icons\\Spell_Shadow_LifeTap", 		 CasterOnly = true, profileKeys = { EnabledPlayer = "lifeTapEnabledPlayer", EnabledOnTarget = "lifeTapEnabledOnTarget", EnabledByTarget = "lifeTapEnabledByTarget", EnabledOnFriendly = "lifeTapEnabledOnFriendly", EnabledByFriendly = "lifeTapEnabledByFriendly", EnabledOnHostile = "lifeTapEnabledOnHostile", EnabledByHostile = "lifeTapEnabledByHostile" }},
["Shadow Bolt"]           = { class = "WARLOCK", icon = "Interface\\Icons\\Spell_Shadow_ShadowBolt",						profileKeys = { EnabledPlayer = "shadowBoltEnabledPlayer", EnabledOnTarget = "shadowBoltEnabledOnTarget", EnabledByTarget = "shadowBoltEnabledByTarget", EnabledOnFriendly = "shadowBoltEnabledOnFriendly", EnabledByFriendly = "shadowBoltEnabledByFriendly", EnabledOnHostile = "shadowBoltEnabledOnHostile", EnabledByHostile = "shadowBoltEnabledByHostile" }},
["Shadowburn"]            = { class = "WARLOCK", icon = "Interface\\Icons\\Spell_Shadow_Shadowburn",						profileKeys = { EnabledPlayer = "shadowburnEnabledPlayer", EnabledOnTarget = "shadowburnEnabledOnTarget", EnabledByTarget = "shadowburnEnabledByTarget", EnabledOnFriendly = "shadowburnEnabledOnFriendly", EnabledByFriendly = "shadowburnEnabledByFriendly", EnabledOnHostile = "shadowburnEnabledOnHostile", EnabledByHostile = "shadowburnEnabledByHostile" }},
["Soul Link"]             = { class = "WARLOCK", icon = "Interface\\Icons\\Spell_Shadow_SoulLink", 		 CasterOnly = true, profileKeys = { EnabledPlayer = "soulLinkEnabledPlayer", EnabledOnTarget = "soulLinkEnabledOnTarget", EnabledByTarget = "soulLinkEnabledByTarget", EnabledOnFriendly = "soulLinkEnabledOnFriendly", EnabledByFriendly = "soulLinkEnabledByFriendly", EnabledOnHostile = "soulLinkEnabledOnHostile", EnabledByHostile = "soulLinkEnabledByHostile" }},

-------------
-- WARRIOR --
-------------

["Battle Shout"]        = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_Warrior_BattleShout",     CasterOnly = true, profileKeys = { EnabledPlayer = "battleShoutEnabledPlayer", EnabledOnTarget = "battleShoutEnabledOnTarget", EnabledByTarget = "battleShoutEnabledByTarget", EnabledOnFriendly = "battleShoutEnabledOnFriendly", EnabledByFriendly = "battleShoutEnabledByFriendly", EnabledOnHostile = "battleShoutEnabledOnHostile", EnabledByHostile = "battleShoutEnabledByHostile" }},
["Charge"]              = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_Warrior_Charge",                             profileKeys = { EnabledPlayer = "chargeEnabledPlayer", EnabledOnTarget = "chargeEnabledOnTarget", EnabledByTarget = "chargeEnabledByTarget", EnabledOnFriendly = "chargeEnabledOnFriendly", EnabledByFriendly = "chargeEnabledByFriendly", EnabledOnHostile = "chargeEnabledOnHostile", EnabledByHostile = "chargeEnabledByHostile" }},
["Cleave"]              = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_Warrior_Cleave",                             profileKeys = { EnabledPlayer = "cleaveEnabledPlayer", EnabledOnTarget = "cleaveEnabledOnTarget", EnabledByTarget = "cleaveEnabledByTarget", EnabledOnFriendly = "cleaveEnabledOnFriendly", EnabledByFriendly = "cleaveEnabledByFriendly", EnabledOnHostile = "cleaveEnabledOnHostile", EnabledByHostile = "cleaveEnabledByHostile" }},
["Death Wish"]          = { class = "WARRIOR", icon = "Interface\\Icons\\Spell_Shadow_DeathPact",          CasterOnly = true, profileKeys = { EnabledPlayer = "deathWishEnabledPlayer", EnabledOnTarget = "deathWishEnabledOnTarget", EnabledByTarget = "deathWishEnabledByTarget", EnabledOnFriendly = "deathWishEnabledOnFriendly", EnabledByFriendly = "deathWishEnabledByFriendly", EnabledOnHostile = "deathWishEnabledOnHostile", EnabledByHostile = "deathWishEnabledByHostile" }},
["Demoralizing Shout"]  = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_Warrior_WarCry",          CasterOnly = true, profileKeys = { EnabledPlayer = "demoralizingShoutEnabledPlayer", EnabledOnTarget = "demoralizingShoutEnabledOnTarget", EnabledByTarget = "demoralizingShoutEnabledByTarget", EnabledOnFriendly = "demoralizingShoutEnabledOnFriendly", EnabledByFriendly = "demoralizingShoutEnabledByFriendly", EnabledOnHostile = "demoralizingShoutEnabledOnHostile", EnabledByHostile = "demoralizingShoutEnabledByHostile" }},
["Execute"]             = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_Warrior_Execute",                            profileKeys = { EnabledPlayer = "executeEnabledPlayer", EnabledOnTarget = "executeEnabledOnTarget", EnabledByTarget = "executeEnabledByTarget", EnabledOnFriendly = "executeEnabledOnFriendly", EnabledByFriendly = "executeEnabledByFriendly", EnabledOnHostile = "executeEnabledOnHostile", EnabledByHostile = "executeEnabledByHostile" }},
["Hamstring"]           = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_ShockWave",                                  profileKeys = { EnabledPlayer = "hamstringEnabledPlayer", EnabledOnTarget = "hamstringEnabledOnTarget", EnabledByTarget = "hamstringEnabledByTarget", EnabledOnFriendly = "hamstringEnabledOnFriendly", EnabledByFriendly = "hamstringEnabledByFriendly", EnabledOnHostile = "hamstringEnabledOnHostile", EnabledByHostile = "hamstringEnabledByHostile" }},
["Heroic Strike"]       = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_Whirlwind",          	   CasterOnly = true, profileKeys = { EnabledPlayer = "heroicStrikeEnabledPlayer", EnabledOnTarget = "heroicStrikeEnabledOnTarget", EnabledByTarget = "heroicStrikeEnabledByTarget", EnabledOnFriendly = "heroicStrikeEnabledOnFriendly", EnabledByFriendly = "heroicStrikeEnabledByFriendly", EnabledOnHostile = "heroicStrikeEnabledOnHostile", EnabledByHostile = "heroicStrikeEnabledByHostile" }},
["Intercept"]           = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_Warrior_Intercept",                          profileKeys = { EnabledPlayer = "interceptEnabledPlayer", EnabledOnTarget = "interceptEnabledOnTarget", EnabledByTarget = "interceptEnabledByTarget", EnabledOnFriendly = "interceptEnabledOnFriendly", EnabledByFriendly = "interceptEnabledByFriendly", EnabledOnHostile = "interceptEnabledOnHostile", EnabledByHostile = "interceptEnabledByHostile" }},
["Intimidating Shout"]  = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_GolemThunderClap",        CasterOnly = true, profileKeys = { EnabledPlayer = "intimidatingShoutEnabledPlayer", EnabledOnTarget = "intimidatingShoutEnabledOnTarget", EnabledByTarget = "intimidatingShoutEnabledByTarget", EnabledOnFriendly = "intimidatingShoutEnabledOnFriendly", EnabledByFriendly = "intimidatingShoutEnabledByFriendly", EnabledOnHostile = "intimidatingShoutEnabledOnHostile", EnabledByHostile = "intimidatingShoutEnabledByHostile" }},
["Last Stand"]          = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_Racial_Avatar",       	   CasterOnly = true, profileKeys = { EnabledPlayer = "lastStandEnabledPlayer", EnabledOnTarget = "lastStandEnabledOnTarget", EnabledByTarget = "lastStandEnabledByTarget", EnabledOnFriendly = "lastStandEnabledOnFriendly", EnabledByFriendly = "lastStandEnabledByFriendly", EnabledOnHostile = "lastStandEnabledOnHostile", EnabledByHostile = "lastStandEnabledByHostile" }},
["Mortal Strike"]       = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_Warrior_Slam",                               profileKeys = { EnabledPlayer = "mortalStrikeEnabledPlayer", EnabledOnTarget = "mortalStrikeEnabledOnTarget", EnabledByTarget = "mortalStrikeEnabledByTarget", EnabledOnFriendly = "mortalStrikeEnabledOnFriendly", EnabledByFriendly = "mortalStrikeEnabledByFriendly", EnabledOnHostile = "mortalStrikeEnabledOnHostile", EnabledByHostile = "mortalStrikeEnabledByHostile" }},
["Overpower"]           = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_Warrior_Overpower",                          profileKeys = { EnabledPlayer = "overpowerEnabledPlayer", EnabledOnTarget = "overpowerEnabledOnTarget", EnabledByTarget = "overpowerEnabledByTarget", EnabledOnFriendly = "overpowerEnabledOnFriendly", EnabledByFriendly = "overpowerEnabledByFriendly", EnabledOnHostile = "overpowerEnabledOnHostile", EnabledByHostile = "overpowerEnabledByHostile" }},
["Pummel"]              = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_Warrior_Pummel",                             profileKeys = { EnabledPlayer = "pummelEnabledPlayer", EnabledOnTarget = "pummelEnabledOnTarget", EnabledByTarget = "pummelEnabledByTarget", EnabledOnFriendly = "pummelEnabledOnFriendly", EnabledByFriendly = "pummelEnabledByFriendly", EnabledOnHostile = "pummelEnabledOnHostile", EnabledByHostile = "pummelEnabledByHostile" }},
["Revenge"]             = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_Warrior_Revenge",                            profileKeys = { EnabledPlayer = "revengeEnabledPlayer", EnabledOnTarget = "revengeEnabledOnTarget", EnabledByTarget = "revengeEnabledByTarget", EnabledOnFriendly = "revengeEnabledOnFriendly", EnabledByFriendly = "revengeEnabledByFriendly", EnabledOnHostile = "revengeEnabledOnHostile", EnabledByHostile = "revengeEnabledByHostile" }},
["Shield Bash"]         = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_Warrior_ShieldBash",                         profileKeys = { EnabledPlayer = "shieldBashEnabledPlayer", EnabledOnTarget = "shieldBashEnabledOnTarget", EnabledByTarget = "shieldBashEnabledByTarget", EnabledOnFriendly = "shieldBashEnabledOnFriendly", EnabledByFriendly = "shieldBashEnabledByFriendly", EnabledOnHostile = "shieldBashEnabledOnHostile", EnabledByHostile = "shieldBashEnabledByHostile" }},
["Shield Block"]        = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_Defend",            	   CasterOnly = true, profileKeys = { EnabledPlayer = "shieldBlockEnabledPlayer", EnabledOnTarget = "shieldBlockEnabledOnTarget", EnabledByTarget = "shieldBlockEnabledByTarget", EnabledOnFriendly = "shieldBlockEnabledOnFriendly", EnabledByFriendly = "shieldBlockEnabledByFriendly", EnabledOnHostile = "shieldBlockEnabledOnHostile", EnabledByHostile = "shieldBlockEnabledByHostile" }},
["Shield Slam"]         = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_Warrior_ShieldSlam",                         profileKeys = { EnabledPlayer = "shieldSlamEnabledPlayer", EnabledOnTarget = "shieldSlamEnabledOnTarget", EnabledByTarget = "shieldSlamEnabledByTarget", EnabledOnFriendly = "shieldSlamEnabledOnFriendly", EnabledByFriendly = "shieldSlamEnabledByFriendly", EnabledOnHostile = "shieldSlamEnabledOnHostile", EnabledByHostile = "shieldSlamEnabledByHostile" }},
["Slam"]                = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_Warrior_Slam",                               profileKeys = { EnabledPlayer = "slamEnabledPlayer", EnabledOnTarget = "slamEnabledOnTarget", EnabledByTarget = "slamEnabledByTarget", EnabledOnFriendly = "slamEnabledOnFriendly", EnabledByFriendly = "slamEnabledByFriendly", EnabledOnHostile = "slamEnabledOnHostile", EnabledByHostile = "slamEnabledByHostile" }},
["Sweeping Strikes"]    = { class = "WARRIOR", icon = "Interface\\Icons\\Ability_Warrior_SweepingStrikes", CasterOnly = true, profileKeys = { EnabledPlayer = "sweepingStrikesEnabledPlayer", EnabledOnTarget = "sweepingStrikesEnabledOnTarget", EnabledByTarget = "sweepingStrikesEnabledByTarget", EnabledOnFriendly = "sweepingStrikesEnabledOnFriendly", EnabledByFriendly = "sweepingStrikesEnabledByFriendly", EnabledOnHostile = "sweepingStrikesEnabledOnHostile", EnabledByHostile = "sweepingStrikesEnabledByHostile" }},
["Taunt"]               = { class = "WARRIOR", icon = "Interface\\Icons\\Spell_Nature_Reincarnation",                         profileKeys = { EnabledPlayer = "tauntEnabledPlayer", EnabledOnTarget = "tauntEnabledOnTarget", EnabledByTarget = "tauntEnabledByTarget", EnabledOnFriendly = "tauntEnabledOnFriendly", EnabledByFriendly = "tauntEnabledByFriendly", EnabledOnHostile = "tauntEnabledOnHostile", EnabledByHostile = "tauntEnabledByHostile" }},
["Thunder Clap"]        = { class = "WARRIOR", icon = "Interface\\Icons\\Spell_Nature_ThunderClap",                           profileKeys = { EnabledPlayer = "thunderClapEnabledPlayer", EnabledOnTarget = "thunderClapEnabledOnTarget", EnabledByTarget = "thunderClapEnabledByTarget", EnabledOnFriendly = "thunderClapEnabledOnFriendly", EnabledByFriendly = "thunderClapEnabledByFriendly", EnabledOnHostile = "thunderClapEnabledOnHostile", EnabledByHostile = "thunderClapEnabledByHostile" }},
}

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
            FetchPlayerGUID()
        end
        print("ModernSpellAlert initialized.")

    elseif event == "UNIT_CASTEVENT" then
        local casterGUID = arg1  -- Caster's GUID
        local targetGUID = arg2  -- Target's GUID
        local eventType = arg3   -- Event type (START, CAST, FAIL, MAINHAND, OFFHAND)
        local spellID = arg4     -- Spell ID
        local spellName = SpellInfo(spellID)

        -- Fetch caster and target names
        local casterName = UnitName(casterGUID) or "Unknown"
        local targetName = targetGUID and UnitName(targetGUID) or "None"

		if modernSpellAlertSpellNames[spellName] then
		
			local spellData = modernSpellAlertSpellNames[spellName]
            local spellIcon = spellData.icon
            local profile = ModernSpellAlertSettings.db.profile
			
			if eventType == "START" then
                lastStartedSpell[casterGUID] = spellName
            end
			
			if eventType == "CAST" and lastStartedSpell[casterGUID] == spellName then
                lastStartedSpell[casterGUID] = nil
                return
            end
			
			if eventType == "FAIL" then
                lastStartedSpell[casterGUID] = nil
            end

			if spellData.CasterOnly then
				if (profile[spellData.profileKeys.EnabledByTarget] or false) and UnitIsUnit("target", casterGUID) then
					print("event fired 1")
                    ModernSpellAlert.frame.casterText:SetText(casterName)
					ModernSpellAlert.frame.targetText:SetText("")
					ModernSpellAlert.frame.targetText:Hide()
					ModernSpellAlert.frame.arrowIcon:Hide()
                    ModernSpellAlert.frame.spellIcon:SetTexture(spellIcon or "Interface\\Icons\\INV_Misc_QuestionMark")
                    ModernSpellAlert.frame:SetAlpha(1)
                    ModernSpellAlert.frame:Show()
                    isFading = false
                    StartFadeOut()
                    return
                end
				
				if (profile[spellData.profileKeys.EnabledByFriendly] or false) then
					if not UnitIsUnit("player", casterGUID) and UnitIsFriend("player", casterGUID) then
						print("event fired 2")
						ModernSpellAlert.frame.casterText:SetText(casterName)
						ModernSpellAlert.frame.targetText:SetText("")
						ModernSpellAlert.frame.targetText:Hide()
						ModernSpellAlert.frame.arrowIcon:Hide()
						ModernSpellAlert.frame.spellIcon:SetTexture(spellIcon or "Interface\\Icons\\INV_Misc_QuestionMark")
						ModernSpellAlert.frame:SetAlpha(1)
						ModernSpellAlert.frame:Show()
						isFading = false
						StartFadeOut()
						return
					end
				end

				if (profile[spellData.profileKeys.EnabledByHostile] or false) and UnitCanAttack("player", casterGUID) then
					print("event fired 3")
					ModernSpellAlert.frame.casterText:SetText(casterName)
					ModernSpellAlert.frame.targetText:SetText("")
					ModernSpellAlert.frame.targetText:Hide()
					ModernSpellAlert.frame.arrowIcon:Hide()
					ModernSpellAlert.frame.spellIcon:SetTexture(spellIcon or "Interface\\Icons\\INV_Misc_QuestionMark")
					ModernSpellAlert.frame:SetAlpha(1)
					ModernSpellAlert.frame:Show()
					isFading = false
					StartFadeOut()
					return
				end
			else
			
				if targetGUID then
					if (profile[spellData.profileKeys.EnabledPlayer] or false) and targetGUID == playerGUID then
						print("event fired 4")
						ModernSpellAlert.frame.targetText:Show()
						ModernSpellAlert.frame.arrowIcon:Show()
						ModernSpellAlert.frame.casterText:SetText(casterName)
						ModernSpellAlert.frame.targetText:SetText(targetName)
						ModernSpellAlert.frame.spellIcon:SetTexture(spellIcon or "Interface\\Icons\\INV_Misc_QuestionMark")
						ModernSpellAlert.frame:SetAlpha(1)
						ModernSpellAlert.frame:Show()
						isFading = false
						StartFadeOut()
						return
					end
						
					if (profile[spellData.profileKeys.EnabledOnTarget] or false) and UnitIsUnit("target", targetGUID) then
						print("event fired 5")
						ModernSpellAlert.frame.targetText:Show()
						ModernSpellAlert.frame.arrowIcon:Show()
						ModernSpellAlert.frame.casterText:SetText(casterName)
						ModernSpellAlert.frame.targetText:SetText(targetName)
						ModernSpellAlert.frame.spellIcon:SetTexture(spellIcon or "Interface\\Icons\\INV_Misc_QuestionMark")
						ModernSpellAlert.frame:SetAlpha(1)
						ModernSpellAlert.frame:Show()
						isFading = false
						StartFadeOut()
						return
					end
					
					if (profile[spellData.profileKeys.EnabledByTarget] or false) and UnitIsUnit("target", casterGUID) then
						print("event fired 6")
						ModernSpellAlert.frame.targetText:Show()
						ModernSpellAlert.frame.arrowIcon:Show()
						ModernSpellAlert.frame.casterText:SetText(casterName)
						ModernSpellAlert.frame.targetText:SetText(targetName)
						ModernSpellAlert.frame.spellIcon:SetTexture(spellIcon or "Interface\\Icons\\INV_Misc_QuestionMark")
						ModernSpellAlert.frame:SetAlpha(1)
						ModernSpellAlert.frame:Show()
						isFading = false
						StartFadeOut()
						return
					end
					
					if (profile[spellData.profileKeys.EnabledOnFriendly] or false) and UnitIsFriend("player", targetGUID) then
						print("event fired 7")
						ModernSpellAlert.frame.targetText:Show()
						ModernSpellAlert.frame.arrowIcon:Show()
						ModernSpellAlert.frame.casterText:SetText(casterName)
						ModernSpellAlert.frame.targetText:SetText(targetName)
						ModernSpellAlert.frame.spellIcon:SetTexture(spellIcon or "Interface\\Icons\\INV_Misc_QuestionMark")
						ModernSpellAlert.frame:SetAlpha(1)
						ModernSpellAlert.frame:Show()
						isFading = false
						StartFadeOut()
						return

					end
					
					if (profile[spellData.profileKeys.EnabledByFriendly] or false) then
						if not UnitIsUnit("player", targetGUID) and UnitIsFriend("player", casterGUID) then
							print("event fired 7")
							ModernSpellAlert.frame.targetText:Show()
							ModernSpellAlert.frame.arrowIcon:Show()
							ModernSpellAlert.frame.casterText:SetText(casterName)
							ModernSpellAlert.frame.targetText:SetText(targetName)
							ModernSpellAlert.frame.spellIcon:SetTexture(spellIcon or "Interface\\Icons\\INV_Misc_QuestionMark")
							ModernSpellAlert.frame:SetAlpha(1)
							ModernSpellAlert.frame:Show()
							isFading = false
							StartFadeOut()
							return
						end
					end
					
					if (profile[spellData.profileKeys.EnabledOnHostile] or false) and UnitCanAttack("player", targetGUID) then
						print("event fired 8")
						ModernSpellAlert.frame.targetText:Show()
						ModernSpellAlert.frame.arrowIcon:Show()
						ModernSpellAlert.frame.casterText:SetText(casterName)
						ModernSpellAlert.frame.targetText:SetText(targetName)
						ModernSpellAlert.frame.spellIcon:SetTexture(spellIcon or "Interface\\Icons\\INV_Misc_QuestionMark")
						ModernSpellAlert.frame:SetAlpha(1)
						ModernSpellAlert.frame:Show()
						isFading = false
						StartFadeOut()
						return
					end
					
					if (profile[spellData.profileKeys.EnabledByHostile] or false) and UnitCanAttack("player", casterGUID) then
						print("event fired 8")
						ModernSpellAlert.frame.targetText:Show()
						ModernSpellAlert.frame.arrowIcon:Show()
						ModernSpellAlert.frame.casterText:SetText(casterName)
						ModernSpellAlert.frame.targetText:SetText(targetName)
						ModernSpellAlert.frame.spellIcon:SetTexture(spellIcon or "Interface\\Icons\\INV_Misc_QuestionMark")
						ModernSpellAlert.frame:SetAlpha(1)
						ModernSpellAlert.frame:Show()
						isFading = false
						StartFadeOut()
						return
					end
				end
			end
        end
    end
end

-- OnUpdate handler for fade-out logic
local function OnUpdateHandler(self, elapsed)
    if isFading then
        local currentTime = GetTime()
        local progress = (currentTime - fadeStartTime) / 10 -- 2.5-second fade duration
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
