/// @description Ensure player exists

var pl = getPlayer();
if (!iexists(pl) || pl.moScriptOverride != _playerMotionGrapple)
{
	exit;
}

draw_set_color(c_gold);
draw_circle(pl.moGrapple_hookX, pl.moGrapple_hookY, 4, false);
draw_line(pl.x, pl.y - 16, pl.moGrapple_hookX, pl.moGrapple_hookY);