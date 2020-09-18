function effectGetImpactSound(argument0, argument1, argument2) {
	var bloodtype = argument0;
	var damagetype = argument1;
	var attacker = argument2;

	if (damagetype & kDamageTypePiercing)
		return "audio/phys/key_hit_light1.wav";

	return "audio/phys/key_hit_light0.wav";


}
