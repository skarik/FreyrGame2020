/// @function itemEntryInstantiate(x, y, itemEntry)
/// @param x
/// @param y
/// @param itemEntry

var spawnx = argument0;
var spawny = argument1;
var itemEntry = argument2;

repeat (itemEntry.count)
{
	instance_create_depth(spawnx, spawny, 0, itemEntry.object);
}