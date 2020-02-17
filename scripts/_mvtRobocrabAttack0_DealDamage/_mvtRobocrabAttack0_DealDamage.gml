/// @script _mvtRobocrabAttack0_DealDamage(interval)
/// @param interval {Real}

var interval = argument0;

// Check first trapezoid for damage
var trap_x = [x + lengthdir_x(beamAtkWidth, aimingDirection - 90) + lengthdir_x(beamAtkRanges[interval], aimingDirection - beamAtkAngleOff),
			  x + lengthdir_x(beamAtkWidth, aimingDirection + 90) + lengthdir_x(beamAtkRanges[interval], aimingDirection + beamAtkAngleOff),
			  x + lengthdir_x(beamAtkWidth, aimingDirection - 90) + lengthdir_x(beamAtkRanges[interval+1], aimingDirection - beamAtkAngleOff),
			  x + lengthdir_x(beamAtkWidth, aimingDirection + 90) + lengthdir_x(beamAtkRanges[interval+1], aimingDirection + beamAtkAngleOff)];
var trap_y = [y + lengthdir_y(beamAtkWidth, aimingDirection - 90) + lengthdir_y(beamAtkRanges[interval], aimingDirection - beamAtkAngleOff),
			  y + lengthdir_y(beamAtkWidth, aimingDirection + 90) + lengthdir_y(beamAtkRanges[interval], aimingDirection + beamAtkAngleOff),
			  y + lengthdir_y(beamAtkWidth, aimingDirection - 90) + lengthdir_y(beamAtkRanges[interval+1], aimingDirection - beamAtkAngleOff),
			  y + lengthdir_y(beamAtkWidth, aimingDirection + 90) + lengthdir_y(beamAtkRanges[interval+1], aimingDirection + beamAtkAngleOff)];
var character_num = instance_number(ob_character);
for (var i = 0; i < character_num; ++i)
{
	var target = instance_find(ob_character, i);
	if (damageCanHit(this, target))
	{
		var bbox = [target.bbox_left,
					target.bbox_top,
					target.bbox_right,
					target.bbox_bottom];
						
		if (rectangle_in_triangle(bbox[0], bbox[1], bbox[2], bbox[3],
								  trap_x[0], trap_y[0], trap_x[1], trap_y[1], trap_x[2], trap_y[2]) != 0 ||
			rectangle_in_triangle(bbox[0], bbox[1], bbox[2], bbox[3],
								  trap_x[3], trap_y[3], trap_x[1], trap_y[1], trap_x[2], trap_y[2]) != 0)
		{	// deal damage
			damageTarget(target, 4, kDamageTypeBullet | kDamageTypeMagicVoid, true, true);
		}
	}
}