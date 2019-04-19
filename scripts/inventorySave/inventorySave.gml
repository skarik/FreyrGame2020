var buffer = argument0;

// belt
buffer_write(buffer, buffer_s32, belt_size);
for (var i = 0; i < belt_size; ++i)
{
	itemEntrySave(buffer, belt[i]);
}
buffer_write(buffer, buffer_s32, belt_selection);

// bag 1
buffer_write(buffer, buffer_s32, seed_size);
for (var i = 0; i < seed_size; ++i)
{
	itemEntrySave(buffer, seed[i]);
}
// bag 2
buffer_write(buffer, buffer_s32, bag_size);
for (var i = 0; i < bag_size; ++i)
{
	itemEntrySave(buffer, bag[i]);
}