/// @description move audio to parent position

if (iexists(parent))
{
	x = parent.x;
	y = parent.y;
	audio_emitter_position(m_emitter, x, y, 0);
}