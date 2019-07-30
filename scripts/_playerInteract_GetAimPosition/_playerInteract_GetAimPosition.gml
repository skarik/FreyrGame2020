/// @function _playerInteract_GetAimPosition(variant, min, max, default)
/// @param variant	Which aiming to use
/// @param min	Min aim distance
/// @param max	Max aim distance
/// @param default Aim distance without mouse

var variant = argument0;
var min_distance = argument1;
var max_distance = argument2;
var default_distance = argument3;

var aim_x = (variant == 0) ? aimingStartX : aiming2StartX;
var aim_y = (variant == 0) ? aimingStartY : aiming2StartY;
var aim_dir = (variant == 0) ? aimingDirection : aiming2Direction;

if (lastControlType == kControlKB || lastControlType == kControlMouse)
{
	// Get aim distance
	var aimDistance = max(min_distance, min(max_distance, point_distance(aim_x, aim_y, uPosition, vPosition)));
	// Point simply
	var aimX = aim_x + lengthdir_x(aimDistance, aim_dir);
	var aimY = aim_y + lengthdir_y(aimDistance, aim_dir);
	
	return [aimX, aimY];
}
else if (lastControlType == kControlGamepad)
{
	// Get aim distance
	var aimDistance = max(min_distance, min(max_distance, default_distance));
	// Point simply
	var aimX = aim_x + lengthdir_x(aimDistance, aim_dir);
	var aimY = aim_y + lengthdir_y(aimDistance, aim_dir);
	
	return [aimX, aimY];
}

return [x, y];