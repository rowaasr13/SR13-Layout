local a_name, a_env = ...

-- Enter with disabled button:
-- /run GameMenuButtonEditMode:GetScript("OnClick")()
-- /run ShowUIPanel(EditModeManagerFrame);

_G[a_name] = {}

_G[a_name].SetCVars = function()
   SetCVar("autoLootDefault", 1)
   SetCVar("alwaysCompareItems", 1)
   SetCVar("timeMgrUseMilitaryTime", 1) -- 24 hour format
   -- FCT vars will need 2nd ReloadUI to start working
   SetCVar("floatingCombatTextAllSpellMechanics", 1)
   SetCVar("floatingCombatTextAuras", 1)
   SetCVar("floatingCombatTextCombatState", 1)
   SetCVar("floatingCombatTextRepChanges", 1)
   SetCVar("cameraDistanceMaxZoomFactor",  2.6)
   -- AutoPushSpellToActionBar 0
   -- chatClassColorOverride 1
   -- colorChatNamesByClass 1
end

-- /run _G["SR13Z-Layout"].SetSettings()
_G[a_name].SetSettings = function()
   local want_values = {
      UnitNameOwn                   = false,
      nameplateShowAll              = true, -- always show nameplates, false - in combat
      PROXY_LARGER_SETTINGS         = true, -- large nameplates
      nameplateShowEnemies          = true,
      nameplateShowEnemyMinions     = true,
      nameplateShowEnemyMinus       = true, -- show minor enemies nameplates
      PROXY_STATUS_TEXT             = 3,  -- Status Text => both
      PROXY_CHAT_BUBBLES            = 1,  -- Chat bubbles => all
      raidFramesDisplayClassColor   = true,
   }

   for setting, value in pairs(want_values) do
      local setting_obj = Settings.GetSetting(setting)
      if setting_obj and setting_obj:GetValue() ~= value then setting_obj:SetValue(value) end
   end
end

local unbind = {
   "TOGGLESOUND", -- toggle sound (not music)
   "NAMEPLATES",  -- toggle enemy nameplates
}

_G[a_name].SetBindings = function()
   for _, binding in pairs(unbind) do
      local key1, key2 = GetBindingKey(binding)
      -- print("bound", binding, key1, key2)
      if key1 then SetBinding(key1, nil) print("unbound", binding, key1) end
      if key2 then SetBinding(key2, nil) print("unbound", binding, key2) end
   end

   for idx = 1,6 do
      SetBinding("LSHIFT-"..idx, "ACTIONPAGE"..idx)
   end
end

