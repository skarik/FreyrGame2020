/// @function dungeonRoomCurrent()
/// @desc Returns the current dungeon room the player is in.
function dungeonRoomCurrent() {

	var pl = getPlayer();
	if (iexists(pl))
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


}
