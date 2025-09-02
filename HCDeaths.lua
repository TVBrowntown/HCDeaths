HCDeaths_Settings = {
    message = true,
    toast = true,
    color = false,
    levelsound = true,
    deathsound = true,
    toastscale = 1,
    toasttime = 10,
}

local MAX_LEVEL = 60

local media = "Interface\\Addons\\HCDeaths\\media\\"
local twidth, theight = 332.8, 166.4

-- Sound files
local HARDCORE_START_SOUND = "Sound\\Doodad\\G_FireworkLauncher02Custom0.wav"
local HARDCORE_COMPLETE_SOUND = "Sound\\Doodad\\G_FireworkLauncher02Custom0.wav"
local LEVEL_UP_SOUND = "Sound\\Doodad\\G_FireworkLauncher02Custom0.wav"
local DEATH_SOUND = "Sound\\Interface\\RaidWarning.wav"
local DEATH_PLAYER_SOUND = DEATH_SOUND
local DEATH_PVP_SOUND = DEATH_SOUND

local NPC_STRING = "(.-) fell to the blows of (.-) at (.-) and now brandishes a tarnished soul after reaching level (%d+)."
local PVP_STRING = "(.-) was slaughtered in PvP combat by (.-) at (.-) and now brandishes a tarnished soul after reaching level (%d+)."
local NATURAL_CAUSES_STRING = "(.-) died by (.-) at (.-) and now brandishes a tarnished soul after reaching level (%d+)."
local UNKNOWN_CAUSE_STRING = "(.-) collapsed into the timeways at (.-) and now brandishes a tarnished soul after reaching level (%d+)."

local MILESTONE_STRING = "(.-) has reached level (%d+) with a Soul of Iron."
local MAX_MILESTONE_STRING = "(.-) has attained the mighty level of (%d+) with a Soul of Iron. Witness their might!"

local SOUL_OF_IRON_ICON = "Interface\\Icons\\Spell_Shadow_Skull"
local SOUL_OF_IRON_20 = 5016
local SOUL_OF_IRON_40 = 5017
local SOUL_OF_IRON_60 = 5018

local lastWords = {
    "I thought I was lagging...",
    "Didn't the healer have mana?",
    "I can solo this elite, watch me!",
    "What do you mean 'Don't release'?",
    "Leeeeeroy Jenkins!",
    "I'll be right back, bio break.",
    "Who pulled?",
    "I don't need a tank! I'm a Hunter.",
    "Oops, wrong button.",
    "Don't worry, I've done this before.",
    "Wait, that wasn't a health potion?",
    "I thought I was immune to fall damage.",
    "Curse you, autorun!",
    "This isn't even my final form!",
    "I bet I can make that jump.",
    "Hold my mana potion.",
    "Watch this trick shot!",
    "I'm sure it's just a flesh wound.",
    "Didn't we clear this trash already?",
    "I thought Blessing of Protection was on...",
    "Surely this mob is almost dead.",
    "I can tank this, I have a shield equip-- oh.",
    "Don't worry, I've calculated the odds.",
    "I'm sure my pet can handle it.",
    "What do you mean 'Don't stand in the fire'?",
    "I thought Bubble Hearth still worked.",
    "Apparently, that wasn't a 'summoning' portal.",
    "I swear I pressed the heal button!",
    "Who knew Murlocs traveled in packs?",
    "I'm sure this debuff will wear off soon.",
    "Trust me, I'm an engineer.",
    "I didn't need that soul shard anyway.",
    "I thought Vanish was off cooldown.",
    "Surely they nerfed this boss by now.",
    "What do you mean 'Don't release the sheep'?",
    "I can survive this fall with Slow Fall... oh wait.",
    "I'm sure that mob is passive.",
    "Don't worry, I've got Divine Intervention... oh right.",
    "I thought I specced into that talent.",
    "Apparently, 'Undead' doesn't mean immune to death.",
    "I'm sure this random mushroom is edible.",
    "What do you mean 'Line of Sight'?",
    "I thought I wasn't on my main?",
    "Didn't we have a soul stone up?",
    "I'm sure that treasure chest isn't trapped.",
    "Watch me kite this world boss!",
    "I don't need to read the dungeon journal.",
    "What's the worst that could happen?",
    "I'm sure that's just cosmetic damage.",
    "Trust me, I've seen this on YouTube.",
    "A little help?",
    "I can't believe you've done this.",
    "EPOCH HYPE! EPOCH HYPE!",
    "I know a shortcut through here.",
    "Aggro? What aggro?",
    "It's just one mob.",
    "I think I can squeeze through.",
    "I forgot to repair... it'll be fine.",
    "Why are you running?",
    "Just one more pull before bed.",
    "Don't worry, this build is unkillable.",
    "I think this thing will leash.",
    "We don't need CC, just AoE everything.",
    "I'm just going to poke it.",
    "Wait, I haven't set my binds yet!",
    "Let me just test this damage.",
    "Who needs gear when you've got skill?",
    "I watched a guide... like a month ago.",
    "I think I clicked something...",
    "I was lagging. For real this time.",
    "This is definitely the safe zone.",
    "I'm just checking what's around the corner.",
    "I can survive the enrage phase.",
    "The healer can just spam me. Pretty sure they aren't AFK now.",
    "I'll stand over here to be safe.",
    "What's this red circle do?",
    "I'll just loot real quick.",
    "YOLO pull!",
    "I swear this worked on my alt.",
    "You guys go ahead, I’ll catch up.",
    "I just need one more hit.",
    "I was testing gravity.",
    "If I die, it's your fault btw.",
    "I'm helping.",
    "That ability has a long cast time, right?",
    "Oh, we needed to kill the adds?",
    "Let's just pull the whole room.",
    "It can't *possibly* one-shot me.",
    "I'll just stealth through.",
    "The tank pulled, right?",
    "What's the worst that could happen if I press this button?"
}

