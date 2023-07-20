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

LibStub("AceConfigRegistry-3.0"):NotifyChange(target_addon_name)
