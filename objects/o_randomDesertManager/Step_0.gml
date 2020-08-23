/// @description Update the desert

var pl = getPlayer();
var screenBBox = abbox_create(GameCamera.view_x, GameCamera.view_y, GameCamera.width, GameCamera.height);

// Move the player far away on first frame
if (firstFrame)
{
	pl.y = 10000;
	firstFrame = false;
	
	exit;
}

// Update the fallback collision
m_elevationFallback.x = GameCamera.x - 16 * m_elevationFallback.image_xscale;
m_elevationFallback.y = GameCamera.y - 16 * m_elevationFallback.image_yscale;

#macro kiProcRoomId 0
#macro kiProcBBox 1
#macro kiProcVisited 2
#macro kiProcLayers 3
#macro kiProcInstances 4
#macro kiProcRoomIndex 5
#macro kiProcCollisionMaps 6

// remove anything too far away
for (var i = 0; i < ds_list_size(allRooms); ++i)
{
	var roomInfo = allRooms[|i];
	
	var roomBBox = roomInfo[kiProcBBox];
	var roomCenter = abbox_center(roomBBox);
	
	var roomCenterDelta = avec2_subtract(roomCenter, [GameCamera.x, GameCamera.y]);
	var roomCenterDeltaLen = avec2_length(roomCenterDelta);
	if (roomCenterDeltaLen > 3000)
	{
		// Remove room's everything
		procGenDesertRemoveRoom(roomInfo);
		
		// Remove room from list
		ds_list_delete(allRooms, i);
		i--;
		continue;
	}
}

// remove anything visited and now out of screen
for (var i = 0; i < ds_list_size(allRooms); ++i)
{
	var roomInfo = allRooms[|i];
	// Room not visited? Check if player is inside of it.
	if (!roomInfo[kiProcVisited])
	{
		if (abbox_contains(roomInfo[kiProcBBox], [pl.x, pl.y]))
		{
			roomInfo[kiProcVisited] = true;
		}
		allRooms[|i] = roomInfo;
	}
	// Already visited, if out of view, we destroy it.
	else 
	{
		if (!abbox_collides(roomInfo[kiProcBBox], screenBBox))
		{
			// Remove room's everything
			procGenDesertRemoveRoom(roomInfo);
		
			// Remove room from list
			ds_list_delete(allRooms, i);
			i--;
			continue;
		}
	}
}

// try to generate anything out of screen view but not too far away
if (!ds_list_empty(allRooms))
{
	for (var i = 0; i < ds_list_size(allRooms); ++i)
	{
		var roomInfo = allRooms[|i];
		
		// Skip if too far
		var roomBBox = roomInfo[kiProcBBox];
		var roomCenter = abbox_center(roomBBox);
		var roomCenterDelta = avec2_subtract(roomCenter, [GameCamera.x, GameCamera.y]);
		var roomCenterDeltaLen = avec2_length(roomCenterDelta);
		if (roomCenterDeltaLen > 2000)
			continue;
		
		// Choose one of the connections:
		var connections = possibleRoomLink[roomInfo[kiProcRoomIndex]];
		var connectionChoice = floor(random(array_length_1d(connections)));
		var connection = connections[connectionChoice];
		
		// Select rooms with matching connectors
		var compatibleRooms = [];
		for (var iRoom = 0; iRoom < array_length_1d(possibleRooms); ++iRoom)
		{
			if (array_contains(possibleRoomLink[iRoom], -connection))
			{
				compatibleRooms[array_length_1d(compatibleRooms)] = iRoom;
			}
		}
		
		if (array_length_1d(compatibleRooms) > 0)
		{
			// Now check if something can be placed there:
			var iRoomSelection = compatibleRooms[floor(random(array_length_1d(compatibleRooms)))];
			
			var thisRoomBBox = roomInfo[kiProcBBox];
			
			var nextRoomBBox = possibleRoomBbox[iRoomSelection];
			var nextRoomPosition = [thisRoomBBox[0], thisRoomBBox[1]];
			
			// Update position based on the connection
			if (connection == kCDirectionLeft)
			{
				nextRoomPosition[0] -= nextRoomBBox[2];
			}
			else if (connection == kCDirectionRight)
			{
				nextRoomPosition[0] += thisRoomBBox[2];
			}
			else if (connection == kCDirectionUp)
			{
				nextRoomPosition[1] -= nextRoomBBox[3];
			}
			else if (connection == kCDirectionDown)
			{
				nextRoomPosition[1] += thisRoomBBox[3];
			}
			
			// Now create the room
			nextRoomBBox = abbox_create(nextRoomPosition[0] + 1, nextRoomPosition[1] + 1, nextRoomBBox[2] - 2, nextRoomBBox[3] - 2);
			
			// Ensure room not in the screen
			if (!abbox_collides(screenBBox, nextRoomBBox))
			{
				// Loop through all the rooms and check we're not overlapping with them
				var bHasCollision = false;
				for (var i = 0; i < ds_list_size(allRooms); ++i)
				{
					var roomInfo = allRooms[|i];
					if (abbox_collides(roomInfo[kiProcBBox], nextRoomBBox))
					{
						bHasCollision = true;
						break;
					}
				}
				
				// We can add the room.
				if (!bHasCollision)
				{
					// Create the room at the given position
					procGenDesertAddRoom(nextRoomPosition, iRoomSelection);
					// Exit the add loop
					break;
				}
			}
		} // End have compatible room
	}
}
// create an initial random room nearby the player
else
{
	for (var i = 0; i < 10; ++i)
	{
		var iRoomSelection = floor(random(array_length_1d(possibleRooms)));
	
		var nextRoomBBox = possibleRoomBbox[iRoomSelection];
		var nextRoomPosition = [GameCamera.x + random_range(-nextRoomBBox[2], +nextRoomBBox[2]) * 2.0,
								GameCamera.y + random_range(-nextRoomBBox[3], +nextRoomBBox[3]) * 2.0];
		nextRoomPosition = avec2_subtract(nextRoomPosition, abbox_center(possibleRoomBbox[iRoomSelection]));
		nextRoomPosition = avec2_divide(nextRoomPosition, 16);
		nextRoomPosition[0] = floor(nextRoomPosition[0]) * 16;
		nextRoomPosition[1] = floor(nextRoomPosition[1]) * 16;
		
		nextRoomBBox = abbox_create(nextRoomPosition[0] + 1, nextRoomPosition[1] + 1, nextRoomBBox[2] - 2, nextRoomBBox[3] - 2);
		
		if (!abbox_collides(screenBBox, nextRoomBBox))
		{
			// Create the room at the given position
			procGenDesertAddRoom(nextRoomPosition, iRoomSelection);
			// Exit the add loop
			break;
		}
	}
}