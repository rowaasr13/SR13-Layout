local a_name, a_env = ...

local function ReanchorAchievementFrame()
   if not AchievementFrame then return end
   local header_height = AchievementFrame.Header:GetHeight()
   AchievementFrame:ClearAllPoints()
   AchievementFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, -header_height + 83)
end

local start = a_env.OnNextUpdateOnce(ReanchorAchievementFrame)

if AchievementFrame then
   start()
else
   EventUtil.ContinueOnAddOnLoaded("Blizzard_AchievementUI", start)
end
