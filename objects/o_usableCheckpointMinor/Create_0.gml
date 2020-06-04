/// @description options

// Inherit the parent event
event_inherited();

#region Options

m_name = "Iconolith";
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

drawbuf_set_reflection(false);

m_statePlayerNearby = false;
m_stateInteracting = false;