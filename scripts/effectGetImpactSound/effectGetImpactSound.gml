var bloodtype = argument0;
var damagetype = argument1;
var attacker = argument2;

if (damagetype & kDamageTypePiercing)
	return snd_physKeyHitLight1;

return snd_physKeyHitLight0;