local pvpLastWords = {
    "I don't need a tank! I'm a Hunter.",
    "I'm sure my pet can handle it.",
    "Trust me, I've seen this on YouTube.",
    "I thought Vanish was off cooldown.",
    "I swear this worked on my alt.",
    "Just one more pull before bed.",
    "Don't worry, this build is unkillable.",
    "The healer can just spam me. Pretty sure they aren't AFK now.",
    "I just need one more hit.",
    "If I die, it's your fault btw.",
    "I'm helping.",
    "I'm sure it's just a flesh wound.",
    "I thought I wasn't on my main?",
    "Who needs gear when you've got skill?",
    "YOLO pull!",
    "This isn't even my final form!",
    "Surely this mob is almost dead.",
    "What do you mean 'Don't stand in the fire'?",
    "Leeeeeroy Jenkins!",
    "I watched a guide... like a month ago.",
    "I can solo this elite, watch me!",
    "They nerfed arena gear? Whatever, I'll still win.",
    "I'll just 1v1 the whole team.",
    "I don't need CC—I have personality.",
    "I'm streaming this—what could go wrong?",
    "Lag? What lag?",
    "I'm god‑moded, obviously.",
    "My mouse is broken—not me.",
    "One shot? Challenge accepted.",
    "No cooldowns, just fearlessness.",
    "This class is OP—watch me prove it.",
    "I'm better than this build says I am.",
    "Get that kill feed ready.",
    "They can't kill us all!",
    "This is a 1‑shot combo, trust me.",
    "I'm behind cover… I think.",
    "That person is trash, they can't beat me.",
}

local npcLastWords = {
    "Didn't the healer have mana?",
    "Don't worry, I've done this before.",
    "We don't need CC, just AoE everything.",
    "Oops, wrong button.",
    "Wait, that wasn't a health potion?",
    "I'm just going to poke it.",
    "Let me just test this damage.",
    "I can tank this, I have a shield equip-- oh.",
    "I swear I pressed the heal button!",
    "What do you mean 'Don't release the sheep'?",
    "Oh, we needed to kill the adds?",
    "Let's just pull the whole room.",
    "Watch me kite this world boss!",
    "I thought the boss was still leashed!",
    "I'm just checking what's around the corner.",
    "Don't worry, I've calculated the odds.",
    "I didn't need that soul shard anyway.",
    "That ability has a long cast time, right?",
    "The tank pulled, right?",
    "Didn't we clear this trash already?",
    "What's the worst that could happen?",
    "I'll just stealth through.",
    "What's this red circle do?",
    "I know a shortcut through here.",
    "Aggro? What aggro?",
    "I'm sure that mob is passive.",
    "You guys go ahead, I’ll catch up.",
    "Portal’s friendly, right?",
    "I de‑aggroed—honest!",
    "It’s fine, they won’t path here.",
    "I clicked the auto‑loot… maybe.",
    "I thought traps only delay you.",
    "My weapon is 'just for show'.",
    "I loaded the right quest… I think.",
    "This elixir works on everything, right?",
    "Cooldowns are suggestions.",
    "My pet is tanking… somewhere.",
    "I'll interrupt... eventually.",
    "The raid finder said I'm fine.",
    "This is warp‑safe, definitely.",
    "Time stops on boss cast, sure.",
    "I read the journal. Kind of.",
    "It's a weak‑only area, duh.",
}

