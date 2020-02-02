/// @description Set up height

// Inherit the parent event
event_inherited();

m_height = 0.0;

m_elevation = instance_create_depth(x, y, depth - 2, ob_elevationAreaLift);
m_elevation.sprite_index = sc_16x16;
m_elevation.mask_index = sc_16x16;
m_elevation.image_xscale = 96 / 16;
m_elevation.image_yscale = (3 + 3) * 16 / 16;
m_elevation.visible = false;
m_elevation.ignore_below = false;

m_collider = instance_create_depth(x, y, depth - 1, ob_colliderDepth);
m_collider.sprite_index = sc_16x16;
m_collider.mask_index = sc_16x16;
m_collider.image_xscale = 96 / 16;
m_collider.image_yscale = 3 + 5;//48 / 16;
m_collider.visible = false;
m_collider.image_blend = c_black;
m_collider.z = 0;