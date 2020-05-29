/// @description Set up depth & elevation zone

event_inherited();

depthInit();

m_elevation = instance_create_depth(x, y, depth, ob_elevationAreaLift);
m_elevation.sprite_index = sc_16x16c;
m_elevation.mask_index = sc_16x16c;
m_elevation.image_xscale = 48 / 16;
m_elevation.image_yscale = 48 / 16;
m_elevation.visible = false;
m_elevation.ignore_below = true;

z = m_zBase;
z_height = m_zHeight;

m_emissive = inew(o_lightEmissiveDepth_User5);
m_emissive.target = id;
m_emissive.mask = false;

m_lightingPower = 0.0;


// train state
m_currentPathNode = null;
m_waitingForRider = false;
m_waitingForRiderIgnoreWeight = false;
m_waitingForRiderDelay = 0.0;
m_waitingForNode = false;
m_waitingForNodeTime = 0.0;