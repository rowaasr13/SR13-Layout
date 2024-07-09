local a_name, a_env = ...

a_env.OnAddOnLoadedAndNextUpdateOnce({
   already_loaded = function() return CombatText end,
   addon = "Blizzard_CombatText",
   ['then'] = function()
      CombatText:SetScale(.90)
   end,
})
