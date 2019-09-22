var buffer = argument0;

// belt
belt_size = buffer_read(buffer, buffer_s32);
for (var i = 0; i < belt_size; ++i)
{
	itemEntryLoad(buffer, belt[i]);
}
belt_selection = buffer_read(buffer, buffer_s32);
if (belt_selection < null || belt_selection >= belt_size)
{
	show_error("Corrupted save file.", true);
}

// bag 1
seed_size = buffer_read(buffer, buffer_s32);
for (var i = 0; i < seed_size; ++i)
{
	itemEntryLoad(buffer, seed[i]);
}
// bag 2
bag_size = buffer_read(buffer, buffer_s32);
for (var i = 0; i < bag_size; ++i)
{
	itemEntryLoad(buffer, bag[i]);
}