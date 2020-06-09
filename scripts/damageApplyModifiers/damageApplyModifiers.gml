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
	var is_character = object_is_ancestor(object_index, ob_character);
	
	// unarmed attacks do less damage when not stunned
	if (type & kDamageTypeUnarmed)
	{
		if (is_character && !m_isStunned)
		{
			damage = ceil(damage * 0.5);
		}
	}
	
	// bonus damage on stun
	if (is_character && m_isStunned)
	{
		if (type & kDamageTypeUnarmed)
			damage = damage * 6.0;
		else
			damage = damage * 3.0;
	}
	
	// reduce damage on blocks
	if (is_character && isBlocking)
	{
		damage = floor(damage * 0.25);
	}
	
	// deal counter damage
	if (is_character)
	{
		if (type & kDamageTypeCounter)
		{
			damage = min(stats.m_healthMax, 60);
		}
	}
	
	// TODO: damage type weaknesses & buffs
}
return damage;