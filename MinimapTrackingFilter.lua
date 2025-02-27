local a_name, a_env = ...

-- Minimap/World Map tracking
function a_env.SetMinimapTrackingFilter()
   SetCVar("questPOI", "1")
   SetCVar("questPOILocalStory", "1")
   SetCVar("questPOILocalStory", "1")
   SetCVar("trivialQuests", "1")
   SetCVar("showAccountCompletedQuests", "1")
   SetCVar("contentTrackingFilter", "1")

   local set_minimap_filter_ids = {
      [Enum.MinimapTrackingFilter.TrivialQuests] = true,
      [Enum.MinimapTrackingFilter.AccountCompletedQuests]  = true,
      [Enum.MinimapTrackingFilter.TrivialQuests] = true,
   }
   local set_minimap_filter_spell_ids = {
      [122026] = true, -- Track Pets
      [199736] = true, -- Find Treasure
      [261764] = true, -- Track Warboards
   }

   for id = 1, C_Minimap.GetNumTrackingTypes() do
      local filterInfo = C_Minimap.GetTrackingFilter(id) -- /dump C_Minimap.GetTrackingInfo(1)
      local set
      if filterInfo then
         if filterInfo.filterID then set = set_minimap_filter_ids[filterInfo.filterID] end
         if filterInfo.spellID then set = set_minimap_filter_spell_ids[filterInfo.spellID] end
      end
      if set ~= nil then C_Minimap.SetTracking(id, set) end
   end
end
