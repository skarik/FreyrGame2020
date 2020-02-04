/// @description Create the needed objects

event_inherited();

m_openBlend = 0.0;

m_collider = new(ob_colliderNoDepth);
m_collider.visible = false;
m_collider.sprite_index = sc_16x16c;
m_collider.mask_index = sc_16x16c;
m_collider.x = x;
m_collider.y = y;
m_collider.image_xscale = sprite_width / 16.0;
m_collider.image_yscale = 8.0 * image_yscale / 16.0;

depthInit();