/// @description Options

// Inherit the parent event
event_inherited();

#region Options

m_name = "Outhouse";

m_doorOpenMode = kDoorOpenModeOnlyDown;
m_doorMaxAngle = 130;

#endregion

#region Rendering options

m_door_texel_left = 6;
m_door_texel_width = 20;
m_door_texel_top = 33;
m_door_texel_height = 30;

m_door_width = m_door_texel_width;
m_door_height = m_door_texel_height;
m_door_thickness = 1;

m_door_renderFrameBelow = true;
m_door_renderFrameAbove = false;

#endregion