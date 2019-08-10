/// @description base music on viggo proximity

var current_music = instance_find(ob_musScripter, 0);
if (exists(current_music) && current_music.object_index != o_mus00_Viggo)
{
	m_initialMusic = current_music.object_index;
}

var viggo = instance_find(o_chViggo, 0);
var pl = getPlayer();

var dist = point_distance(pl.x, pl.y, viggo.x, viggo.y);
if (dist < 60)
{
	if (!exists(o_mus00_Viggo))
	{
		delete(ob_musScripter);
		new(o_mus00_Viggo);
	}
}
else
{
	if (exists(o_mus00_Viggo))
	{
		delete(o_mus00_Viggo);
		new(m_initialMusic);
	}
}