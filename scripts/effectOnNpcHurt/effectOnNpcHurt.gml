///@function effectOnNpcHurt(npc)
///@param npc

var npc = argument0;
var sound;

switch (npc.object_index)
{
case o_chGobboTest:
	sound = sound_play_at(npc.x, npc.y, snd_npcGobboHurt1);
	sound.pitch = random_range(0.95, 1.1) * 1.2;
	sound.gain = random_range(0.7, 0.9) * 0.5;
	sound.falloff_start = 20;
	sound.falloff_end = 800;
	sound.falloff_factor = 1;
	sound.parent = npc;
	return sound;
}