local naturalLastWords = {
    "I thought I was lagging...",
    "Wait, I haven't set my binds yet!",
    "This is definitely the safe zone.",
    "I thought I was immune to fall damage.",
    "Curse you, autorun!",
    "I bet I can make that jump.",
    "Hold my mana potion.",
    "I'm sure that's just cosmetic damage.",
    "Apparently, that wasn't a 'summoning' portal.",
    "I can survive this fall with Slow Fall... oh wait.",
    "Apparently, 'Undead' doesn't mean immune to death.",
    "I'm sure this random mushroom is edible.",
    "What do you mean 'Line of Sight'?",
    "I'm sure that treasure chest isn't trapped.",
    "I forgot to repair... it'll be fine.",
    "Why are you running?",
    "I think I can squeeze through.",
    "I was testing gravity.",
    "If I die, it's your fault.",
    "Oops, that was the self-destruct macro.",
    "Watch this trick shot!",
    "I thought Blessing of Protection was on...",
    "I thought Bubble Hearth still worked.",
    "I thought I specced into that talent.",
    "Didn't we have a soul stone up?",
    "EPOCH HYPE! EPOCH HYPE!",
    "What's the worst that could happen if I press this button?",
    "Wurm? Lucky break, right?",
    "I’ll just AFK here for a sec.",
    "Teleport’s safe zone... ish.",
    "What's this spike do?",
    "Fast travel is always safe.",
    "I wasn't standing in fire? I guess.",
    "Fall damage is bugged… maybe.",
    "There’s no floor here, right?",
    "I’ll just mount mid‑jump.",
    "Lag will catch me—momentarily.",
    "I’m actually underwater—maybe.",
    "That bridge looked solid.",
    "This pit is shallow. I hope.",
    "I hear water’s nice this time of day.",
    "Gravity’s just a theory.",
    "I rebooted the server—better now.",
    "This corner has good light. I’ll live.",
}

local celebrationQuotes = {
    "For the Alliance! ...or was it the Horde?",
    "I am now prepared!",
    "Lok'tar ogar! ...I think I said that right.",
    "I've got the power of God and anime on my side!",
    "I can now officially call Dalaran my home.",
    "Time is money, friend, and I've got time to spare!",
    "I am one with the RNG, and the RNG is with me.",
    "I didn't choose the mug life, the mug life chose me.",
    "I've collected more mounts than Pepe has forms!",
    "I'm not addicted, I can quit anytime... right after this raid.",
    "I've seen things you people wouldn't believe. Attacks ships on fire off the shoulder of Orgrimmar...",
    "I don't always drink in Azeroth, but when I do, I prefer Kungaloosh.",
    "I've finally collected enough transmog to open my own fashion house in Silvermoon.",
    "I'm not a regular adventurer, I'm a cool adventurer.",
    "I've died and released so many times, I'm on a first-name basis with the Spirit Healer.",
    "I'm not saying I'm the Chosen One, but my Hearthstone's cooldown is always up.",
    "I don't need a flying mount, I can just leap tall buildings in a single bound.",
    "I've completed so many fetch quests, I'm thinking of changing my class to 'Retriever'.",
    "I'm so iconic, NPCs ask for my autograph.",
    "I don't need a guild, I AM the guild.",
    "I'm not saying I'm better than Chromie at time management, but...",
    "I've saved Azeroth so many times, I should start charging rent.",
    "I'm on a boat! ...I mean, a flying ship in Icecrown!",
    "I am the one who knocks... on Arthas's door!",
    "I've collected so many pets, I'm considering opening a zoo in Sholazar Basin.",
    "I don't need transmogrification, I was born this fabulous.",
    "I'm not lost, I'm on a perpetual world tour of Azeroth.",
    "I've died so many times, I have a loyalty card with the Spirit Healer.",
    "I'm so legendary, even my failures are epic.",
    "I don't need a flying mount, I've mastered the art of gracefully falling with style.",
    "I'm not saying I'm the best, but have you seen anyone else save Azeroth this many times?",
    "I've completed so many dailies, I'm thinking of changing my name to 'Groundhog Day'.",
    "I don't need a guild bank, I AM the bank.",
    "I'm so powerful, even Chuck Norris asks me for advice.",
    "I've fished so much, the Naga are considering me for underwater ambassador.",
    "I don't always win, but when I do, it's because I released my inner murloc.",
    "I'm so rich, I use Azeroth's rarest materials as confetti.",
    "I've tanked so many bosses, I'm considering a career in architecture.",
    "I don't need a Mage portal, I can bend space and time with my sheer awesomeness.",
    "I'm so famous, even Khadgar asks for my autograph.",
    "I've cooked so many feasts, I'm considering opening a restaurant in Dalaran.",
    "I don't need armor, my plot armor is impenetrable.",
    "I'm so skilled, even the training dummies are learning from me.",
    "I don't need a flying mount, I've trained my ground mount to run on air.",
    "I'm so legendary, even my alts have their own fan clubs.",
    "I've defeated so many Old Gods, they're considering me for adoption.",
    "I don't need quest markers, I have an innate sense of where to collect 10 boar tusks.",
    "Don't let your dreams be dreams!",
    "Ding! Level 60? More like 6.0 out of 10!",
    "I'm not saying I'm Batman, but have you ever seen me and Batman in Azeroth at the same time?",
    "This isn't even my final form... oh wait, it is!",
    "I don't always reach max level, but when I do, I prefer to do it in style.",
    "They said I could be anything, so I became a Hardcore legend.",
    "I'm not procrastinating, I'm just waiting for my cooldowns.",
    "I'm not saying I'm a god, but I did stay at a Dalaran inn last night.",
    "I don't need sleep, I have Bloodlust and energy drinks.",
    "I'm not toxic, I'm just sharing my love for the game... aggressively.",
    "I can quit whenever I want... just one more quest.",
    "I don't need a life, I have multiple characters.",
    "I don't need to go outside, I've been to every zone in Azeroth.",
    "I don't always win, but when I do, it's because the other team didn't.",
    "They said 'Git gud', so I got gudder.",
    "I'm not screaming, I'm using my outdoor raid voice.",
    "I don't need a social life, I have my guild.",
    "I don't need therapy, I have loading screen tips.",
    "I can one-shot critters.",
    "Ok, now I can start playing the game.",
    "I'm not saying I'm rich, but I do have a Mammoth mount.",
    "I don't need a workout, I've been carrying my team.",
    "They said 'Break a leg', so I did... and then I used a healing potion.",
    "My transmog game is on point.",
    "I don't need a GPS, I have a mini-map.",
    "They said 'The floor is lava', so I learned to fly.",
    "I don't need a gym membership, I've been lifting Thunderfury, Blessed Blade of the Windseeker.",
    "They said 'You can't handle the truth', so I specced into Resilience.",
    "I don't need a calendar, I have daily quests.",
    "They said 'Get a life', so I got nine... Wait, wrong game.",
    "I don't need a watch, I have debuff timers.",
    "They said 'Touch some grass', so I farmed herbs for 10 hours.",
    "I don't need a mirror, I have the character selection screen."
}

