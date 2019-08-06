/// @description check pl dist

var pl = getPlayer();
if (exists(pl))
{
	if (point_distance(target.x, target.y, pl.x, pl.y) > 32)
	{
		target.isPassthru = original_state;
		delete(this);
	}
}