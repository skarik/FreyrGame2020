/// @description Update tracked object elevations

var delta_x, delta_y, delta_z;

// Update Z to the requested value
z = z_requested;
// Calculate needed Z motion
delta_z = z - z_previous;

// Update XY to requested value & calculate 2D motion
delta_x = x_requested - x_previous;
x = x_requested;
delta_y = y_requested - y_previous;
y = y_requested + y_requestedOffset;

// Update the tracked object list
tracked_objects = array_create(0);
var platform = id;
with (ob_character)
{
	if (place_meeting(x, y, platform))
	{
		if (!platform.ignore_below || z + 6 >= platform.z)
			platform.tracked_objects[array_length_1d(platform.tracked_objects)] = id;
	}
}

// Update the tracked objects (if they're close to the ground)
var tracked_object_count = array_length_1d(tracked_objects);
for (var i = 0; i < tracked_object_count; ++i)
{
	var tracked_object = tracked_objects[i];
	if (max(z, z_requested) + 2 > tracked_object.z)
	{
		// Update Z coordinates
		tracked_objects[i].z += delta_z;
		tracked_objects[i].y -= delta_z;
		
		// Update XY coordinates
		tracked_objects[i].x += delta_x;
		tracked_objects[i].y += delta_y;
	}
}

// Save the previous positions now that we've done calculations
x_previous = x;
y_previous = y - y_requestedOffset;
z_previous = z;