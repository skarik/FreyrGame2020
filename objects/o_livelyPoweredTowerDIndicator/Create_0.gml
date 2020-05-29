/// @description Setup power effect & depth

// Inherit the parent event
event_inherited();

depthInit();

visual_power = 0.0;
visual_charge_speed = random_range(0.9, 1.2);

overcharge = 0.0;
overcharge_ptc_counter = 0.0;

broken = false; // triggered by the overcharge

/// @description Create glow and set up depth
emissive = inew(o_lightEmissiveDepth_User5);
emissive.target = id;