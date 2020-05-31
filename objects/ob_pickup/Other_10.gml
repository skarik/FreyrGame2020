// Create some sort of effect here.

// Play audio
// TODO: Cooldown on this so a ton of them aren't playing
var audio = sound_play_at(x, y, snd_itemPickup);
audio.pitch = random_range(1.25, 1.50);
audio.gain = random_range(0.1, 0.15) / max(1.0, instance_number(audio.object_index) - 5.0);
audio.falloff_start = 20;
audio.falloff_end = 200;
audio.falloff_factor = 1;

// Delete self now that we're done.
idelete(this);