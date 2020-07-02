event_inherited();

#region Options

m_name = "Usable Trigger";
m_actionName = "Use";
/*m_canPickUp = false;
m_isSuperHeavy = false;
m_canThrow = false;
m_airFriction = 100;
m_usable = true;*/

#endregion

#region Visuals & Behavior

m_drawShadowed = true;
m_drawDepth = true;

m_collision = instance_create_depth(x, y, 0, ob_colliderNoDepth);
m_collision.sprite_index = sprite_index;
m_collision.mask_index = sprite_index;
m_collision.image_xscale = image_xscale;
m_collision.image_yscale = image_yscale;
m_collision.image_angle = image_angle;
m_collision.visible = false;

depthInit();

#endregion

/*#region Internal State

image_speed = 0;
image_index = 0;

m_user = null;
m_isPickedUp = false;
xspeed = 0;
yspeed = 0;

#endregion*/