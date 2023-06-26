if not LibStub then return end
local AceAddon = LibStub("AceAddon-3.0", "silent")
if not AceAddon then return end
local Simulationcraft = AceAddon:GetAddon("Simulationcraft", "silent")
if not Simulationcraft then return end

Simulationcraft.db.profile.minimap.hide = true
Simulationcraft:UpdateMinimapButton()
