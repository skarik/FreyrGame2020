var item = argument0;

item.count -= 1;
if (item.count <= 0)
{
	itemEntryClear(item);
}