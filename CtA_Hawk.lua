local target_addon_name = "CtA_Hawk"
local self = LibStub("AceAddon-3.0"):GetAddon("CtA_Hawk")
local profile = self.db.profile

local function add_notify(section)
   if not section.notify then section.notify = {} end
   section.notify[1] = true
end

profile["Tank"]["soundFile"] = "SR13 WoodShieldFalls"
add_notify(profile["Tank"])
profile["DPS"]["soundFile"] = "Details Gun1"
add_notify(profile["DPS"])
profile["Healer"]["soundFile"] = "Blizzard prayerofmending_impact_head"
add_notify(profile["Healer"])
profile["ldbText"] = "Icons"
profile["ldbLabel"] = "Short"
profile["queues"] = profile["queues"] or {}
profile["queues"][744] = true -- Timewalking: TBC
-- DF queues >START
profile["queues"][2350] = true
profile["queues"][2351] = true
profile["queues"][1670] = false
profile["queues"][2274] = true
-- DF queues <END
profile["queues"]["auto"] = false
-- TODO: make new setting "all" => "each and every entry available in LFD dropdown"

LibStub("AceConfigRegistry-3.0"):NotifyChange(target_addon_name)
