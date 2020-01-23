/// @description Setup power effect & depth

// Inherit the parent event
event_inherited();

depthInit();

visual_power = 0.0;
overcharge = 0.0;

/// @description Create glow and set up depth
emissive = new(o_lightEmissiveDepth_User5);
emissive.target = id;