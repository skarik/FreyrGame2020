/// @description base music on viggo proximity

/*var current_music = instance_find(ob_musScripter, 0);
if (iexists(current_music) && current_music.object_index != o_mus00_Viggo)
{
	m_initialMusic = current_music.object_index;
}

var viggo = instance_find(o_chViggo, 0);
var pl = getPlayer();

var dist = point_distance(pl.x, pl.y, viggo.x, viggo.y);
if (dist < 60)
{
	if (!iexists(o_mus00_Viggo))
	{
		idelete(ob_musScripter);
		inew(o_mus00_Viggo);
	}
}
else
{
	if (iexists(o_mus00_Viggo))
	{
		idelete(o_mus00_Viggo);
		inew(m_initialMusic);
	}
}*/
// managed elsewhere