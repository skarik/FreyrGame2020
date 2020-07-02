/// @description Default door options

// Inherit the parent event
event_inherited();

#region Options

m_name = "Door";
m_actionName = "Open";

#macro kDoorOpenModeNormal 0
#macro kDoorOpenModeOnlyDown 1
#macro kDoorOpenModeOnlyUp 2

m_doorOpenMode = kDoorOpenModeNormal;
m_doorMaxAngle = 70;

#endregion

#region Rendering options

m_door_texel_left = 4;
m_door_texel_width = 24;
m_door_texel_top = 9;
m_door_texel_height = 38;

m_door_width = m_door_texel_width;
m_door_height = m_door_texel_height;
m_door_thickness = 2;

m_door_renderFrameBelow = false;
m_door_renderFrameAbove = false;

#endregion

#region State

m_doorAngle = 0.0;
m_doorAngleMotion = 0;
m_doorAngleTarget = 0.0;
m_doorAngleStart = 0.0;

#endregion

depthInit();
depthUpdate();

/*
#region Options

m_name = "Usable Object";
m_actionName = "Inspect";
m_canPickUp = false;
m_isSuperHeavy = false;
m_canThrow = false;
m_airFriction = 100;
m_usable = true;

#endregion

#region Internal State

image_speed = 0;
image_index = 0;

m_user = null;
m_isPickedUp = false;
xspeed = 0;
yspeed = 0;

#endregion
*/