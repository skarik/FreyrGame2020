/// @description check pl dist

var pl = getPlayer();
if (iexists(pl))
{
	if (point_distance(target.x, target.y, pl.x, pl.y) > 32)
	{
		target.isPassthru = original_state;
		idelete(this);
	}
}