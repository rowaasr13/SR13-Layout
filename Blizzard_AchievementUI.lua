local a_name, a_env = ...

local function ReanchorAchievementFrame()
   if not AchievementFrame then return end
   local header_height = AchievementFrame.Header:GetHeight()
   AchievementFrame:ClearAllPoints()
   AchievementFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, -header_height + 83)
end

a_env.OnAddOnLoadedAndNextUpdateOnce({
   already_loaded = function() return AchievementFrame end,
   addon = "Blizzard_AchievementUI",
   ['then'] = ReanchorAchievementFrame,
})
