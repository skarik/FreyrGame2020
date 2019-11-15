/// @description Post-creation.
//
// Everything is set up at this point.
// The lively initializer, livelySetupFloaters() calls this after all objects have been recorded.
//

// We need to change all our elevations into lively elevations
var elevationCount = array_length_1d(elevationSources);

for (var i = 0; i < elevationCount; ++i)
{
	var area = elevationSources[i];
	
	elevationLifts[i] = new(ob_elevationAreaLift);
	elevationLifts[i].x = area.x;
	elevationLifts[i].y = area.y;
	elevationLifts[i].sprite_index = area.sprite_index;
	elevationLifts[i].mask_index = area.mask_index;
	elevationLifts[i].image_xscale = area.image_xscale;
	elevationLifts[i].image_yscale = area.image_yscale;
	elevationLifts[i].image_angle = area.image_angle;
	elevationLifts[i].z = area.z;
	elevationLifts[i].z_requested = area.z;
	elevationLifts[i].z_previous = area.z;
	elevationLifts[i].visible = false;
	
	elevationLiftsRefZ[i] = area.z;
	elevationLiftsRefY[i] = area.y;
	
	instance_deactivate_object(area);
}