/// @function worldRoomReset()
/// @desc Resets the currently active dungeon room.

var currentDungeonRoom = dungeonRoomCurrent();

if (exists(currentDungeonRoom))
{
	with (o_ptcFootstep)
	{
		if (place_meeting(x, y, currentDungeonRoom))
			delete(this);
	}
	
	with (o_ptcBloodSplatter)
	{
		if (place_meeting(x, y, currentDungeonRoom))
			delete(this);
	}
	
	with (o_chFrogTar)
	{
		if (place_meeting(x, y, currentDungeonRoom))
		{
			visible = true;
			x = xstart;
			y = ystart;
			event_perform(ev_create, 0);
		}
	}
}