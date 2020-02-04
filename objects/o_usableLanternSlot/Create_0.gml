/// @description Set up the plug

// Inherit the parent event
event_inherited();

#region Options

m_name = "Ornate Slot";
m_actionName = "Place Lantern";

#endregion

m_lanternPlaced = false;
m_lanternProp = null;
m_gearTockSfx = null;
m_gearTockAmount = 0.0;