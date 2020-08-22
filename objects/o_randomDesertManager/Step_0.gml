/// @description Update the desert

// Update the fallback collision
m_elevationFallback.x = GameCamera.x - 16 * m_elevationFallback.image_xscale;
m_elevationFallback.y = GameCamera.y - 16 * m_elevationFallback.image_yscale;

#macro kiProcRoomId 0
#macro kiProcBBox 1
#macro kiProcVisited 2
#macro kiProcLayers 3
#macro kiProcInstances 4

// remove anything too far away

// remove anything visited and now out of screen

// try to generate anything out of screen view but not too far away
if (!ds_list_empty(allRooms))
{
	
}
// create an initial random room nearby the player
else
{
	var screenBBox = abbox_create(GameCamera.view_x, GameCamera.view_y, GameCamera.width, GameCamera.height);
	
	for (var i = 0; i < 10; ++i)
	{
		var iRoomSelection = floor(random(array_length_1d(possibleRooms)));
	
		var nextRoomBBox = possibleRoomBbox[iRoomSelection];
		var nextRoomPosition = [x + random_range(-nextRoomBBox[2], +nextRoomBBox[2]) * 2.0,
								y + random_range(-nextRoomBBox[3], +nextRoomBBox[3]) * 2.0];
		nextRoomPosition = avec2_subtract(nextRoomPosition, abbox_center(possibleRoomBbox[iRoomSelection]));
		nextRoomPosition = avec2_divide(nextRoomPosition, 16);
		nextRoomPosition[0] = floor(nextRoomPosition[0]) * 16;
		nextRoomPosition[1] = floor(nextRoomPosition[1]) * 16;
		
		nextRoomBBox = abbox_create(nextRoomPosition[0], nextRoomPosition[1], nextRoomBBox[2], nextRoomBBox[3]);
		
		if (!abbox_collides(screenBBox, nextRoomBBox))
		{
			// Create the room at the given position
			procGenDesertAddRoom(nextRoomPosition, iRoomSelection);
			// Exit the add loop
			break;
		}
	}
}