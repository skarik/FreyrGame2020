var target = argument0;
if (!is_undefined(target))
	target = string_lower(target);

if (is_undefined(target))
	target = null;
else if (target == "imp")
	target = o_PlayerImp;
else if (target == "hero" || target == "player" || target == "idiot")
	target = o_PlayerTest;
else if (target == "nathan")
	target = o_chNathan;
else if (target == "viggo")
	target = o_chViggo;
else if (target == "old")
	target = o_chOld;
else if (target == "poppy")
	target = o_chPoppy;
else if (target == "sammy" || target == "sam" || target == "samuel")
	target = o_chSamuel;
// Otherwise, might be a numeric target
else if (string_length(string_digits(target)) > 0)
	target = real(string_digits(target)) + SEQI_TARGET_OFFSET_INDEX;
// Otherwise, no target
else
	target = null;
	
return target;
