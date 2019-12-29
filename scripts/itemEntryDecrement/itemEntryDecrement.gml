var item = argument0;

item.count -= 1;
if (item.count <= 0)
{
	if (item.onDeplete != null && item.onDeplete != itemNullScript)
	{
		script_execute(item.onDeplete, item.object);
	}
	itemEntryClear(item);
}