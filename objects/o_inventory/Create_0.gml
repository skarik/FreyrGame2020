/// @description Initialize empty belt

belt_size = 6;
for (var i = 0; i < belt_size; ++i)
{
	belt_object[i] = null
	belt_count[i] = 0;
	belt_name[i] = "";
	belt_checkUse[i] = nullScript;
	belt_onUse[i] = nullScript;
}

belt_selection = 0;