local instances = {
    -- Classic Dungeons
    "Ragefire Chasm",
    "Wailing Caverns",
    "Deadmines",
    "Shadowfang Keep",
    "Blackfathom Deeps",
    "The Stockade",
    "Gnomeregan",
    "Razorfen Kraul",
    "Scarlet Monastery",
    "Razorfen Downs",
    "Uldaman",
    "Zul'Farrak",
    "Maraudon",
    "Temple of Atal'Hakkar",
    "Blackrock Depths",
    "Lower Blackrock Spire",
    "Upper Blackrock Spire",
    "Dire Maul",
    "Stratholme",
    "Scholomance",
    -- Classic Raids
    "Molten Core",
    "Onyxia's Lair",
    "Blackwing Lair",
    "Zul'Gurub",
    "Ruins of Ahn'Qiraj",
    "Temple of Ahn'Qiraj",
    "Naxxramas",
    -- The Burning Crusade Dungeons
    "Hellfire Ramparts",
    "Blood Furnace",
    "Slave Pens",
    "Underbog",
    "Mana-Tombs",
    "Auchenai Crypts",
    "Old Hillsbrad Foothills",
    "Sethekk Halls",
    "Steamvault",
    "Shadow Labyrinth",
    "Black Morass",
    "Arcatraz",
    "Botanica",
    "Mechanar",
    "Shattered Halls",
    "Magisters' Terrace",
    -- The Burning Crusade Raids
    "Karazhan",
    "Gruul's Lair",
    "Magtheridon's Lair",
    "Serpentshrine Cavern",
    "The Eye",
    "Mount Hyjal",
    "Black Temple",
    "Sunwell Plateau",
    -- Wrath of the Lich King Dungeons
    "Utgarde Keep",
    "The Nexus",
    "Azjol-Nerub",
    "Ahn'kahet: The Old Kingdom",
    "Drak'Tharon Keep",
    "The Violet Hold",
    "Gundrak",
    "Halls of Stone",
    "Halls of Lightning",
    "The Oculus",
    "Culling of Stratholme",
    "Utgarde Pinnacle",
    "Trial of the Champion",
    "Forge of Souls",
    "Pit of Saron",
    "Halls of Reflection",
    -- Wrath of the Lich King Raids
    "Naxxramas",
    "Obsidian Sanctum",
    "Vault of Archavon",
    "Eye of Eternity",
    "Ulduar",
    "Trial of the Crusader",
    "Onyxia's Lair",
    "Icecrown Citadel",
    "Ruby Sanctum",
    -- Project Epoch
    "Glittermurk Mines"
}

