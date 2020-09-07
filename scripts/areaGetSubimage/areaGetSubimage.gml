function areaGetSubimage(argument0) {
	var area = argument0;

	switch (area)
	{
		case kAreaOasis:
			return 1;
		
		case kAreaFoolsMarch:
			return 0;
		
		case kAreaLibrary:
			return null;
	}

	return null;


}
