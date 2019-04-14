/// @description follow player
if (!exists(ob_CtsTalker))
{
	var followTarget = o_PlayerTest;
	var followDistance = point_distance(x, y, followTarget.x, followTarget.y);
	if (followDistance > 60)
	{
		var followDirection = point_direction(x, y, followTarget.x, followTarget.y);
		
		xspeed = lengthdir_x(120, followDirection);
		yspeed = lengthdir_y(120, followDirection);
	}
	else
	{
		xspeed = 0;
		yspeed = 0;
	}
}


x += xspeed * Time.deltaTime;
y += yspeed * Time.deltaTime;