-- /run _G["SR13Z-Layout"].EditCurrentLayout()
local first_success
_G[a_name].EditCurrentLayout = function()
   local LDBIcon = LibStub("LibDBIcon-1.0", true)

   if (Details and Details.minimap) then Details.minimap.hide = true end
   if LDBIcon then LDBIcon:Hide("Details") end

   local LibEditModeOverride = LibStub("LibEditModeOverride-1.0")
   _G.LibEditModeOverride = LibEditModeOverride
   LibEditModeOverride:LoadLayouts()

   local ok, err = pcall(function()
      LibEditModeOverride:SetFrameSetting(MicroMenuContainer, Enum.EditModeMicroMenuSetting.EyeSize, 0)
   end)
   if not ok then
      return
   end

   LibEditModeOverride:ReanchorFrame(BagsBar, "BOTTOMRIGHT", MicroMenuContainer, "BOTTOMLEFT", 0, 0)
   LibEditModeOverride:SetFrameSetting(BagsBar, Enum.EditModeBagsSetting.Size, 0)

   LibEditModeOverride:ReanchorFrame(MicroMenuContainer, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 0)

   LibEditModeOverride:SetFrameSetting(MinimapCluster, Enum.EditModeMinimapSetting.Size, 3)
   LibEditModeOverride:ReanchorFrame(MinimapCluster, "TOPRIGHT", UIParent, "TOPRIGHT", 0, 0)

   LibEditModeOverride:ReanchorFrame(BuffFrame,   "TOPRIGHT", MinimapCluster, "TOPLEFT", 0, 0)
   LibEditModeOverride:ReanchorFrame(DebuffFrame, "TOPRIGHT", BuffFrame, "BOTTOMRIGHT", 0, -20)
   LibEditModeOverride:SetFrameSetting(BuffFrame,   Enum.EditModeAuraFrameSetting.IconSize, 3) -- 3 => 80%. At 10% per +-.
   LibEditModeOverride:SetFrameSetting(DebuffFrame, Enum.EditModeAuraFrameSetting.IconSize, 3)

   MinimapBackdrop:SetAlpha(0.2)
   -- /run OverrideActionBar:SetAlpha(0.2)
   -- Minimap ---> move closer to top to reduce size of cluster
   -- 24:00 time => being set in CVars

   LibEditModeOverride:ReanchorFrame(ChatFrame1, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 0, 0)
   -- /f13, set once, do not taint if it's already good => FCF_SetChatWindowFontSize(nil, _G["ChatFrame" .. 1], 13)

   LibEditModeOverride:ReanchorFrame(MainMenuBar, "BOTTOM", UIParent, "BOTTOM", 0, 0)
   LibEditModeOverride:SetFrameSetting(MainMenuBar, Enum.EditModeActionBarSetting.HideBarArt, 1)
   LibEditModeOverride:SetFrameSetting(MainMenuBar, Enum.EditModeActionBarSetting.IconSize, 3) -- 3 => 80%. At 10% per +-.

   ---- !!!!FIX!!!!
   LibEditModeOverride:SetFrameSetting(MultiBarBottomLeft, Enum.EditModeActionBarSetting.IconSize, 3) -- 3 => 80%. At 10% per +-.

   -- Exp/rep/honor tracking bars (BTW, you can program more than two!)
   LibEditModeOverride:ReanchorFrame(MainStatusTrackingBarContainer,      "TOPLEFT", UIParent,                       "TOPLEFT",    0, 0)
   LibEditModeOverride:ReanchorFrame(SecondaryStatusTrackingBarContainer, "TOPLEFT", MainStatusTrackingBarContainer, "BOTTOMLEFT", 0, 7)

   LibEditModeOverride:ReanchorFrame(PlayerFrame, "BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, 80)
   LibEditModeOverride:SetFrameSetting(PlayerFrame, Enum.EditModeUnitFrameSetting.CastBarUnderneath, 1)
   LibEditModeOverride:ReanchorFrame(TargetFrame, "TOPLEFT", PlayerFrame, "TOPRIGHT", 0, 0)

   MinimapCluster.MinimapContainer:ClearAllPoints() MinimapCluster.MinimapContainer:SetPoint("TOP", MinimapCluster, "TOP", 0, -10)


   LibEditModeOverride:ReanchorFrame(PlayerFrame, "BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, 80)

   -- Right managed container
   UIParentRightManagedFrameContainer:ClearAllPoints()
   UIParentRightManagedFrameContainer:SetPoint("TOPRIGHT", -5, -160)

   LibEditModeOverride:ReanchorFrame(DurabilityFrame, "BOTTOMRIGHT", MinimapCluster, "BOTTOMRIGHT", 0, 0)
   LibEditModeOverride:SetFrameSetting(DurabilityFrame, Enum.EditModeDurabilityFrameSetting.Size, 0) -- 0 => 75%. At 5% per +-.
   -- Hook DurabilityFrameMixin:SetAlerts() to show BOTH VehicleSeat and DurabilityFrame + Arena

   local frame = VehicleSeatIndicator
   frame:SetScript("OnShow", nil)
   frame:SetScript("OnHide", nil)
   frame.layoutParent = nil
   frame.ignoreFramePositionManager = true
   frame.isRightManagedFrame = nil
   frame:SetScale(0.5)
   a_env.HookFreezeSetPoint(frame, function(frame, set_point, ...)
      UIParentRightManagedFrameContainer:RemoveManagedFrame(frame)
      frame:ClearAllPoints()
      set_point(frame, "BOTTOMLEFT", MinimapCluster, "BOTTOMLEFT", 0, 0)
   end)

   local frame = UIParentRightManagedFrameContainer
   a_env.HookFreezeSetPoint(frame, function(frame, set_point, ...)
      if InCombatLockdown() then assert(true, "called from combat") return end
      frame:ClearAllPoints()
      set_point(frame, "TOPRIGHT", MinimapCluster, "BOTTOMRIGHT", 0, 37)
   end)

   ObjectiveTrackerFrame:SetScale(0.8)

   LibEditModeOverride:ApplyChanges()
   PetBattleFrame:SetScale(0.70)

   ChatFrame1:SetScale(0.95)

   OverrideActionBar:SetScale(0.70)

   ProfessionsFrame:SetScale(0.90)


   MerchantSellAllJunkButton:SetScript("OnShow", function(self)
      self:SetParent(nil)
      self:ClearAllPoints()
      self:Hide()
   end)

   if Class_ChangeEquipment then TutorialManager:ShutdownTutorial(Class_ChangeEquipment.name) end -- This one is really annoying

   ----- Addons -----
   -- Details!
   if DetailsBaseFrame1 then DetailsBaseFrame1:SetPoint("BOTTOMRIGHT", MicroMenu, "TOPRIGHT") end

   -- Capping
   if CappingFrame then
      CappingFrame:ClearAllPoints()
      CappingFrame:SetPoint("TOPLEFT", SecondaryStatusTrackingBarContainer, "BOTTOMLEFT", 10, 0)
      CappingFrame:SetAlpha(0.4)
   end

   MirrorTimerContainer:Show()

   if not first_success then
      print(a_name .." layout updated.")
      first_success = true
   end

end


-- /run hooksecurefunc(KeybindListener, "ProcessInput", function(self, input) DevTools_Dump(self.pending) DevTools_Dump(input) end)
-- /run KeybindListener.pending = { action = "ACTIONPAGE1", slot = 1 } KeybindListener:ProcessInput("LSHIFT-1")

function FindBinding(needle)
   for bindingIndex = 1, GetNumBindings() do
      local action, cat, binding1, binding2 = GetBinding(bindingIndex)
      if string.find(action, needle) then print(action) end
      local text = _G["BINDING_NAME_" .. action]
      if text and string.find(text, needle) then print(action, text) end
   end
end

print(a_name .." main loaded.")

function a_env.SetupAll()
   _G[a_name].SetCVars()
   _G[a_name].SetSettings()
   _G[a_name].SetBindings()
   _G[a_name].EditCurrentLayout()
end
