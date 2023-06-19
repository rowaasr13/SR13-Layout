local a_name, a_env = ...

-- [AUTOLOCAL START]
local CreateFrame = CreateFrame
local InCombatLockdown = InCombatLockdown
local pairs = pairs
-- [AUTOLOCAL END]

local watcher = CreateFrame("Frame")
local limited_times = {
   PLAYER_REGEN_ENABLED    = 1,
   PLAYER_REGEN_DISABLED   = 1,
   PLAYER_ENTERING_WORLD   = 1,
   LOADING_SCREEN_DISABLED = 1,
}

local function Watcher(self, event, ...)
   if InCombatLockdown() then
      watcher:RegisterEvent("PLAYER_REGEN_ENABLED")
      return
   end

   local limit = limited_times[event]
   if limit and limit > 0 then
      limited_times[event] = limit - 1
      if limit <= 1 then
         watcher:UnregisterEvent(event)
      end
   end

   return a_env.SetupAll(self, event, ...)
end

watcher:SetScript("OnEvent", Watcher)

for event, limit in pairs(limited_times) do
   if limit >= 0 then
      watcher:RegisterEvent(event)
   end
end
