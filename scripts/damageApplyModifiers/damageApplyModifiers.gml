//@function damageApplyModifiers(target, damage, type)
//@description Applies damage modifiers within the given object. Returns modded value
//@param target Target we're damaging
//@param damage Amount of damage
//@param type Type of damage

var target = argument0;
var damage = argument1;
var type = argument2;
with (target)
{
	if (isBlocking)
	{
		damage = floor(damage) * 0.25;
	}
	// TODO: damage type weaknesses & buffs
}
return damage;