function areaFromRoom(argument0) {
	var current_room = argument0;

	switch (current_room)
	{
		case rm_oasis_farm:
		case rm_oasis_town:
			return kAreaOasis;
		
		case rm_fools_march:
			return kAreaFoolsMarch;
	}

	return kAreaNoArea;


}
