var target = argument0;
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
else
	target = null;
	
return target;
