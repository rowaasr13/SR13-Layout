local HBD_Pins = LibStub("HereBeDragons-Pins-2.0")
local RSMinimapPinMixin = RSMinimapPinMixin

local function AddMinimapIconMap_hook_AndMakeTrasparent(self, _, pin)
   if pin.OnEnter == RSMinimapPinMixin.OnEnter then pin:SetAlpha(0.4) end
end

hooksecurefunc(HBD_Pins, "AddMinimapIconMap", AddMinimapIconMap_hook_AndMakeTrasparent)
