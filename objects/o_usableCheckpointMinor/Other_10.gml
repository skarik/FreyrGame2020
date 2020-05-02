/// @description Default inspection
var pl = getPlayer();
if (m_usable && exists(m_user) && m_user.id == pl.id)
{
	/*if (!exists(ob_CtsTalker))
	{
		ctsMakeGabber(m_user, "Self", "It's a $b" + m_name + "$$.");
		with (m_user) controlZero(true);
		with (m_user) canMove = false;
		new(o_CtsReenablePlayerOnCtsEnd);
	}*/
	
	// play audio
	var audio = sound_play_at(x, y, snd_CheckpointClassic);
	
	// heal player
	pl.stats.m_health = pl.stats.m_healthMax;
	
}