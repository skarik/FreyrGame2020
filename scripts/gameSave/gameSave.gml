var kSaveFile = "Freyr.pl";

var buf = buffer_create(4096, buffer_grow, 1);

// Write out the current player position
var pl = getPlayer();
if (!exists(pl))
{
    buffer_write(buf, buffer_u32, 0);
    exit;
}

buffer_write(buf, buffer_string, object_get_name(pl.object_index));
buffer_write(buf, buffer_string, room_get_name(room));
buffer_write(buf, buffer_u32, pl.x);
buffer_write(buf, buffer_u32, pl.y);
// write inventory
with (pl.inventory) {
	inventorySave(buf);
}
//buffer_write(buf, buffer_f32, sign(pl.facingDir));
// save time of day
buffer_write(buf, buffer_f64, o_dayNightCycle.m_timeOfDay);
buffer_write(buf, buffer_f64, o_dayNightCycle.m_day);

// Write out Game's flags
questSave(buf);

// Save buffer to file
buffer_save(buf, kSaveFile);

// Free resources
buffer_delete(buf);

