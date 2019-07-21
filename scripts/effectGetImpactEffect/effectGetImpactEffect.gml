var bloodtype = argument0;
var damagetype = argument1;
var attacker = argument2;
switch (bloodtype)
{
case kBloodRed:
	if (exists(attacker) && attacker.object_index == o_PlayerTest)
		return o_fxBloodHitPunch;
	return o_fxBloodHitRed;
case kBloodRedWill:
	return o_fxBloodHitRedWill;
}
return _dummy;