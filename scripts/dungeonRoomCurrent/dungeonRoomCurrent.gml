/// @function dungeonRoomCurrent()
/// @desc Returns the current dungeon room the player is in.

var pl = getPlayer();
if (exists(pl))
{
	with (o_cameraFocus)
	{
		if (place_meeting(x, y, pl))
		{
			return id;
		}
	}
}

return null;