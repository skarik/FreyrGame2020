/// @description Set sprites and init

kAnimStand = s_charBirdStand;
kAnimFly = s_charBirdFly;
animationIndex = 0.0;

// Init depth
depthInit();
// Update depth
z_height = m_placeHeight;
y += m_placeHeight;
// Get depth now
z = collision3_get_highest_position(x, y, 0);

kBoidStateIdle = 0;
kBoidStateFly = 1;
aiState = kBoidStateIdle;
aiFlyTimer = 0;

xspeed = 0.0;
yspeed = 0.0;
boidDirection = 0.0;
boidDirectionAccel = 0.0;

// Grab perch positions
m_perchX = x;
m_perchY = y;
m_perchZ = z;
m_perchZ_height = z_height;
m_perchFacing = image_xscale;
m_perchProp = place_meeting(x, y, ob_doodad);