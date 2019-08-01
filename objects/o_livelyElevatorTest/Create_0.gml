/// @description set up depth & elevation zone

depthInit();

m_elevation = instance_create_depth(x, y, depth, ob_elevationAreaLift);
m_elevation.sprite_index = sc_32x32;