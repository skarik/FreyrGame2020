/// @description Create collider & lights

event_inherited();

/*m_glower = inew(o_lightEmissiveDepth_User5);
m_glower.target = id;

m_glowAlpha = 0.0;
m_glowPower = 0.0;

m_light = inew(o_lightCrystalSmallNormal);
m_light.image_alpha = 0.0;*/

m_openBlend = 0.0;

m_collider = inew(ob_colliderNoDepth);
m_collider.visible = false;
m_collider.sprite_index = sc_16x16;
m_collider.x = x - image_xscale * 4.0;
m_collider.y = y;
m_collider.image_xscale = image_xscale * 4.0 / 16.0;
m_collider.image_yscale = sprite_height / 16.0;

depthInit();