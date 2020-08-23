/// @description Collectible prop!
event_inherited();

#macro kCollectTypeSimpleUse 0
#macro kCollectTypePlantGrabAnimation 1
#macro kCollectTypeKickShakeAnimation 2

image_speed = 0.0;
image_index = 0;

m_name			= "ob_collectProp";
m_actionName	= "Collect";
m_pickup		= o_pickupRes_Gear;
m_hasCollision	= false;
m_hasShadow		= false;
m_hasWiggle		= false;
m_collectType	= kCollectTypeSimpleUse;

// Extra associated objects
collider = null;

// Set up initial Z
depthInit();
z = collision3_get_highest_position(x, y, 0);

// Values used for the wiggle rendering.
u_spriteCoords = shader_get_uniform(sh_normalTreeWiggle, "u_spriteCoords");
u_spriteTexelCount = shader_get_uniform(sh_normalTreeWiggle, "u_spriteTexelCount");
u_animationValues = shader_get_uniform(sh_normalTreeWiggle, "u_animationValues");
shadow_enabled = false;

alarm[0] = 1; // Delayed init for prop stuff
