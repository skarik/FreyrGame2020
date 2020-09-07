function damageStunApplyModifiers(argument0, argument1, argument2) {
	//@function damageStunApplyModifiers(target, damage, type)
	//@description Applies damage modifiers within the given object. Returns modded value
	//@param target Target we're damaging
	//@param damage Amount of stun
	//@param type Type of damage

	var target = argument0;
	var stun = argument1;
	var type = argument2;
	with (target)
	{
		var is_character = object_is_ancestor(object_index, ob_character);
	
		// deal heavy stun
		if (is_character)
		{
			if (m_isHeavyFighter)
			{
				stun *= 0.5;
			}
		}
	
		// deal counter stun
		if (is_character)
		{
			if (type & kDamageTypeCounter)
			{
				if (m_isHeavyFighter)
				{	// Do heavy damage instead of the insta-kill
					stun = floor(stats.m_stunMax * 0.5);
				}
				else
				{
					stun = min(stats.m_stunMax, 60);
				}
			}
		}
	
		// TODO: damage type weaknesses & buffs
	}
	return stun;


}
