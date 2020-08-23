/// @description Set up

initialized = false;

firstFrame = true;

// Only allow single
if (instance_number(object_index) > 1)
{
	idelete(this);
	exit;
}

possibleRooms = [rmPCG_desert0];
possibleRoomBbox = [];
possibleRoomLink = [];

// loop through rooms, checking for all transition objects & storing info
for (var i = 0; i < array_length_1d(possibleRooms); ++i)
{
	possibleRoomBbox[i] = procRoomGetBBox(possibleRooms[i]);
	possibleRoomLink[i] = procRoomGetTransitions(possibleRooms[i]);
}

// We need to update global.collidable_layers to have the fallback elevation.
// Later: update global.collidable_layers to contain the various new collision layers

allRooms = ds_list_create();

m_elevationFallback = inew(o_e32x32_e0);
m_elevationFallback.image_xscale = 500.0;
m_elevationFallback.image_yscale = 500.0;

initialized = true;