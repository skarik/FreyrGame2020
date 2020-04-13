/// @function worldGameLocationType()
/// @description Is the current main action taking place indoors?

#macro kWorldLocationType_Invalid			(0x00)
#macro kWorldLocationType_Outdoors			(0x01)
#macro kWorldLocationType_OutdoorsMountain	(0x01 | 0x30)
#macro kWorldLocationType_Indoors			(0x02)
#macro kWorldLocationType_IndoorsCave		(0x02 | 0x10)

#macro kWorldLocationType_Bitmask_Cave		(0x10)
#macro kWorldLocationType_Bitmask_Mountain	(0x30)

// TODO: something better than hardcoded, maybe
switch (room)
{
	case rm_oasis_north_cave:
		return kWorldLocationType_IndoorsCave;
	
	default:
		return kWorldLocationType_Outdoors;
}