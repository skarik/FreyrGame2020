/// @description set pos & update scale

if (iexists(o_PlayerHud))
{
	depth = o_PlayerHud.depth + 2;
}
if (iexists(m_target))
{
	x = m_target.x;
	y = m_target.y - m_target.sprite_height;
}

if (m_fadestate == 0)
{
	if (m_fade <= 0.0)
	{
		// make sound
		var sound = null;
		
		if (image_index == 1)
			sound = sound_play_at(x, y, "audio/npc/notice.wav");
			
		if (sound != null)
		{
			sound.pitch = random_range(0.95, 1.1);
			sound.gain = random_range(0.7, 0.9) * 0.7;
			sound.falloff_start = 20;
			sound.falloff_end = 800;
			sound.falloff_factor = 1;
			sound.parent = id;
		}
	}
	
	image_yscale = elasticOut(saturate(m_fade * 1.0));
	y -= sin(m_fade * 5.0) * 6.0 * (1.0 - m_fade);
	
	m_fade += Time.deltaTime * 4.0;
	if (m_fade >= 1.0)
	{
		m_fade = 1.0;
		m_fadestate = 1;
	}
}
else if (m_fadestate == 1)
{
	m_fadeWait += Time.deltaTime;
	if (m_fadeWait >= 1.0)
	{
		m_fadestate = 2;	
	}
}
else if (m_fadestate == 2)
{
	image_xscale = smoothstep(saturate(m_fade));
	
	m_fade -= Time.deltaTime * 4.0;
	if (m_fade <= 0.0)
	{
		idelete(this);
	}
}