local function GetRandomLastWords(deathType)
    local theseLastWords
    if deathType == "NPC" then
        theseLastWords = npcLastWords
    elseif deathType == "PVP" then
        theseLastWords = pvpLastWords
    elseif deathType == "PLAYER" then
        theseLastWords = naturalLastWords
    else
        theseLastWords = npcLastWords
    end
    return theseLastWords[math.random(#theseLastWords)]
end

local function GetRandomCelebrationQuote()
    return celebrationQuotes[math.random(#celebrationQuotes)]
end

local HCDeath = CreateFrame("Frame", nil, UIParent)
local media = "Interface\\Addons\\HCDeaths\\media\\"
local twidth, theight = 332.8, 166.4

if not RAID_CLASS_COLORS["DEATHKNIGHT"] then
    RAID_CLASS_COLORS["DEATHKNIGHT"] = { r = 0.77, g = 0.12, b = 0.23 }
end

do
    -- Create the toast frame
    local HCDeathsToast = CreateFrame("Button", "HCDeathsToast", HCDeath)
    HCDeathsToast:SetWidth(twidth)
    HCDeathsToast:SetHeight(theight)
    HCDeathsToast:Hide()

    -- Setup textures
    HCDeath.texture = HCDeathsToast:CreateTexture(nil,"LOW")
    HCDeath.texture:SetAllPoints(HCDeathsToast)
    HCDeath.texture:SetTexture(media.."Ring\\Ring")

    HCDeath.type = HCDeathsToast:CreateTexture(nil,"BACKGROUND")
    HCDeath.type:SetPoint("CENTER", HCDeath.texture, "CENTER", -43, -24)

    HCDeath.class = HCDeathsToast:CreateTexture(nil,"BACKGROUND")
    HCDeath.class:SetPoint("CENTER", HCDeath.texture, "CENTER", 0, 10)

    -- Setup fonts
    local font, size, outline = "Fonts\\FRIZQT__.TTF", 16, "OUTLINE"
    
    HCDeath.level = HCDeathsToast:CreateFontString(nil, "LOW", "GameFontNormal")
    HCDeath.level:SetPoint("TOP", HCDeath.texture, "CENTER", 42, -15)
    HCDeath.level:SetWidth(HCDeath.texture:GetWidth())
    HCDeath.level:SetFont(font, size, outline)

    HCDeath.name = HCDeathsToast:CreateFontString(nil, "LOW", "GameFontNormal")    
    HCDeath.name:SetWidth(HCDeath.texture:GetWidth())
    HCDeath.name:SetFont(font, size, outline)

    outline = "THINOUTLINE"

    HCDeath.zone = HCDeathsToast:CreateFontString(nil, "LOW", "GameFontNormal")    
    HCDeath.zone:SetWidth(HCDeath.texture:GetWidth()*1.5)
    HCDeath.zone:SetFont(font, size, outline)

    HCDeath.death = HCDeathsToast:CreateFontString(nil, "LOW", "GameFontNormal")    
    HCDeath.death:SetWidth(HCDeath.texture:GetWidth()*1.5)
    HCDeath.death:SetFont(font, size, outline)

    HCDeath.lastwords = HCDeathsToast:CreateFontString(nil, "LOW", "GameFontNormal")
    HCDeath.lastwords:SetWidth(HCDeath.texture:GetWidth())
    HCDeath.lastwords:SetFont(font, size, outline)
    HCDeath.lastwords:SetTextColor(.5,.5,.5)

    -- Position text elements
    HCDeath.name:SetPoint("TOP", HCDeath.texture, "CENTER", 0, -44)
    HCDeath.zone:SetPoint("TOP", HCDeath.name, "BOTTOM", 0, -14)
    HCDeath.death:SetPoint("TOP", HCDeath.zone, "BOTTOM", 0, -5)        
    HCDeath.lastwords:SetPoint("TOP", HCDeath.death, "BOTTOM", 0, -10)

    -- Make frame movable
    HCDeathsToast:SetMovable(true)
    HCDeathsToast:SetClampedToScreen(true)
    HCDeathsToast:SetUserPlaced(true)
    HCDeathsToast:EnableMouse(true)
    HCDeathsToast:RegisterForClicks("RightButtonDown")
    HCDeathsToast:RegisterForDrag("LeftButton")
  
    function HCDeathsToast:position()
        HCDeathsToast:ClearAllPoints()
        HCDeathsToast:SetPoint("CENTER", UIErrorsFrame, "CENTER", 0, -140)
    end
  
    HCDeathsToast:position()
  
    -- Frame scripts
    HCDeathsToast:SetScript("OnDragStart", function()
        if IsShiftKeyDown() and IsControlKeyDown() then
            HCDeathsToast:StartMoving()
        end
    end)
  
    HCDeathsToast:SetScript("OnDragStop", function()
        HCDeathsToast:StopMovingOrSizing()
    end)
  
    HCDeathsToast:SetScript("OnClick", function()
        if IsShiftKeyDown() and IsControlKeyDown() then
            HCDeathsToast:SetUserPlaced(false)
            HCDeathsToast:position()
        end
    end)
end

-- Toast timer
local toastTimer = CreateFrame("Frame", nil, HCDeath)
toastTimer:Hide()
toastTimer:SetScript("OnUpdate", function()
    if GetTime() >= this.time then
        this.time = nil
        HCDeath:hideToast()
        this:Hide()
    end
end)

-- Helper Functions
function HCDeath:classSize()
    local s = 85
    HCDeath.class:SetWidth(s)
    HCDeath.class:SetHeight(s)
end

function HCDeath:isInstance(location)
    for _, loc in pairs(instances) do
        if loc == location then
            return true
        end
    end
    return false
end

function HCDeath:rgbToHex(r, g, b)
    return string.format("%02X%02X%02X", r * 255, g * 255, b * 255)
end

function HCDeath:locHex(location)
    if HCDeath:isInstance(location) then
        return "A330C9" -- Purple color for instances
    end
    return HCDeath:rgbToHex(1, .5, 0) -- Orange color for regular zones
end

function HCDeath:typeSize()
    local s = 25
    HCDeath.type:SetWidth(s)
    HCDeath.type:SetHeight(s)
end

function HCDeath:showToast()
    HCDeath:classSize()
    HCDeath:typeSize()
    HCDeathsToast:Show()

    toastTimer.time = GetTime() + HCDeaths_Settings.toasttime
    toastTimer:Show()
end

function HCDeath:hideToast()
    HCDeathsToast:Hide()
    HCDeath.name:SetText("")
    HCDeath.level:SetText("")
    HCDeath.zone:SetText("")
    HCDeath.death:SetText("")
    HCDeath.lastwords:SetText("")
end

function HCDeath:texColor(level)
    HCDeath.texture:SetVertexColor(.75,.75,.75)
    if HCDeaths_Settings.color then
        if level == 80 then
            HCDeath.texture:SetVertexColor(255/255, 215/255, 0/255)
        elseif level >= 70 then
            HCDeath.texture:SetVertexColor(224/255, 204/255, 95/255)
        elseif level >= 60 then
            HCDeath.texture:SetVertexColor(1,1,1)
        elseif level >= 40 then
            HCDeath.texture:SetVertexColor(183/255, 157/255, 140/255)
        elseif level >= 20 then
            HCDeath.texture:SetVertexColor(173/255, 122/255, 86/255)
        end
    end
end

function HCDeath:sound(deathType)
    if (deathType == "NPC" or deathType == "PLAYER" or deathType == "PVP") then
        if HCDeaths_Settings.deathsound then
            PlaySoundFile(DEATH_SOUND)
        end
    elseif HCDeaths_Settings.levelsound then
        if deathType == "LVL" then
            PlaySoundFile(LEVEL_UP_SOUND)
        elseif deathType == "MAX_LEVEL" then
            PlaySoundFile(HARDCORE_COMPLETE_SOUND)
        end
    end
end

function HCDeath:ToastScale()
    HCDeathsToast:SetScale(HCDeaths_Settings.toastscale)
end

function HCDeath:toastLVL(playerName, playerLevel)

    HCDeath.level:SetText(playerLevel)
    local iconDisplay
    if tonumber(playerLevel) == 20 then
        iconDisplay = SOUL_OF_IRON_20
    else
        iconDisplay = SOUL_OF_IRON_40
    end
    local _, _, _, _, _, _, _, _, _, showIcon = GetAchievementInfo(iconDisplay)

    HCDeath.type:SetTexture(showIcon)
    HCDeath.name:SetText(playerName.."")
    HCDeath.zone:SetText("has reached level "..playerLevel.." in Hardcore mode!")
    HCDeath.death:SetText("Their ascendance towards immortality continues.")
    HCDeath.lastwords:SetText("")

    HCDeath:texColor(playerLevel)   
    HCDeath.class:SetTexture(showIcon)
    HCDeath:classSize()
    HCDeath:typeSize()
    HCDeath:showToast()
    HCDeath:sound("LVL")
end

function HCDeath:toastMAX_LEVEL(playerName)

    HCDeath.level:SetText(MAX_LEVEL)

    local iconDisplay = SOUL_OF_IRON_60
    local _, _, _, _, _, _, _, _, _, showIcon = GetAchievementInfo(iconDisplay)

    HCDeath.type:SetTexture(showIcon)
    HCDeath.name:SetText(playerName.."")
    HCDeath.zone:SetText("has transcended death and reached level "..MAX_LEVEL.." on Hardcore mode without dying once!")
    HCDeath.death:SetText(playerName.." shall henceforth be known as |cffFF8000the Immortal|r!")
    HCDeath.lastwords:SetText("'"..GetRandomCelebrationQuote().."'")

    HCDeath:texColor(MAX_LEVEL)
    HCDeath.class:SetTexture(showIcon)
    HCDeath:classSize()
    HCDeath:typeSize()
    HCDeath:showToast()
    HCDeath:sound("MAX_LEVEL")
end

function HCDeath:toastDEATH(playerName, deathType, killerName, playerZone, playerLevel)

    if playerZone == nil then
        playerZone = "the world"
    end

    HCDeath.level:SetText(playerLevel)
    HCDeath.name:SetText(playerName)
    HCDeath.zone:SetText("A tragedy has occurred.")

    if deathType == "NPC" then
        local zoneHex = HCDeath:locHex(playerZone)
        HCDeath.death:SetText(playerName.." has fallen to "..killerName.." at level "..playerLevel.." somewhere in |cff"..zoneHex..playerZone..".")
    elseif deathType == "PLAYER" then
        local zoneHex = HCDeath:locHex(playerZone)
        HCDeath.death:SetText(playerName.." has died of natural causes at level "..playerLevel.." somewhere in |cff"..zoneHex..playerZone..".")
    elseif deathType == "PVP" then
        local zoneHex = HCDeath:locHex(playerZone)
        HCDeath.death:SetText(playerName.." has fallen to "..killerName.." at level "..playerLevel.." somewhere in |cff"..zoneHex..playerZone..".")
    elseif deathType == "UNKNOWN" then
        local zoneHex = HCDeath:locHex("the timeways")
        HCDeath.death:SetText(playerName.." has fallen at level "..playerLevel.." somewhere in |cff"..zoneHex.."the timeways.")
    end

    HCDeath.type:SetTexture(SOUL_OF_IRON_ICON)
    HCDeath.lastwords:SetText("'"..GetRandomLastWords(deathType).."'")

    HCDeath:texColor(playerLevel)
    HCDeath.class:SetTexture(SOUL_OF_IRON_ICON)
    HCDeath:classSize()
    HCDeath:typeSize()
    HCDeath:showToast()
    HCDeath:sound(deathType)
end

-- Slash command handling
local function HCDeaths_commands(msg)
    if msg == "toggle" then
        HCDeaths_Settings.toast = not HCDeaths_Settings.toast
        DEFAULT_CHAT_FRAME:AddMessage("HCDeaths: Toast notifications " .. (HCDeaths_Settings.toast and "enabled" or "disabled"))
    elseif msg == "sound" then
        HCDeaths_Settings.deathsound = not HCDeaths_Settings.deathsound
        DEFAULT_CHAT_FRAME:AddMessage("HCDeaths: Death sounds " .. (HCDeaths_Settings.deathsound and "enabled" or "disabled"))
    elseif msg == "levelsound" then
        HCDeaths_Settings.levelsound = not HCDeaths_Settings.levelsound
        DEFAULT_CHAT_FRAME:AddMessage("HCDeaths: Level sounds " .. (HCDeaths_Settings.levelsound and "enabled" or "disabled"))
    elseif msg == "test" then
        local random_number = math.random(1, 3)
        if random_number == 1  then
            HCDeath:toastDEATH("Bset", "PVP", "Riftwan", "The Crossroads", "60")
            toastTimer.time = GetTime() + HCDeaths_Settings.toasttime
            toastTimer:Show()
        elseif random_number == 2 then
            local level
            local random_level = math.random(1, 2)
            if random_level == 1 then
                level = 20
            else
                level = 40
            end
            HCDeath:toastLVL("Bset", level)
            toastTimer.time = GetTime() + HCDeaths_Settings.toasttime
            toastTimer:Show()
        else
            HCDeath:toastMAX_LEVEL("Bset")
            toastTimer.time = GetTime() + HCDeaths_Settings.toasttime
            toastTimer:Show()
        end
    elseif msg == "color" then
        HCDeaths_Settings.color = not HCDeaths_Settings.color
        DEFAULT_CHAT_FRAME:AddMessage("HCDeaths: Color coding " .. (HCDeaths_Settings.color and "enabled" or "disabled"))
    elseif msg == "reset" then
        HCDeaths_Settings = {
            message = true,
            toast = true,
            color = false,
            levelsound = true,
            deathsound = true,
            toastscale = 1,
            toasttime = 10,
        }
        HCDeath:ToastScale()
        HCDeathsToast:SetUserPlaced(false)
        HCDeathsToast:position()
        DEFAULT_CHAT_FRAME:AddMessage("HCDeaths: Settings reset to defaults")
    else
        DEFAULT_CHAT_FRAME:AddMessage("HCDeaths commands:")
        DEFAULT_CHAT_FRAME:AddMessage("/hcd toggle - Toggle toast notifications")
        DEFAULT_CHAT_FRAME:AddMessage("/hcd sound - Toggle death sounds")
        DEFAULT_CHAT_FRAME:AddMessage("/hcd levelsound - Toggle level up sounds")
        DEFAULT_CHAT_FRAME:AddMessage("/hcd color - Toggle color coding")
        DEFAULT_CHAT_FRAME:AddMessage("/hcd reset - Reset all settings to default")
    end
end

-- Register slash commands
SLASH_HCDEATHS1 = "/hcdeaths"
SLASH_HCDEATHS2 = "/hcd"
SlashCmdList["HCDEATHS"] = HCDeaths_commands

-- Main event handler
HCDeath:RegisterEvent("CHAT_MSG_CHANNEL")

-- Modify the event handler to only process messages from channel 5
HCDeath:SetScript("OnEvent", function()
    if event == "CHAT_MSG_CHANNEL" then
        if arg2 ~= "" then return end
        
        -- Clean inline during matching - most concise
        local msg = string.gsub(string.gsub(arg1, "|c%x%x%x%x%x%x%x%x", ""), "|r", "")
        
        local reportType = nil

        if string.match(msg, PVP_STRING) ~= nil or string.match(msg, NPC_STRING) ~= nil or 
           string.match(msg, NATURAL_CAUSES_STRING) ~= nil or string.match(msg, UNKNOWN_CAUSE_STRING) ~= nil then
            reportType = "DEATH"
        elseif string.match(msg, MAX_MILESTONE_STRING) ~= nil then
            reportType = "MAX_LEVEL"
        elseif string.match(msg, MILESTONE_STRING) ~= nil then
            reportType = "LEVEL_UP"
        else
            return
        end

        if reportType == "LEVEL_UP" then
            HCDeath:toastLVL(playerName, playerLevel)
            toastTimer.time = GetTime() + HCDeaths_Settings.toasttime
            toastTimer:Show()
        elseif reportType == "MAX_LEVEL" then
            HCDeath:toastMAX_LEVEL(playerName)
            toastTimer.time = GetTime() + HCDeaths_Settings.toasttime
            toastTimer:Show()
        elseif reportType == "DEATH" then
            local playerName = ""
            local killerName = ""
            local playerLevel = ""
            local playerZone = ""
            local deathType = ""
            
            if string.match(arg1, PVP_STRING) ~= nil then
                deathType = "PVP"
                playerName, killerName, playerZone, playerLevel = string.match(arg1, PVP_STRING)
            elseif string.match(arg1, NPC_STRING) ~= nil then
                deathType = "NPC"
                playerName, killerName, playerZone, playerLevel = string.match(arg1, NPC_STRING)
            elseif string.match(arg1, NATURAL_CAUSES_STRING) ~= nil then
                deathType = "PLAYER"
                playerName, killerName, playerZone, playerLevel = string.match(arg1, NATURAL_CAUSES_STRING)
            else
                deathType = "UNKNOWN"
                playerName, playerZone, playerLevel = string.match(arg1, UNKNOWN_CAUSE_STRINGN)
                killerName = nil
            end

            if playerName and playerLevel then
                HCDeath:toastDEATH(playerName, deathType, killerName, playerZone, playerLevel)
                toastTimer.time = GetTime() + HCDeaths_Settings.toasttime
                toastTimer:Show()
            end
        end
    end
end)