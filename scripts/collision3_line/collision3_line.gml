/// @description collision3_line(x1, y1, x2, y2, z, less_than_only)
/// @param {Real} x1
/// @param {Real} y1
/// @param {Real} x2
/// @param {Real} y2
/// @param {Real} z
/// @param {Boolean} less_than_only

var check_x1 = argument0;
var check_y1 = argument1;
var check_x2 = argument2;
var check_y2 = argument3;
var check_z = argument4;
var falling = argument5;

#region Rasterizer-Based collision checking

col3_internal_query_collision_maps();

var t_collidableLayerCount = array_length_1d(global.collidable_layers);
if (t_collidableLayerCount > 0)
{
	var dx = check_x2 - check_x1;
	var dy = check_y2 - check_y1;
	
	// Create the "slope" to step by when "rasterizing" the line
	var step_divisor = max(abs(dx), abs(dy));
	var mx = dx / step_divisor * 16.0;
	var my = dy / step_divisor * 16.0;
	
	// Some slightly hack-like stuff: to be speedy, this section uses code that would normally remain in ``col3_internal``.
	// Sampling is ordered different here, so the internals code is used here.
	
	var sample_x = check_x1;
	var sample_y = check_y1;
	var step_count = ceil(max(abs(dx / 16.0), abs(dy / 16.0)));

	for (var i_step = 0; i_step < step_count; ++i_step)
	{
		var cel_x = floor(sample_x / 16);
		var cel_y = floor(sample_y / 16);

		for (var i = 0; i < t_collidableLayerCount; ++i)
		{
			var tilemap = global.collidable_layers[i];
			var tile = tilemap_get(tilemap, cel_x, cel_y);
			var tile_id = tile & 0xFF;
			var tile_elevation;
			
			// Collision tile? Then it a meeting.
			if (tile_id == 1)
				return true;
				
			// Check for elevation colliders
			tile_elevation = kElevationInvalid;
			if (tile_id >= 32 && tile_id < 48)
				tile_elevation = (tile_id - 32) * 16;
			else if (tile_id >= 64 && tile_id < 80)
				tile_elevation = (tile_id - 64) * -16;
			if (tile_elevation != kElevationInvalid)
			{
				var area_z = tile_elevation + 8;
				if (falling ? (area_z > check_z + 4) : (abs(area_z - check_z) > 4))
					return true;
			}
			
			// Check for elevation zones - we'll skip this for now since this depends on overlapping tile data.
			tile_elevation = kElevationInvalid;
			if (tile_id >= 16 && tile_id < 32)
			{
				tile_elevation = (tile_id - 16) * 16;
			}
			else if (tile_id >= 48 && tile_id < 64)
			{
				tile_elevation = (tile_id - 48) * -16;
			}
			if (tile_elevation != kElevationInvalid)
			{
				var area_z = tile_elevation;
				if (falling ? (area_z > check_z + 4) : (abs(area_z - check_z) > 4))
					return true;
			}
		}

		// Go to next sample position
		sample_x += mx;
		sample_y += my;
	}
}

#endregion

#region Object-Based collision checking

// Check for all colliders at the given area
if (iexists(collision_line(check_x1, check_y1, check_x2, check_y2, ob_colliderNoDepth, false, true)))
{
	return true;
}

// Check for elevation colliders
if (iexists(ob_colliderDepth))
{
	var results_colliders = ds_list_create();
	var results_colliders_num = collision_line_list(check_x1, check_y1, check_x2, check_y2, ob_colliderDepth, false, true, results_colliders, false);
	for (var i = 0; i < results_colliders_num; ++i)
	{
		var collider = results_colliders[|i];
		var collider_z = collider.z;
		var collider_z_height = collider.z_height;
		if (collider_z + collider_z_height > check_z + 4)
		{
			ds_list_destroy(results_colliders);
			return true;
		}
	}
	ds_list_destroy(results_colliders);
}

// Check if ignoring elevation
if (iexists(collision_line(check_x1, check_y1, check_x2, check_y2, ob_elevationBlendArea, false, true)))
{
	return false;
}

// Check for all transition zones at the given area
if (iexists(ob_elevationArea))
{
	var results = ds_list_create();
	var results_num = collision_line_list(check_x1, check_y1, check_x2, check_y2, ob_elevationArea, false, true, results, false);
	// Find the one with the highest z
	var area_z_max = -1024;
	for (var i = 0; i < results_num; ++i)
	{
		var area_z = results[|i].z;
		area_z_max = max(area_z_max, area_z);
	}
	// Loop through all of them to check collision
	for (var i = 0; i < results_num; ++i)
	{
		var area_z = results[|i].z;
		if (area_z != area_z_max) continue;
		if (falling ? (area_z > check_z + 4) : (abs(area_z - check_z) > 4))
		{
			ds_list_destroy(results);
			return true;
		}
	}
	ds_list_destroy(results);
}

#endregion

// No collision
return false;