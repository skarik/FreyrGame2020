/// @function aimotionMoveTo(x, y, speed_percent)
/// @param xdir	xpos to look at
/// @param ydir	ypos to look at
/// @param speed_percent	at which we change angle
function aimotionMoveAt(argument0, argument1, argument2) {

	var tx = argument0;
	var ty = argument1;
	var tspeed = argument2;

	_controlStructUpdate(xAxis, tx * tspeed);
	_controlStructUpdate(yAxis, ty * tspeed);


}
