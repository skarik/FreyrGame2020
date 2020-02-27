var sz, i, ret;

switch (sprite_index)
{
	case s_propRock:
	case s_propDRock0:
	case s_propCairn0:
	case s_propCairn1:
	case s_propCairn2:
		sz = choose(1, 2, 3);
		for (i = 0; i < sz; ++i)
			ret[i] = o_pickupJunk_Rock;
		return ret;
}

return null;