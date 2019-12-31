/// @description Create collider & lights

event_inherited();

m_glower = new(o_lightEmissiveDepth_User5);
m_glower.target = id;

m_glowAlpha = 0.0;
m_glowPower = 0.0;

m_light = new(o_lightCrystalSmallNormal);
m_light.image_alpha = 0.0;

m_openBlend = 0.0;

m_collider = new(ob_colliderNoDepth);
m_collider.visible = false;
m_collider.sprite_index = sc_16x16;
m_collider.x = x;
m_collider.y = y;
m_collider.image_xscale = image_xscale * sprite_get_width(sprite_index) / 16.0;
m_collider.image_yscale = 2.0 / 16.0;

depthInit();