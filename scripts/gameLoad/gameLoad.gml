var kSaveFile = "Freyr.pl";

if (!file_exists(kSaveFile))
{
    return false;
}
// Load buffer from file
var buf = buffer_load(kSaveFile);

// Create the player
if (!exists(o_PlayerTest)) new(o_PlayerTest);
// Read in the current player state:
var pl = buffer_read(buf, buffer_u32);
if (pl == 0)
{   // Check for valid file
    show_error("INVALID SAVE", true);
    delete(o_PlayerTest);
    return false;
}
else
{   // Set the new player as the player
    pl.m_isPlayer = true; 
}
var target_room = room_get_index(buffer_read(buf, buffer_string));
pl.x            = buffer_read(buf, buffer_u32);
pl.y            = buffer_read(buf, buffer_u32);
// read inventory
with (pl.inventory) {
	inventoryLoad(buf);
}
//pl.facingDir    = buffer_read(buf, buffer_f32);
// load time of day
if (!exists(o_dayNightCycle)) {
	new(o_dayNightCycle);
}
o_dayNightCycle.m_timeOfDay	= buffer_read(buf, buffer_f64);
o_dayNightCycle.m_day		= buffer_read(buf, buffer_f64);

// Read in Game's flags
questLoad(buf);

// Free resources
buffer_delete(buf);

// Move all player objects to the main object
with (o_PlayerTest)
{
    x = pl.x;
    y = pl.y;
    //facingDir = sign(facingDir);
    //if (facingDir == 0) facingDir = 1.0;
}
// Now go to the target room
global._transition_source = null;
transition_to(target_room); 

// Return a successful load
return true;