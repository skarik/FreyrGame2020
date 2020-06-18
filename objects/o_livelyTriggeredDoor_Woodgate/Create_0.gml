/// @description Set up woodgate

// Door common
m_openBlend = m_startClosed ? 0.0 : 1.0;
m_wantsOpen = m_startClosed;
m_moving = false;
m_queueMoving = false;
m_queueWantsOpen = false;

// Drawing settings:
door_startpoint = [x, y];
door_endpoint = [x + lengthdir_x(sprite_width, image_angle), y + lengthdir_y(sprite_width, image_angle)];
door_divCount = ceil(sqrt(sqr(door_startpoint[0] - door_endpoint[0]) + 0.25 * sqr(door_startpoint[1] - door_endpoint[1])) / 5);

kGateMargin = 8;
kGateHeight = 64;
kGateTravel = 64;

target_size = [abs(door_startpoint[0] - door_endpoint[0]), abs(door_endpoint[1] - door_startpoint[1])];
// Increase Y-size by the height of the gate & by the Y motion of the gate
target_size[1] += kGateHeight;
target_size[1] += kGateTravel;
target_size[0] += kGateMargin * 2;
target_size[1] += kGateMargin * 2;

target_drawoffset = [-x + kGateMargin, -y + kGateHeight + kGateTravel + kGateMargin]; // World origin to target origin
target_worldoffset = [-kGateMargin, -(kGateHeight + kGateTravel + kGateMargin)];

if (door_endpoint[0] < door_startpoint[0])
{
	target_drawoffset[0] += door_startpoint[0] - door_endpoint[0];
	target_worldoffset[0] -= door_startpoint[0] - door_endpoint[0];
}

target_buffer = null;

// Collider for the door
m_collider = inew(ob_colliderNoDepth);
m_collider.visible = false;
m_collider.sprite_index = sprite_index;
m_collider.x = x;
m_collider.y = y;
m_collider.image_xscale = image_xscale;
m_collider.image_yscale = image_yscale;
m_collider.image_angle = image_angle;

if (!m_startClosed)
{
	instance_deactivate_object(m_collider);
}