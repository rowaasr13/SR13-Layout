local Main = LibStub('AceAddon-3.0'):GetAddon('TalentTreeTweaks')
local Module = Main:GetModule('ScaleTalentFrame')

local function DisableBlizzMoveDetect(self) self.blizzMoveEnabled = nil end
hooksecurefunc(Module, "GetOptions", DisableBlizzMoveDetect)
DisableBlizzMoveDetect(Module)

