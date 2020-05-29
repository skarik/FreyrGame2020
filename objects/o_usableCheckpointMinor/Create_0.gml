/// @description options

// Inherit the parent event
event_inherited();

#region Options

m_name = "Anchor";
m_actionName = "Touch";
m_canPickUp = false;
m_isSuperHeavy = false;
m_canThrow = false;
m_airFriction = 100;

#endregion

m_collider = inew(ob_collider);
m_collider.visible = false;
m_collider.sprite_index = sprite_index;
m_collider.mask_index = sprite_index;
m_collider.x = x;
m_collider.y = y;