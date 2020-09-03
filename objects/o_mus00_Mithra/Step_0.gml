/// @description set music

var pl = getPlayer();

m_fadeSpeed = 2.0;

// Zero out all volumes first:
for (var i = 0; i < array_length_1d(m_tracks); ++i)
{
	m_trackVolume[i] = 0.0;
}

// Query current state
var bHaveHostileGuards = false;

if (room == rm_mithra)
{
	m_trackVolume[0] = 1.0;
}
else if (room == rm_mithra_church)
{
	m_trackVolume[1] = 1.0;
}

// Do ducking
var ducking = 0.0;
with (o_wmus_mithraTavern)
{
	var pl_dist = point_distance(x, y, pl.x, pl.y);
	var gradient = saturate((pl_dist - m_sound.falloff_start) / (m_sound.falloff_end - m_sound.falloff_start));
	gradient = power(gradient, m_sound.falloff_factor * 2.0);
	ducking = max(ducking, 1.0 - gradient);
}

for (var i = 0; i < array_length_1d(m_tracks); ++i)
{
	m_trackVolume[i] *= 1.0 - ducking;
}

event_inherited();